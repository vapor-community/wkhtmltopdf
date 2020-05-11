import Foundation
import NIO

extension Document {

    public func generatePDF(on threadPool: NIOThreadPool = NIOThreadPool(numberOfThreads: 1), eventLoop: EventLoop) throws -> EventLoopFuture<Data> {
        return threadPool.runIfActive(eventLoop: eventLoop) {
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
            
            wkArgs += self.wkArgs
            
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
            wk.launchPath = self.launchPath
            wk.arguments = wkArgs
            wk.arguments?.append("-") // output to stdout
            wk.standardOutput = stdout
            wk.launch()
            
            let pdf = stdout.fileHandleForReading.readDataToEndOfFile()
            return pdf
        }
    }
}
