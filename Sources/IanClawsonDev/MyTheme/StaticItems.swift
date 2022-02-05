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
    static var TestItem = Item<IanClawsonDev>(
        path: "test-item-app",
        sectionID: .apps,
        metadata: .init(
            itemSectionCollection: "appsection-test",
            itemSections: ["details", "privacy-policy"],
            itemName: "My Test App",
            itemType: .mobileApp,
            appStoreURL: "https://apps.apple.com/us/app/stars-2-apples/id1452027163",
            appExternalWebsiteURL: "https://www.stars2apples.com",
            appReleaseDate: (try? Date("2019-02-27 21:04", strategy: Date.ParseStrategy.yolo)) ?? Date(),
            appReleaseDateFormatted: "Feb 27, 2019 at 9:04 PM",
            published: true,
            crumbs: ["Home", "Stars 2 Apples"]),
        tags: [
            .init("article")
        ],
        content: Content(
            title: "My Test App",
            description: "The city that never sleeps.")
    )
}
