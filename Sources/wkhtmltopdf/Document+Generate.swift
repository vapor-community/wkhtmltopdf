import Foundation
import Service

extension Document {

    public func generatePDF(on container: Container) throws -> Future<Data> {
        let sharedThreadPool = try container.make(BlockingIOThreadPool.self)

        return sharedThreadPool.runIfActive(eventLoop: container.eventLoop) { () -> Data in
            let fileManager = FileManager.default
            // Create the temp folder if it doesn't already exist
            let workDir = "/tmp/vapor-wkhtmltopdf"
            try fileManager.createDirectory(atPath: workDir, withIntermediateDirectories: true)
            // Save input pages to temp files, and build up args to wkhtmltopdf
            var wkArgs: [String] = [
                "--zoom", self.zoom,
                "--quiet",
                "-s", self.paperSize,
                "-T", "\(self.topMargin)mm",
                "-R", "\(self.rightMargin)mm",
                "-B", "\(self.bottomMargin)mm",
                "-L", "\(self.leftMargin)mm",
            ]

            let pageFiles: [String] = try self.pages.map { page in
                let name = UUID().uuidString + ".html"
                let filename = "\(workDir)/\(name)"
                try page.content.write(to: URL(fileURLWithPath: filename))
                return filename
            }
            defer {
                try? pageFiles.forEach(fileManager.removeItem)
            }

            wkArgs += pageFiles
            // Call wkhtmltopdf and retrieve the result data
            let wk = Process()
            let stdout = Pipe()
            wk.launchPath = "/usr/local/bin/wkhtmltopdf"
            wk.arguments = wkArgs
            wk.arguments?.append("-") // output to stdout
            wk.standardOutput = stdout
            wk.launch()
            let pdf = stdout.fileHandleForReading.readDataToEndOfFile()
            return pdf
        }
    }
}
