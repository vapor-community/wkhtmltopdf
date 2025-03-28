// swift-tools-version:6.0
import PackageDescription

let package = Package(
    name: "wkhtmltopdf",
    platforms: [
        .macOS(.v13)
    ],
    products: [
        .library(
            name: "wkhtmltopdf",
            targets: ["wkhtmltopdf"]
        )
    ],
    targets: [
        .target(
            name: "wkhtmltopdf"
        ),
        .testTarget(
            name: "wkhtmltopdfTests",
            dependencies: ["wkhtmltopdf"]
        ),
    ]
)
