//
//  HTMLFactory.swift
//  
//
//  Created by Ian Clawson on 2/6/22.
//

import Foundation
import Publish
import Plot

extension IanClawsonDev {
    static var resourcesForTheme: Set<Publish.Path> {
        return [
            "Resources/css/styles.css",
            "Resources/assets/tailwind.min.css",
            "Resources/assets/typography.min.css"
        ]
    }
    static var headStylesheets: [Publish.Path] {
        return [
            "/styles.css", // doesn't pull in the regular stuff
            "/assets/tailwind.min.css",
            "/assets/typography.min.css"
        ]
    }
}

extension MyHTMLFactory {
    public struct Wrapper: ComponentContainer {
        @ComponentBuilder var content: ContentProvider

        var body: Component {
            Div(content: content).class("wrapper")
        }
    }

    public struct SiteHeader<Site: Website>: Component {
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

    public struct ItemList<Site: Website>: Component {
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

    public struct ItemTagList<Site: Website>: Component {
        var item: Item<Site>
        var site: Site

        var body: Component {
            List(item.tags) { tag in
                Link(tag.string, url: site.path(for: tag).absoluteString)
            }
            .class("tag-list")
        }
    }

    public struct SiteFooter: Component {
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
        let items = sections.flatMap {
            $0.items.filter {
                $0.isTopSection &&
                $0.isPublished == true
            }
        }

        return items.sorted(by: order.myMakeSorter(forKeyPath: sortingKeyPath))
    }
    
    /// Return all top-level items that are a part of the section collection.
    /// - parameter itemAppSection: The itemAppSection to return all items for.
    func myTopLevelItems(for section: Section<IanClawsonDev>) -> [Item<IanClawsonDev>] {
        return section.items.filter {
            $0.isTopSection &&
            $0.isPublished == true
        }
    }
    
    /// Return all subsections that are a part of the section collection.
    /// - parameter itemAppSection: The itemAppSection to return all items for.
    func subsections(for itemAppSection: IanClawsonDev.ItemMetadata.AppItemSection) -> [Item<IanClawsonDev>] {
        return sections.flatMap {
            $0.items.filter {
                $0.metadata.itemAppSection == itemAppSection &&
                $0.isSubsection &&
                $0.isPublished == true
            }
        }
    }
}

internal extension Item where Site == IanClawsonDev {
    var isTopSection: Bool {
        self.metadata.itemAppSubsection == .noneOrParent
    }
    
    var isSubsection: Bool {
        self.metadata.itemAppSubsection != .noneOrParent
    }
    
    var isPublished: Bool {
        self.metadata.published
    }
    
    var isDetailsSubsection: Bool {
        self.metadata.itemAppSubsection == .details
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

