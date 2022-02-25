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
            "Resources/css/mystyles.css",
            "Resources/assets/tailwind.min.css",
            "Resources/assets/typography.min.css"
        ]
    }
    static var headStylesheets: [Publish.Path] {
        return [
            "/mystyles.css",
            "/assets/tailwind.min.css",
            "/assets/typography.min.css"
        ]
    }
}

extension MyHTMLFactory {
    public struct Wrapper: ComponentContainer {
        @ComponentBuilder var content: ContentProvider

        var body: Component {
            Div {
                Div {
                    content()
                }
                .class("max-w-3xl sm:mx-auto sm:max-w-xl sm:space-y-4 lg:max-w-3xl mx-auto")
            }
            .class("max-w-7xl mx-auto px-4 sm:px-6 lg:px-8")
//            Div(content: content).class("wrapper")
        }
    }
    
    public struct SiteHeaderContentWrapper<Site: Website>: Component {
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
            Footer(html:
"""
<footer>
  <div class="mx-auto py-6 px-4 overflow-hidden sm:px-6 lg:px-8">
    <div class="flex justify-center space-x-6">
        <a href="https://github.com/ianclawson" class="text-gray-400 hover:text-gray-500">
            <span class="sr-only">GitHub</span>
            <svg class="w-5 h-5" fill="currentColor" viewBox="0 0 20 20" aria-hidden="true">
              <path fill-rule="evenodd" d="M10 0C4.477 0 0 4.484 0 10.017c0 4.425 2.865 8.18 6.839 9.504.5.092.682-.217.682-.483 0-.237-.008-.868-.013-1.703-2.782.605-3.369-1.343-3.369-1.343-.454-1.158-1.11-1.466-1.11-1.466-.908-.62.069-.608.069-.608 1.003.07 1.531 1.032 1.531 1.032.892 1.53 2.341 1.088 2.91.832.092-.647.35-1.088.636-1.338-2.22-.253-4.555-1.113-4.555-4.951 0-1.093.39-1.988 1.029-2.688-.103-.253-.446-1.272.098-2.65 0 0 .84-.27 2.75 1.026A9.564 9.564 0 0110 4.844c.85.004 1.705.115 2.504.337 1.909-1.296 2.747-1.027 2.747-1.027.546 1.379.203 2.398.1 2.651.64.7 1.028 1.595 1.028 2.688 0 3.848-2.339 4.695-4.566 4.942.359.31.678.921.678 1.856 0 1.338-.012 2.419-.012 2.747 0 .268.18.58.688.482A10.019 10.019 0 0020 10.017C20 4.484 15.522 0 10 0z" clip-rule="evenodd" />
            </svg>
          </a>
          <a href="https://www.linkedin.com/in/ian-clawson/" class="text-gray-400 hover:text-gray-500">
            <span class="sr-only">LinkedIn</span>
            <svg class="w-5 h-5" fill="currentColor" viewBox="0 0 20 20" aria-hidden="true">
              <path fill-rule="evenodd" d="M16.338 16.338H13.67V12.16c0-.995-.017-2.277-1.387-2.277-1.39 0-1.601 1.086-1.601 2.207v4.248H8.014v-8.59h2.559v1.174h.037c.356-.675 1.227-1.387 2.526-1.387 2.703 0 3.203 1.778 3.203 4.092v4.711zM5.005 6.575a1.548 1.548 0 11-.003-3.096 1.548 1.548 0 01.003 3.096zm-1.337 9.763H6.34v-8.59H3.667v8.59zM17.668 1H2.328C1.595 1 1 1.581 1 2.298v15.403C1 18.418 1.595 19 2.328 19h15.34c.734 0 1.332-.582 1.332-1.299V2.298C19 1.581 18.402 1 17.668 1z" clip-rule="evenodd" />
            </svg>
          </a>
    </div>
    <p class="mt-3 text-center text-base text-gray-400">
      &copy; 2021 Ian Clawson. All rights reserved.
    </p>
  </div>
</footer>
"""
            )
//            Footer {
//                Paragraph {
//                    Text("Generated using ")
//                    Link("Publish", url: "https://github.com/johnsundell/publish")
//                }
//                Paragraph {
//                    Link("RSS feed", url: "/feed.rss")
//                }
//            }
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
    
    /// Return the parent item for the subsection
    /// returns self if already a top level item
    /// - parameter itemAppSection: The itemAppSection to return all items for.
    func parentItem(for itemSubSection: Item<IanClawsonDev>) -> Item<IanClawsonDev> {
        
        if itemSubSection.isTopSection {
            return itemSubSection
        }
        
        let candidates = sections.flatMap {
            $0.items.filter {
                $0.metadata.itemAppSection == itemSubSection.metadata.itemAppSection &&
                $0.isTopSection &&
                $0.isPublished == true
            }
        }
        
        return candidates.first ?? itemSubSection // probably a bad default but meh
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

