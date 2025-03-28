import Foundation

extension Document {
    public func generatePDF() async throws -> Data {
        let fileManager = FileManager.default

        let workDir = "/tmp/vapor-wkhtmltopdf"
        try fileManager.createDirectory(atPath: workDir, withIntermediateDirectories: true)

        var wkArgs: [String] = globalArguments()

        let pageFiles: [String] = try pages.enumerated().map { index, page in
            if page.isUrl, let url = page.url {
                let pageArgs = page.toArguments()
                wkArgs.append(contentsOf: pageArgs.filter { $0 != url })
                return url
            } else {
                let name = "page_\(index)_\(UUID().uuidString).html"
                let filename = "\(workDir)/\(name)"
                try page.content.write(to: URL(fileURLWithPath: filename))

                wkArgs.append(contentsOf: page.toArguments())

                return filename
            }
        }

        defer {
            for file in pageFiles {
                if !file.hasPrefix("http") && !file.hasPrefix("https") {
                    try? fileManager.removeItem(atPath: file)
                }
            }
        }

        wkArgs.append(contentsOf: page(pageArgs: pageFiles))

        return try await withCheckedThrowingContinuation { continuation in
            let wk = Process()
            let stdout = Pipe()
            wk.executableURL = URL(fileURLWithPath: self.launchPath)
            wk.arguments = wkArgs
            wk.arguments?.append("-")
            wk.standardOutput = stdout

            let stderr = Pipe()
            wk.standardError = stderr

            wk.terminationHandler = { process in
                if process.terminationStatus == 0 {
                    let pdf = stdout.fileHandleForReading.readDataToEndOfFile()
                    continuation.resume(returning: pdf)
                } else {
                    let errorData = stderr.fileHandleForReading.readDataToEndOfFile()
                    let errorMessage = String(data: errorData, encoding: .utf8) ?? "Unknown error"
                    continuation.resume(throwing: PDFGenerationError.processFailed(message: errorMessage))
                }
            }

            do {
                try wk.run()
            } catch {
                continuation.resume(throwing: error)
            }
        }
    }

    private func page(pageArgs: [String]) -> [String] {
        var pages = [String]()
        for arg in pageArgs {
            if arg.hasPrefix("http") || arg.hasPrefix("https") || arg.hasSuffix(".html") {
                pages.append(arg)
            }
        }
        return pages
    }

    enum PDFGenerationError: Error {
        case processFailed(message: String)
    }
}
