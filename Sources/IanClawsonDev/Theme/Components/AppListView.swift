//
//  File.swift
//  
//
//  Created by Ian Clawson on 2/21/22.
//

import Foundation
import Publish
import Plot

struct AppListView: Component {
    
    var items: [Item<IanClawsonDev>]
    var site: IanClawsonDev
    
    var body: Component {
        Div {
            Div {
                Div {
                    H2("Public Apps and Projects")
                        .class("text-3xl font-extrabold tracking-tight sm:text-4xl")
                    Paragraph("Built with ❤️ by me. Some commercial, some just because.")
                        .class("mt-3 max-w-2xl mx-auto text-xl text-gray-500 sm:mt-4")
                }
                .class("text-center")
                Div {
                    List(items.filter { $0.isPublished }) { item in
                        AppCardView(item: item)
                    }
                }
                .class("mt-12 max-w-lg mx-auto grid gap-5 lg:grid-cols-1 lg:max-w-none")
            }
            .class("max-w-7xl mx-auto")
        }
        .class("app-list-view pt-16 pb-20 px-4 sm:px-6 lg:pt-24 lg:pb-28 lg:px-8")
    }
}
