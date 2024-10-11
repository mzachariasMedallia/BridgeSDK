// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.
//  
//  Copyright © 2023 Medallia. Use subject to licensing terms.

import PackageDescription

let package = Package(
    name: "BridgeSDK",
    platforms: [
        .iOS(.v11)
    ],
    products: [
        .library(
            name: "BridgeSDK",
            targets: ["BridgeSDK"]),
    ],
    targets: [
        .binaryTarget(
            name: "BridgeSDK",
            path: "BridgeSDK.xcframework"
        )
    ]
)
