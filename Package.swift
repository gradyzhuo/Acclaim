// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Acclaim",
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "Acclaim",
            targets: ["Acclaim"]
        ),
        .library(
            name: "Procedure",
            targets: ["Procedure"]
        ),
        .executable(
            name: "LoggerDemo",
            targets: ["Demo"]
        )
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        .package(url: "https://github.com/apple/swift-log.git", from: "1.0.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "Acclaim",
            dependencies: []
        ),
        .testTarget(
            name: "AcclaimTests",
            dependencies: ["Acclaim"]
        ),
        .target(
            name: "Logger",
            dependencies: [
                .product(name: "Logging", package: "swift-log"),
                .target(name: "ShellHelper")
            ]
        ),
        .target(
            name: "ShellHelper",
            dependencies: []
        ),
        .target(
            name: "Demo",
            dependencies: [
                .target(name: "Logger"),
            ]
        ),
        .target(
            name: "Procedure",
            dependencies: []
        ),
        .testTarget(
            name: "ProcedureTests",
            dependencies: ["Procedure"]
        )
    ]
)
