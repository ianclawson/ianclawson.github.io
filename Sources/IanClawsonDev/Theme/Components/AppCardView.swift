//
//  File.swift
//  
//
//  Created by Ian Clawson on 2/24/22.
//

import Foundation
import Publish
import Plot

struct AppCardView: Component {
    
    var item: Item<IanClawsonDev>
    
    func bannerImage() -> String {
        if let imagePath = item.metadata.appBannerImagePath {
            return
"""
<img class="h-48 w-full object-cover" src="\(imagePath)" alt="">
"""
        }
        return ""
    }
    
    var body: Component {
        Node<Any>.raw(
"""
<div class="app-card-view flex flex-col rounded-lg shadow-lg overflow-hidden my-10">
      <a href="\(item.path.absoluteString)">
<div class="flex-shrink-0">
    \(
               bannerImage()
)
  </div>
  <div class="flex-1 p-6 flex flex-col justify-between">
    <div class="flex-1">
      <p class="text-sm font-medium text-indigo-600 mb-2">
      \(item.metadata.itemCategory?.rawValue ?? IanClawsonDev.ItemMetadata.ItemCategory.mobileApp.rawValue)
      </p>
      
        <p class="text-xl font-semibold">
        \(item.metadata.itemName ?? item.title)
        </p>
        <p class="mt-3 text-base text-gray-500">
        \(item.description)
        </p>
      
    </div>
  </div>
</a>
</div>
"""
        )
    }
}
