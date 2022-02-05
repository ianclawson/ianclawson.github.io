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

    struct ItemMetadata: WebsiteItemMetadata {
        // Add any site-specific metadata that you want to use here.
    }

    // Update these properties to configure your website:
    var url = URL(string: "https://ianclawson.dev")!
    var name = "Ian Clawson Dev"
    var description = "A place to showcase my work"
    var language: Language { .english }
    var imagePath: Path? { nil }
}

// This will generate your website using the built-in Foundation theme:
//try IanClawsonDev().publish(withTheme: .foundation)

try IanClawsonDev().publish(using: [
    .installPlugin(.splash(withClassPrefix: "")),
    .addMarkdownFiles(),
    .copyResources(),
    .generateHTML(withTheme: .foundation),
    .generateRSSFeed(including: [.posts, .apps]),
    .generateSiteMap(),
])

// I guess we CAN use this to deploy to github pages! Let's try it and move away from jekyll!!

// there's Sections, items, pages. Hoping I can leverage items to make subsections

//try IanClawsonDev().publish(withTheme: .foundation)
