//
//  File.swift
//  
//
//  Created by Ian Clawson on 2/5/22.
//

import Foundation
import Plot

// not in use just yet, here as a reference until I figure out what I want

struct NewsArticle: Component {
    var imagePath: String
    var title: String
    var description: String

    var body: Component {
        Article {
            Node.h2(.text(title))
            Image(url: imagePath, description: "Header image")
            H1(title)
            Span(description).class("description")
        }
        .class("news")
    }
}

func newsArticlePage(for article: NewsArticle) -> HTML {
    return HTML(.body(
        .div(
            .class("wrapper"),
            .component(article)
        )
    ))
}


//
//struct NewsArticle: Component {
//    var imagePath: String
//    var title: String
//    var description: String
//
//    var body: Component {
//        Article {
//            Image(url: imagePath, description: "Header image")
//            H1(title)
//            Span(description).class("description")
//        }
//        .class("news")
//    }
//}
//
//func newsArticlePage(for article: NewsArticle) -> HTML {
//    return HTML(.body(
//        .div(
//            .class("wrapper"),
//            .component(article)
//        )
//    ))
//}
