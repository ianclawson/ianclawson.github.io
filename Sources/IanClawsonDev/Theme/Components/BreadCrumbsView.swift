//
//  BreadCrumbsView.swift
//  
//
//  Created by Ian Clawson on 2/24/22.
//

import Foundation
import Publish
import Plot

// TODO:
// right now bread crumbs is an exteremely basic implementation that
// 1. assumes the first item is home, and
// 2. assumes the second item is the app page
// I bet we can make this more dyanmic with some kind of breadcrumb object, but this does the job for now

struct BreadCrumbsView: Component {
    var item: Item<IanClawsonDev>
    
    func innerString() -> String {
        
        var htmlString = ""
        
        for (index, crumb) in item.metadata.crumbs.enumerated() {
            if index == 0 {
                htmlString +=
"""
          <li>
            <div>
              <a href="/" class="text-sm font-medium text-gray-500 hover:text-gray-700">\(crumb)</a>
            </div>
          </li>
"""
            } else {
                htmlString +=
"""
          <li>
            <div class="flex items-center">
              <!-- Heroicon name: chevron-right -->
              <svg class="flex-shrink-0 h-5 w-5 text-gray-400" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor" aria-hidden="true">
                <path fill-rule="evenodd" d="M7.293 14.707a1 1 0 010-1.414L10.586 10 7.293 6.707a1 1 0 011.414-1.414l4 4a1 1 0 010 1.414l-4 4a1 1 0 01-1.414 0z" clip-rule="evenodd" />
              </svg>
              <a href="\(item.path.absoluteString)/" class="ml-3 text-sm font-medium text-gray-500 hover:text-gray-700">\(crumb)</a>
            </div>
          </li>
"""
            }
        }
        return htmlString
    }
    
    var body: Component {
        Node<Any>.raw(
"""
<div class="py-4">
  <div>
    <nav class="sm:hidden" aria-label="Back">
      <a href="/" class="flex items-center text-sm font-medium text-gray-500 hover:text-gray-700">
        <!-- Heroicon name: chevron-left -->
        <svg class="flex-shrink-0 -ml-1 mr-1 h-5 w-5 text-gray-400" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor" aria-hidden="true">
          <path fill-rule="evenodd" d="M12.707 5.293a1 1 0 010 1.414L9.414 10l3.293 3.293a1 1 0 01-1.414 1.414l-4-4a1 1 0 010-1.414l4-4a1 1 0 011.414 0z" clip-rule="evenodd" />
        </svg>
        Back
      </a>
    </nav>
    <nav class="hidden sm:flex" aria-label="Breadcrumb">
      <ol class="flex items-center space-x-4">
        \(innerString())
      </ol>
    </nav>
  </div>
  <!-- <div class="mt-2 md:flex md:items-center md:justify-between">
    <div class="flex-1 min-w-0">
      <h2 class="text-2xl font-bold leading-7 text-gray-900 sm:text-3xl sm:truncate">
          \(item.metadata.itemName)/
      </h2>
    </div>
      <div class="mt-4 flex-shrink-0 flex md:mt-0 md:ml-4">
        <button type="button" class="inline-flex items-center px-4 py-2 border border-gray-300 rounded-md shadow-sm text-sm font-medium text-gray-700 bg-white hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500">
          Edit
        </button>
        <button type="button" class="ml-3 inline-flex items-center px-4 py-2 border border-transparent rounded-md shadow-sm text-sm font-medium text-white bg-indigo-600 hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500">
          Publish
        </button>
      </div>
  </div> -->
</div>
"""
        )
    }
}
