//
//  AppPageHeaderView.swift
//  
//
//  Created by Ian Clawson on 2/24/22.
//

import Foundation
import Publish
import Plot

struct AppPageHeaderView: Component {
    var topLevelItem: Item<IanClawsonDev>
    
    var body: Component {
        Node<Any>.raw(
"""
<div class="max-w-7xl mx-auto py-16 px-4 sm:py-24 sm:px-6 lg:px-8">
    <div class="text-center">
        <h2 class="text-base font-semibold text-indigo-600 tracking-wide uppercase">\( topLevelItem.metadata.itemCategory?.rawValue ?? IanClawsonDev.ItemMetadata.ItemCategory.mobileApp.rawValue )</h2>
        <p class="mt-1 text-4xl font-extrabold sm:text-5xl sm:tracking-tight lg:text-6xl">\( topLevelItem.metadata.itemName ?? "oops" )</p>
        <p class="max-w-xl mt-5 mx-auto text-xl text-gray-500">\( topLevelItem.description )</p>
        </br>
        <a href="\( topLevelItem.metadata.appStoreURL ?? "/")" class="text-base font-semibold text-indigo-500 hover:text-indigo-700">Get on the App Store</a>
    </div>
</div>
"""
        )
    }
}
