//
//  AppPageContentView.swift
//  
//
//  Created by Ian Clawson on 2/24/22.
//

import Foundation
import Publish
import Plot

struct AppPageContentView: Component {
    var item: Item<IanClawsonDev>
    
    var body: Component {
        
//        Div(item.content.body).class("content")
        Node<Any>.raw(
"""
<div class="text-left prose sm:prose lg:prose-lg xl:prose-xl mx-auto">
  \(item.content.body.html)
</div>
"""
        )
    }
}
