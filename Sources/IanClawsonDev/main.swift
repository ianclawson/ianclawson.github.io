import Foundation
import Publish
import Plot
import SplashPublishPlugin

// TODO: List
/*
 ✅ have the sections display the subsections
 ✅ bring in the content
 - style the css and everything (Tailwind baybee)
 - setup github deployment
 */

struct IanClawsonDev: Website {
    enum SectionID: String, WebsiteSectionID {
        case about
        case app
        case posts
    }

    /// wish I could have different metadata for different sections, but alas
    struct ItemMetadata: WebsiteItemMetadata {
        /// the app this page/item or subection belongs to
        /// NOTE: required on both top-level section and subsections
        var itemAppSection: AppItemSection
        /// if item is subsection, this is the subsection that it is, otherwise this is `noneOrParent`
        /// NOTE: required on both top-level section and subsections

        var itemAppSubsection: AppItemSubsection
        /// the subsections this the top-level item contains (not always a complete list)
        /// NOTE: only available on top-level section
        var itemAppSubsections: [AppItemSubsection]?
        /// the name of the item
        /// NOTE: only available on top-level section
        var itemName: String?
        /// the category of the item (should be same across top-level and subsections)
        /// NOTE: only available on top-level section
        var itemCategory: ItemCategory?
        
        /// NOTE: all 4 following variables only available on top-level section
        var appStoreURL: String?
        var appExternalWebsiteURL: String?
        var appReleaseDate: Date?
        var appReleaseDateFormatted: String?
        var appBannerImagePath: String?
        
        /// wether or not the item is shown in site lists (mostly fitlered from queries)
        var published: Bool
        /// the breadcrumbs so you can navigate back (in progress, might not work)
        var crumbs: [String] // might not work

        enum ItemCategory: String, WebsiteItemMetadata {
            case mobileApp = "Mobile App"
            case website = "Website"
            case blogPost = "Blog Post"
        }
        
        // needs to match both item page/folder name exactly
        enum AppItemSection: String, WebsiteItemMetadata {
            case geosizer = "geosizer"
            case stars2apples = "stars-2-apples"
            case test = "test"
            // for top-level sections/pages, and for items that
            // don't have this paradigm (such as posts)
            case none = "none"
        }
        
        // needs to match subitem names exactly
        enum AppItemSubsection: String, WebsiteItemMetadata {
            case details = "details"
            case contact = "contact"
            case privacyPolicy = "privacy-policy"
            // for top-level sections/pages, and for items that
            // don't have this paradigm (such as posts)
            case noneOrParent = "none"
        }
    }

    var url = URL(string: "https://ianclawson.dev")!
    var name = "Ian Clawson Dev"
    var description = "A place to showcase my work"
    var language: Language { .english }
    var imagePath: Path? { nil }
}

try IanClawsonDev().publish(using: [
    .installPlugin(.splash(withClassPrefix: "")),
    .addItem(StaticItems.TestItem),
    .addMarkdownFiles(),
    .copyResources(),
    .generateHTML(withTheme: .myTheme),
//    .generateRSSFeed(including: [.posts, .apps]),
    .generateSiteMap(),
    .deploy(using: .gitHub("ianclawson/ianclawson.github.io", useSSH: false))
])

// inspo: https://briancoyner.github.io/articles/2020-02-25-cocoaheads_publish_notes/
// hello
