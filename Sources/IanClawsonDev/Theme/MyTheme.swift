//
//  MyTheme.swift
//  
//
//  Created by Ian Clawson on 2/5/22.
//

import Foundation
import Publish
import Plot

/// theme feels like a misnomer to me as it's not a color/asset pallet but the entire HTML later
/// if Publish dependency-injected your WebsiteItemMetadata here instead of having the the HTML
/// functions fetch the data then I could see it, but I digress, publish is still the best
extension Theme where Site == IanClawsonDev {
    static var myTheme: Self {
        Theme(
            htmlFactory: MyHTMLFactory(),
            resourcePaths: ["Resources/css/styles.css"])
    }
}
