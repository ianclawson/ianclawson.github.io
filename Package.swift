// swift-tools-version:5.2

import PackageDescription

let package = Package(
    name: "IanClawsonDev",
    platforms: [
        .macOS("12.0")
    ],
    products: [
        .executable(
            name: "IanClawsonDev",
            targets: ["IanClawsonDev"]
        )
    ],
    dependencies: [
        .package(name: "Publish", url: "https://github.com/johnsundell/publish.git", from: "0.7.0"),
        .package(name: "SplashPublishPlugin", url: "https://github.com/johnsundell/splashpublishplugin", from: "0.1.0"),
        
//            .package(
//                name: "Publish",
//                url: "https://github.com/johnsundell/publish.git",
//                .branch("swift-concurrency")),
//            .package(
//                name: "SplashPublishPlugin",
//                url: "https://github.com/johnsundell/splashpublishplugin",
//                .branch("swift-concurrency")),
    ],
    targets: [
        .target(
            name: "IanClawsonDev",
            dependencies: [
                "Publish",
                "SplashPublishPlugin"
            ]
        )
    ]
    /*
     scripts:
     - publish new // make a new site
     - publush run // run locally
     - publish deploy // deploy
     */
)
