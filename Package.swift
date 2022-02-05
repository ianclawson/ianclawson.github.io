// swift-tools-version:5.2

import PackageDescription

let package = Package(
    name: "IanClawsonDev",
    products: [
        .executable(
            name: "IanClawsonDev",
            targets: ["IanClawsonDev"]
        )
    ],
    dependencies: [
        .package(
            name: "Publish",
            url: "https://github.com/johnsundell/publish.git",
            .branch("swift-concurrency")),
        .package(
            name: "SplashPublishPlugin",
            url: "https://github.com/johnsundell/splashpublishplugin",
            .branch("swift-concurrency")),
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
