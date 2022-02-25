//
//  HTMLFactory.swift
//  
//
//  Created by Ian Clawson on 2/22/22.
//

import Foundation
import Publish
import Plot

struct MyHTMLFactory: HTMLFactory {
    func makeIndexHTML(for index: Index, context: PublishingContext<IanClawsonDev>) throws -> HTML {
        HTML(
            .lang(context.site.language),
//            .head(for: index, on: context.site),
            .head(for: index, inMySite: context.site),
            .body {
//                SiteHeader(context: context, selectedSelectionID: nil)
                
                
                Wrapper {
                    MeView()
                    AppListView(
                        items: context.allMyTopLevelItems(
                            sortedBy: \.date,
                            order: .descending
                        ),
                        site: context.site
                    )
//                    ItemList(
//                        items: context.allMyTopLevelItems(
//                            sortedBy: \.date,
//                            order: .descending
//                        ),
//                        site: context.site
//                    )
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
            .head(for: section, inMySite: context.site),
            .body {
                SiteHeader(context: context, selectedSelectionID: section.id)
                Wrapper {
                    H1(section.title)
                    ItemList(items: context.myTopLevelItems(for: section), site: context.site)
                }
                SiteFooter()
            }
        )
    }

    /// make the html for page that's an item in a section
    /// i.e. `/apps/geosizer`, `/apps/stars-2-apples`, etc.
    /// also handled subsections like `/apps/geosizer/details`
    func makeItemHTML(for item: Item<IanClawsonDev>, context: PublishingContext<IanClawsonDev>) throws -> HTML {
        
        // if the page is a top-level item w/ subsections attempt to load
        // the HTML for the first subsection instead (details if it exists)
        let items = context.subsections(for: item.metadata.itemAppSection)
        if item.metadata.itemAppSubsection == .noneOrParent, !items.isEmpty {
            let itemToLoad: Item<IanClawsonDev>
            if let detail = items.filter({ $0.isDetailsSubsection }).first {
                itemToLoad = detail
            } else {
                itemToLoad = items.first!
            }
            // rEcUrSiOn
            return try makeItemHTML(for: itemToLoad, context: context)
        }
        
        let topLevelItem = context.parentItem(for: item)
        
        return HTML(
            .lang(context.site.language),
            .head(for: item, inMySite: context.site),
//            .head(for: item, on: context.site),
            .body(
//                .class("item-page"),
                .components {
//                    SiteHeader(context: context, selectedSelectionID: item.sectionID)
                    Wrapper {
                        BreadCrumbsView(item: item)
                        AppPageHeaderView(topLevelItem: topLevelItem)
                        AppPageSectionTabs(currentSection: item, subsections: items)
                        Article {
                            AppPageContentView(item: item)
                        }
//                        ItemList(
//                            items: context.subsections(for: item.metadata.itemAppSection),
//                            site: context.site
//                        )
//                        Article {
//                            Div(item.content.body).class("content")
//                            if item.isTopSection {
//                                Span("Tagged with: ")
//                                ItemTagList(item: item, site: context.site)
//                            }
//                        }
                    }
                    SiteFooter()
                }
            )
        )
    }

    /// make the html for a page in a section without any items
    func makePageHTML(for page: Page, context: PublishingContext<IanClawsonDev>) throws -> HTML {
        HTML(
            .lang(context.site.language),
            .head(for: page, inMySite: context.site),
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
            .head(for: page, inMySite: context.site),
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
            .head(for: page, inMySite: context.site),
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
