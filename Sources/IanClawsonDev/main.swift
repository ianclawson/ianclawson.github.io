import Foundation
import Publish
import Plot
import SplashPublishPlugin

// This type acts as the configuration for your website.
struct IanClawsonDev: Website {
    enum SectionID: String, WebsiteSectionID {
        // Add the sections that you want your website to contain here:
        case about
        case apps
        case posts
    }

    // wish I could have different metadata for different sections
    struct ItemMetadata: WebsiteItemMetadata {
        // Add any site-specific metadata that you want to use here.
        var itemSectionCollection: String
        var itemSections: [String] // might not work
        var itemName: String
        var itemType: ItemType
        
        var appStoreURL: String?
        var appExternalWebsiteURL: String?
        var appReleaseDate: Date?
        var appReleaseDateFormatted: String?
        
        var published: Bool
        var crumbs: [String] // might not work

        enum ItemType: String, WebsiteItemMetadata {
            case mobileApp = "Mobile App"
            case website = "Website"
            case blogPost = "Blog Post"
        }
    }

    // Update these properties to configure your website:
    var url = URL(string: "https://ianclawson.dev")!
    var name = "Ian Clawson Dev"
    var description = "A place to showcase my work"
    var language: Language { .english }
    var imagePath: Path? { nil }
}

try IanClawsonDev().publish(using: [
    .installPlugin(.splash(withClassPrefix: "")),
//    .addItem(StaticItems.TestItem),
    .addMarkdownFiles(),
    .copyResources(),
    .generateHTML(withTheme: .foundation),
    .generateRSSFeed(including: [.posts, .apps]),
    .generateSiteMap(),
])

// I guess we CAN use this to deploy to github pages! Let's try it and move away from jekyll!!
// there's Sections, items, pages. Hoping I can leverage items to make subsections

//try IanClawsonDev().publish(withTheme: .foundation)
