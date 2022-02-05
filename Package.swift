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
        .package(name: "Publish", url: "https://github.com/johnsundell/publish.git", from: "0.7.0"),
        .package(name: "SplashPublishPlugin", url: "https://github.com/johnsundell/splashpublishplugin", from: "0.1.0"),
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
