//
//  AppPageSectionTabs.swift
//  
//
//  Created by Ian Clawson on 2/24/22.
//

import Foundation
import Publish
import Plot

extension Item where Site == IanClawsonDev {
    var sectionTabSortIndex: Int {
        let sectionOrder: [IanClawsonDev.ItemMetadata.AppItemSubsection] = [
            .details,
            .privacyPolicy,
            .contact,
            .noneOrParent
            
        ]
        return sectionOrder.firstIndex(of: self.metadata.itemAppSubsection) ?? 0
    }
}

struct AppPageSectionTabs: Component {
    var currentSection: Item<IanClawsonDev>
    var subsections: [Item<IanClawsonDev>]

    
    func innerHTML() -> String {
        
        
        
        
        
        var htmlString = ""
        
        for subsection in subsections.sorted(by: { $0.sectionTabSortIndex < $1.sectionTabSortIndex }) {
            if currentSection == subsection {
                htmlString +=
"""
      <!-- Current: "border-indigo-500 text-indigo-600", Default: "border-transparent text-gray-500 hover:text-gray-700 hover:border-gray-300" -->
        <a href="\( subsection.path.absoluteString )" class="border-indigo-500 text-indigo-600 w-1/\(subsections.count) py-4 px-1 text-center border-b-2 font-medium text-sm" aria-current="page">
          \( subsection.title )
        </a>
"""
            } else {
                htmlString +=
"""
        <a href="\( subsection.path.absoluteString )" class="border-transparent text-gray-500 hover:text-gray-700 hover:border-gray-300 w-1/\(subsections.count) py-4 px-1 text-center border-b-2 font-medium text-sm">
          \( subsection.title )
        </a>
"""
            }
        }
        
        return htmlString
    }
    
    var body: Component {
        Node<Any>.raw(
"""
<div class="border-b border-gray-200">
  <nav class="-mb-px flex" aria-label="Tabs">
    \(innerHTML())
  </nav>
</div>
"""
        )
    }
}
