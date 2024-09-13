// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MediaProvider",
    platforms: [.iOS(.v16)],
    products: [
        .library(name: "MediaProvider", targets: ["MediaProvider"]),
    ],
    dependencies: [
        .package(url: "https://github.com/jellyfin/jellyfin-sdk-swift.git", from: "0.4.0"),
    ],
    targets: [
        .target(
            name: "MediaProvider",
            dependencies: [
                .product(name: "JellyfinAPI", package: "jellyfin-sdk-swift"),
            ]
        ),
    ]
)
