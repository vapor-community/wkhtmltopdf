import Foundation
import Core

#if os(Linux) && !swift(>=3.1)
typealias Process = Task
#endif

extension Document {

  public func generatePDF() throws -> Bytes {
    // Create the temp folder if it doesn't already exist
    let workDir = "/tmp/vapor-wkhtmltopdf"
    try FileManager().createDirectory(atPath: workDir, withIntermediateDirectories: true)
    // Save input pages to temp files, and build up args to wkhtmltopdf
    var wkArgs: [String] = [
      "--zoom", Document.zoom,
      "--quiet",
      "-s", paperSize,
      "-T", "\(topMargin)mm",
      "-R", "\(rightMargin)mm",
      "-B", "\(bottomMargin)mm",
      "-L", "\(leftMargin)mm",
    ]
    let fm = DataFile(workDir: workDir)
    let pageFiles: [String] = try pages.map { page in
      let fileName = "\(workDir)/\(UUID().uuidString).html"
      try fm.write(page.content, to: fileName)
      return fileName
    }
    defer {
      pageFiles.forEach { path in
        try? fm.delete(at: path)
      }
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
    return pdf.makeBytes()
  }

}
