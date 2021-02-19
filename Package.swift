// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "qrAfipGenerator",
    platforms: [
            .macOS(.v10_15),
        ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .package(url: "https://github.com/SwiftyJSON/SwiftyJSON.git", from: "5.0.0")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "qrAfipGenerator",
            dependencies: [.target(name: "QRCore")]),
        .target(name: "QRCore",
                dependencies: [.target(name: "FunctionalUtils"), "SwiftyJSON"]),
        .target(name: "FunctionalUtils"),
        
        .testTarget(
            name: "qrAfipGeneratorTests",
            dependencies: ["qrAfipGenerator"]),
    ]
)
