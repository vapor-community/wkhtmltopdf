// swift-tools-version:5.2
import PackageDescription

let package = Package(
    name: "wkhtmltopdf",
    products: [
        .library(
            name: "wkhtmltopdf",
            targets: ["wkhtmltopdf"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-nio.git", from: "2.13.1"),
    ],
    targets: [
        .target(
            name: "wkhtmltopdf",
            dependencies: [
                .product(name: "NIO", package: "swift-nio")
            ]
        ),
        .testTarget(
            name: "wkhtmltopdfTests",
            dependencies: ["wkhtmltopdf"]
        ),
    ]
)
