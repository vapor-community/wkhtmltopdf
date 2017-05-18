import PackageDescription

let package = Package(
    name: "wkhtmltopdf",
    dependencies: [
        .Package(url: "https://github.com/vapor/vapor.git", majorVersion: 2),
    ]
)
