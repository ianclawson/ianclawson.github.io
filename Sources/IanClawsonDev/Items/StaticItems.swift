//
//  File.swift
//  
//
//  Created by Ian Clawson on 2/5/22.
//

import Foundation
import Publish

struct StaticItems { }

extension StaticItems {
    // I like this, but unclear if I can pull in the associated markdown files this way yet
    static var TestItem = Item<IanClawsonDev>(
        path: "test-item-app/asdf",
        sectionID: .apps,
        metadata: .init(
            itemAppSection: .test,
            itemAppSubsection: .noneOrParent,
            itemAppSubsections: [.details, .privacyPolicy],
            itemName: "My Test App",
            itemCategory: .mobileApp,
            appStoreURL: "https://apps.apple.com/us/app/stars-2-apples/id1452027163",
            appExternalWebsiteURL: "https://www.stars2apples.com",
            appReleaseDate: (try? Date("2019-02-27 21:04", strategy: Date.ParseStrategy.yolo)) ?? Date(),
            appReleaseDateFormatted: "Feb 27, 2019 at 9:04 PM",
            published: false,
            crumbs: ["Home", "Stars 2 Apples"]),
        tags: [
            .init("article")
        ],
        content: Content(
            title: "My Test App",
            description: "The city that never sleeps.")
    )
}
