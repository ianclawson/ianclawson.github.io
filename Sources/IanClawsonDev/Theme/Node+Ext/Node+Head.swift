//
//  Node+Head.swift
//
//
//  Created by Ian Clawson on 2/6/22.
//

import Plot
import Publish

// a handy helper override for the head node so they my stylesheetPaths are all passed in neatly
extension Node where Context == HTML.DocumentContext {
    static func head(
        for location: Location,
        inMySite site: IanClawsonDev
    ) -> Node {
        return head(for: location, on: site, stylesheetPaths: IanClawsonDev.headStylesheets)
    }
}
