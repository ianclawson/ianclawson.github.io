//
//  File.swift
//  
//
//  Created by Ian Clawson on 2/21/22.
//

import Foundation
import Plot

struct AppListView: Component {
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
                    // TODO: app list here
                }
                .class("mt-12 max-w-lg mx-auto grid gap-5 lg:grid-cols-1 lg:max-w-none")
            }
            .class("max-w-7xl mx-auto")
        }
        .class("bg-gray pt-16 pb-20 px-4 sm:px-6 lg:pt-24 lg:pb-28 lg:px-8")
    }
}


struct AppCardView: Component {
    
    // TODO: flesh this all out
    
    var body: Component {
        Div(html:
"""
<div class="flex-shrink-0">
    {% if app.image_url %}
    <img class="h-48 w-full object-cover" src="{{ app.image_url }}" alt="">
    {% else %}
    <img class="h-48 w-full object-cover" src="https://images.unsplash.com/photo-1496128858413-b36217c2ce36?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1679&q=80" alt="">
    {% endif %}
    
  </div>
  <div class="flex-1 bg-white p-6 flex flex-col justify-between">
    <div class="flex-1">
      <p class="text-sm font-medium text-indigo-600">
      {% if app.type %}
        {{ app.type }}
      {% else %}
        Mobile App
      {% endif %}
      </p>
      {% if app.web_url %}
      <a href="{{ app.web_url }}" class="block mt-2">
      {% elsif app.url %}
      <a href="{{ site.baseurl }}{{ app.url }}" class="block mt-2">
      {% else %}
      <a href="#" class="block mt-2">
      {% endif %}
        <p class="text-xl font-semibold">
        {{ app.title }}
        </p>
        <p class="mt-3 text-base text-gray-500">
        {{ app.description }}
        </p>
      </a>
    </div>
  </div>
"""
        )
        .class("flex flex-col rounded-lg shadow-lg overflow-hidden")
    }
}
