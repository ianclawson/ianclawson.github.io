//
//  MyHTMLFactory.swift
//  
//
//  Created by Ian Clawson on 2/5/22.
//

import Foundation
import Publish
import Plot

extension Theme where Site == IanClawsonDev {
    static var myTheme: Self {
        Theme(
            htmlFactory: MyHTMLFactory(),
            resourcePaths: ["Resources/css/styles.css"])
    }
}

struct MyHTMLFactory: HTMLFactory {
    func makeIndexHTML(for index: Index, context: PublishingContext<IanClawsonDev>) throws -> HTML {
        HTML(
            .lang(context.site.language),
            .head(for: index, on: context.site),
            .body {
                SiteHeader(context: context, selectedSelectionID: nil)
                Wrapper {
                    H1(index.title)
                    Paragraph(context.site.description)
                        .class("description")
                    H2("Latest content")
                    ItemList(
                        items: context.allItems(
                            sortedBy: \.date,
                            order: .descending
                        ),
                        site: context.site
                    )
                }
                SiteFooter()
            }
        )
        
//        HTML {
//
//            H2("People")
//
//            // Passing our array directly to List:
//            List(context.sections.) { name in
//                ListItem(name).class("name")
//            }
//
//            // Using a manual for loop within a List closure:
//            List {
//                for name in names {
//                    ListItem(name).class("name")
//                }
//            }
//        }
        
//        HTML(
//            .lang(context.site.language),
//            .head(for: context.site),
//            .body(
//                .grid(
//                    .header(for: context.site),
//                    .sidebar(for: context.site),
//                    .posts(
//                        for: context.allItems(
//                            sortedBy: \.date,
//                            order: .descending
//                        ),
//                        on: context.site,
//                        title: "Recent posts"
//                    ),
//                    .footer(for: context.site)
//                )
//            )
//        )
    }
    
    func makeSectionHTML(for section: Section<IanClawsonDev>, context: PublishingContext<IanClawsonDev>) throws -> HTML {
        HTML(
            .lang(context.site.language),
            .head(for: section, on: context.site),
            .body {
                SiteHeader(context: context, selectedSelectionID: section.id)
                Wrapper {
                    H1(section.title)
                    ItemList(items: section.items, site: context.site)
                }
                SiteFooter()
            }
        )
    }

    func makeItemHTML(for item: Item<IanClawsonDev>, context: PublishingContext<IanClawsonDev>) throws -> HTML {
        HTML(
            .lang(context.site.language),
            .head(for: item, on: context.site),
            .body(
                .class("item-page"),
                .components {
                    SiteHeader(context: context, selectedSelectionID: item.sectionID)
                    Wrapper {
                        Article {
                            Div(item.content.body).class("content")
                            Span("Tagged with: ")
                            ItemTagList(item: item, site: context.site)
                        }
                    }
                    SiteFooter()
                }
            )
        )
    }

    func makePageHTML(for page: Page, context: PublishingContext<IanClawsonDev>) throws -> HTML {
        HTML(
            .lang(context.site.language),
            .head(for: page, on: context.site),
            .body {
                SiteHeader(context: context, selectedSelectionID: nil)
                Wrapper(page.body)
                SiteFooter()
            }
        )
//        HTML(
//            .lang(context.site.language),
//            .head(for: context.site),
//            .body(
//                .grid(
//                    .header(for: context.site),
//                    .sidebar(for: context.site),
//                    .page(for: page, on: context.site),
//                    .footer(for: context.site)
//                )
//            )
//        )
    }

    func makeTagListHTML(for page: TagListPage, context: PublishingContext<IanClawsonDev>) throws -> HTML? {
        HTML(
            .lang(context.site.language),
            .head(for: page, on: context.site),
            .body {
                SiteHeader(context: context, selectedSelectionID: nil)
                Wrapper {
                    H1("Browse all tags")
                    List(page.tags.sorted()) { tag in
                        ListItem {
                            Link(tag.string,
                                 url: context.site.path(for: tag).absoluteString
                            )
                        }
                        .class("tag")
                    }
                    .class("all-tags")
                }
                SiteFooter()
            }
        )
//        HTML(
//            .lang(context.site.language),
//            .head(for: context.site),
//            .body(
//                .grid(
//                    .header(for: context.site),
//                    .sidebar(for: context.site),
//                    .pageContent(
//                        .tagList(for: page, on: context.site)
//                    ),
//                    .footer(for: context.site)
//                )
//            )
//        )
    }
//
    func makeTagDetailsHTML(for page: TagDetailsPage, context: PublishingContext<IanClawsonDev>) throws -> HTML? {
        HTML(
            .lang(context.site.language),
            .head(for: page, on: context.site),
            .body {
                SiteHeader(context: context, selectedSelectionID: nil)
                Wrapper {
                    H1 {
                        Text("Tagged with ")
                        Span(page.tag.string).class("tag")
                    }

                    Link("Browse all tags",
                        url: context.site.tagListPath.absoluteString
                    )
                    .class("browse-all")

                    ItemList(
                        items: context.items(
                            taggedWith: page.tag,
                            sortedBy: \.date,
                            order: .descending
                        ),
                        site: context.site
                    )
                }
                SiteFooter()
            }
        )
//        HTML(
//            .lang(context.site.language),
//            .head(for: context.site),
//            .body(
//                .grid(
//                    .header(for: context.site),
//                    .sidebar(for: context.site),
//                    .posts(
//                        for: context.items(
//                            taggedWith: page.tag,
//                            sortedBy: \.date,
//                            order: .descending
//                        ),
//                        on: context.site,
//                        title: "\(page.tag.string.capitalized) posts"
//                    ),
//                    .footer(for: context.site)
//                )
//            )
//        )
    }
}

private struct Wrapper: ComponentContainer {
    @ComponentBuilder var content: ContentProvider

    var body: Component {
        Div(content: content).class("wrapper")
    }
}

private struct SiteHeader<Site: Website>: Component {
    var context: PublishingContext<Site>
    var selectedSelectionID: Site.SectionID?

    var body: Component {
        Header {
            Wrapper {
                Link(context.site.name, url: "/")
                    .class("site-name")

                if Site.SectionID.allCases.count > 1 {
                    navigation
                }
            }
        }
    }

    private var navigation: Component {
        Navigation {
            List(Site.SectionID.allCases) { sectionID in
                let section = context.sections[sectionID]

                return Link(section.title,
                    url: section.path.absoluteString
                )
                .class(sectionID == selectedSelectionID ? "selected" : "")
            }
        }
    }
}

private struct ItemList<Site: Website>: Component {
    var items: [Item<Site>]
    var site: Site

    var body: Component {
        List(items) { item in
            Article {
                H1(Link(item.title, url: item.path.absoluteString))
                ItemTagList(item: item, site: site)
                Paragraph(item.description)
            }
        }
        .class("item-list")
    }
}

private struct ItemTagList<Site: Website>: Component {
    var item: Item<Site>
    var site: Site

    var body: Component {
        List(item.tags) { tag in
            Link(tag.string, url: site.path(for: tag).absoluteString)
        }
        .class("tag-list")
    }
}

private struct SiteFooter: Component {
    var body: Component {
        Footer {
            Paragraph {
                Text("Generated using ")
                Link("Publish", url: "https://github.com/johnsundell/publish")
            }
            Paragraph {
                Link("RSS feed", url: "/feed.rss")
            }
        }
    }
}
