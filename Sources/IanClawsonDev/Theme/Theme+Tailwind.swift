//
//  MyTheme.swift
//  
//
//  Created by Ian Clawson on 2/5/22.
//

import Foundation
import Publish
import Plot

/// theme feels like a misnomer to me as it's not a color/asset pallet but the entire HTML later
/// if Publish dependency-injected your WebsiteItemMetadata here instead of having the the HTML
/// functions fetch the data then I could see it, but I digress, publish is still the best
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
                    H2("Latest content") // should probs
                    ItemList(
                        items: context.allMyTopLevelItems(
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
                    ItemList(items: context.myTopLevelItems(for: section), site: context.site)
                }
                SiteFooter()
            }
        )
    }

    /// make the html for page that's an item in a section
    func makeItemHTML(for item: Item<IanClawsonDev>, context: PublishingContext<IanClawsonDev>) throws -> HTML {
        // if the page is a top-level item w/ subsections, load the HTML for the first subsection instead
        let items = context.mySubsectionItems(for: item.metadata.itemAppSection)
        if item.metadata.itemAppSubsection == .noneOrParent, !items.isEmpty {
            let itemToLoad: Item<IanClawsonDev>
            if let detail = items.filter({ $0.metadata.itemAppSubsection == .details }).first {
                itemToLoad = detail
            } else {
                itemToLoad = items.first!
            }
            return try makeItemHTML(for: itemToLoad, context: context)
        }
        
        // default to other html
        return HTML(
            .lang(context.site.language),
            .head(for: item, on: context.site),
            .body(
                .class("item-page"),
                .components {
                    SiteHeader(context: context, selectedSelectionID: item.sectionID)
                    Wrapper {
                        // list off the sections
                        ItemList( // TODO: work to do, but the idea is possible
                            items: context.mySubsectionItems(for: item.metadata.itemAppSection),
                            site: context.site
                        )
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

    /// make the html for a page in a section without any items
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

// MARK: - Helper Functions and Extensions

internal extension PublishingContext where Site == IanClawsonDev {
    
    /// Return all items within this website, sorted by a given key path.
    /// - parameter sortingKeyPath: The key path to sort the items by.
    /// - parameter order: The order to use when sorting the items.
    func allMyTopLevelItems<T: Comparable>(
        sortedBy sortingKeyPath: KeyPath<Item<Site>, T>,
        order: Publish.SortOrder = .ascending
    ) -> [Item<Site>] {
        let items = sections.flatMap { $0.items.filter {
            $0.metadata.itemAppSubsection == .noneOrParent &&
            $0.metadata.published == true
        } }

        return items.sorted(
            by: order.myMakeSorter(forKeyPath: sortingKeyPath)
        )
    }
    
    /// Return all top-level items that are a part of the section collection.
    /// - parameter itemAppSection: The itemAppSection to return all items for.
    func myTopLevelItems(for section: Section<IanClawsonDev>) -> [Item<IanClawsonDev>] {
        return section.items.filter {
            $0.metadata.itemAppSubsection == .noneOrParent &&
            $0.metadata.published == true
        }
    }
    
    /// Return all subsections that are a part of the section collection.
    /// - parameter itemAppSection: The itemAppSection to return all items for.
    func mySubsectionItems(for itemAppSection: IanClawsonDev.ItemMetadata.AppItemSection) -> [Item<IanClawsonDev>] {
        return sections.flatMap {
            $0.items.filter {
                $0.metadata.itemAppSection == itemAppSection &&
                $0.metadata.itemAppSubsection != .noneOrParent &&
                $0.metadata.published == true
            }
        }
    }
}

// gotta pull this out from the depths of Publish lol
internal extension Publish.SortOrder {
    func myMakeSorter<T, V: Comparable>(
        forKeyPath keyPath: KeyPath<T, V>
    ) -> (T, T) -> Bool {
        switch self {
        case .ascending:
            return {
                $0[keyPath: keyPath] < $1[keyPath: keyPath]
            }
        case .descending:
            return {
                $0[keyPath: keyPath] > $1[keyPath: keyPath]
            }
        }
    }
}

// path stuff, might be useful yet

//internal extension Website {
////    /// The path for the website's tag list page.
////    var tagListPath: Path {
////        tagHTMLConfig?.basePath ?? .defaultForTagHTML
////    }
////
////    /// Return the relative path for a given section ID.
////    /// - parameter sectionID: The section ID to return a path for.
////    func path(for sectionID: SectionID) -> Path {
////        Path(sectionID.rawValue)
////    }
////
////    /// Return the relative path for a given tag.
////    /// - parameter tag: The tag to return a path for.
////    func path(for tag: Tag) -> Path {
////        let basePath = tagHTMLConfig?.basePath ?? .defaultForTagHTML
////        return basePath.appendingComponent(tag.normalizedString())
////    }
//
//    func path(for item: Item<IanClawsonDev>, in sectionId: SectionID) -> Path {
//        let basePath  = path(for: sectionId)
//
//        item.metadata.itemAppSection
//        return basePath.appendingComponent(item.path.string)
////        let basePath = tagHTMLConfig?.basePath ?? .defaultForTagHTML
////        return basePath.appendingComponent(tag.normalizedString())
//    }
//}


/// from Plot/API/HTMLComponents
/*
    /// A container component that's rendered using the `<article>` element.
    public typealias Article = ElementComponent<ElementDefinitions.Article>
     
    /// A container component that's rendered using the `<button>` element.
    public typealias Button = ElementComponent<ElementDefinitions.Button>
     
    /// A container component that's rendered using the `<div>` element.
    public typealias Div = ElementComponent<ElementDefinitions.Div>
     
    /// A container component that's rendered using the `<fieldset>` element.
    public typealias FieldSet = ElementComponent<ElementDefinitions.FieldSet>
     
    /// A container component that's rendered using the `<footer>` element.
    public typealias Footer = ElementComponent<ElementDefinitions.Footer>
     
    /// A container component that's rendered using the `<h1>` element.
    public typealias H1 = ElementComponent<ElementDefinitions.H1>
     
    /// A container component that's rendered using the `<h2>` element.
    public typealias H2 = ElementComponent<ElementDefinitions.H2>
     
    /// A container component that's rendered using the `<h3>` element.
    public typealias H3 = ElementComponent<ElementDefinitions.H3>
     
    /// A container component that's rendered using the `<h4>` element.
    public typealias H4 = ElementComponent<ElementDefinitions.H4>
     
    /// A container component that's rendered using the `<h5>` element.
    public typealias H5 = ElementComponent<ElementDefinitions.H5>
     
    /// A container component that's rendered using the `<h6>` element.
    public typealias H6 = ElementComponent<ElementDefinitions.H6>
     
    /// A container component that's rendered using the `<header>` element.
    public typealias Header = ElementComponent<ElementDefinitions.Header>
     
    /// A container component that's rendered using the `<li>` element.
    public typealias ListItem = ElementComponent<ElementDefinitions.ListItem>
     
    /// A container component that's rendered using the `<nav>` element.
    public typealias Navigation = ElementComponent<ElementDefinitions.Navigation>
     
    /// A container component that's rendered using the `<p>` element.
    public typealias Paragraph = ElementComponent<ElementDefinitions.Paragraph>
     
    /// A container component that's rendered using the `<span>` element.
    public typealias Span = ElementComponent<ElementDefinitions.Span>
     
    /// A container component that's rendered using the `<caption>` element.
    public typealias TableCaption = ElementComponent<ElementDefinitions.TableCaption>
     
    /// A container component that's rendered using the `<td>` element.
    public typealias TableCell = ElementComponent<ElementDefinitions.TableCell>
     
    /// A container component that's rendered using the `<th>` element.
    public typealias TableHeaderCell = ElementComponent<ElementDefinitions.TableHeaderCell>
*/

