// swift-tools-version:4.2
import PackageDescription

let package = Package(
    name: "wkhtmltopdf",
    products: [
        .library(
            name: "wkhtmltopdf",
            targets: ["wkhtmltopdf"]),
    ],
    dependencies: [
        .package(url: "https://github.com/vapor/vapor.git", from: "3.0.0"),
        .package(url: "https://github.com/vapor/service.git", from: "1.0.0")
    ],
    targets: [
        .target(
            name: "wkhtmltopdf",
            dependencies: [
                "Service"
            ]),
        .testTarget(
            name: "wkhtmltopdfTests",
            dependencies: ["wkhtmltopdf", "Vapor"]),
    ]
)
