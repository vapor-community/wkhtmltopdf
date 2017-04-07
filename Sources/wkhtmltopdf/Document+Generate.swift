import Foundation

#if os(Linux) && !swift(>=3.1)
typealias Process = Task
#endif

extension Document {

  public func generatePDF() throws -> Data {
    // Save input pages to temp files, and build up args to wkhtmltopdf
    var wkArgs: [String] = [
      "--zoom", "1.3", // NOTE: this may need changing in different deployments
      "--quiet",
      "-s", paperSize,
      "-T", "\(topMargin)mm",
      "-R", "\(rightMargin)mm",
      "-B", "\(bottomMargin)mm",
      "-L", "\(leftMargin)mm",
    ]
    let pageFiles: [String] = try pages.map { page in
      let fileName = "/tmp/vapor-wkhtmltopdf." + UUID().uuidString + ".html"
      try page.content.write(toFile: fileName, atomically: false, encoding: .utf8)
      return fileName
    }
    defer {
      let fm = FileManager()
      pageFiles.forEach { path in
        try? fm.removeItem(atPath: path)
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
    return pdf
  }

}
