// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Apollo",
    products: [
        .library(name: "Apollo", targets: ["Apollo"])
    ],
    dependencies: [
        .package(url: "https://github.com/nschum/SwiftHamcrest", from: "2.2.2")
    ],
    targets: [
        .target(name: "Apollo", dependencies: []),
        .testTarget(name: "ApolloTests", dependencies: ["Apollo", "SwiftHamcrest"])
    ]
)
