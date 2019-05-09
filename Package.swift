// swift-tools-version:4.2
import PackageDescription

let package = Package(
    name: "wkhtmltopdf",
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .library(
            name: "wkhtmltopdf",
            targets: ["wkhtmltopdf"]),
    ],
    dependencies: [
        .package(url: "https://github.com/vapor/vapor.git", from: "3.0.0")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "wkhtmltopdf",
            dependencies: [
                "Vapor"
            ]),
        .testTarget(
            name: "wkhtmltopdfTests",
            dependencies: ["wkhtmltopdf"]),
    ]
)
