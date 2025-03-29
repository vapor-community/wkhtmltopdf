import Foundation

/// Represents wkhtmltopdf options
public enum Option: Sendable {
    // Global options
    /// Collate when printing multiple copies (default)
    case collate(Bool)
    /// Read and write cookies from and to the supplied cookie jar file
    case cookieJar(String)
    /// Number of copies to print into the pdf file (default 1)
    case copies(Int)
    /// Change the dpi explicitly (this has no effect on X11 based systems) (default 96)
    case dpi(Int)
    /// Display more extensive help, detailing less common command switches
    case extendedHelp
    /// PDF will be generated in grayscale
    case grayscale
    /// Display help
    case help
    /// Output program html help
    case htmldoc
    /// When jpeg compressing images use this quality (default 94)
    case imageQuality(Int)
    /// When embedding images scale them down to this dpi (default 600)
    case imagesDpi(Int)
    /// Output license information and exit
    case license
    /// Set log level to: none, error, warn or info (default info)
    case logLevel(LogLevel)
    /// Generates lower quality pdf/ps. Useful to shrink the result document space
    case lowQuality
    /// Output program man page
    case manpage
    /// Set the page bottom margin
    case marginBottom(Int)
    /// Set the page left margin (default 10mm)
    case marginLeft(Int)
    /// Set the page right margin (default 10mm)
    case marginRight(Int)
    /// Set the page top margin
    case marginTop(Int)

    // This is a convenience method to set all margins at once
    case margins(Int)

    /// Set orientation to Landscape or Portrait (default Portrait)
    case orientation(Orientation)
    /// Page height
    case pageHeight(String)
    /// Set paper size to: A4, Letter, etc. (default A4)
    case pageSize(PaperSize)
    /// Page width
    case pageWidth(String)
    /// Do not use lossless compression on pdf objects
    case noPdfCompression
    /// Be less verbose, maintained for backwards compatibility; Same as using --log-level none
    case quiet
    /// Read command line arguments from stdin
    case readArgsFromStdin
    /// Output program readme
    case readme
    /// The title of the generated pdf file (The title of the first document is used if not specified)
    case title(String)
    /// Use the X server (some plugins and other stuff might not work without X11)
    case useXServer

    // Outline options
    /// Dump the default TOC xsl style sheet to stdout
    case dumpDefaultTocXsl
    /// Dump the outline to a file
    case dumpOutline(String)
    /// Put an outline into the pdf (default)
    case outline
    /// Set the depth of the outline (default 4)
    case outlineDepth(Int)
    /// Do not put an outline into the pdf
    case noOutline
    /// Specify which HTML tags should be used as outline items
    case outlineTags(String)

    // Headers and footers
    /// Centered footer text
    case footerCenter(String)
    /// Set footer font name (default Arial)
    case footerFontName(String)
    /// Set footer font size (default 12)
    case footerFontSize(Int)
    /// Adds a html footer
    case footerHTML(String)
    /// Left aligned footer text
    case footerLeft(String)
    /// Display line above the footer
    case footerLine
    /// Do not display line above the footer (default)
    case noFooterLine
    /// Right aligned footer text
    case footerRight(String)
    /// Spacing between footer and content in mm (default 0)
    case footerSpacing(Float)
    /// Centered header text
    case headerCenter(String)
    /// Set header font name (default Arial)
    case headerFontName(String)
    /// Set header font size (default 12)
    case headerFontSize(Int)
    /// Adds a html header
    case headerHTML(String)
    /// Left aligned header text
    case headerLeft(String)
    /// Display line below the header
    case headerLine
    /// Do not display line below the header (default)
    case noHeaderLine
    /// Right aligned header text
    case headerRight(String)
    /// Spacing between header and content in mm (default 0)
    case headerSpacing(Float)
    /// Replace [name] with value in header and footer (repeatable)
    case replace(String, String)

    // TOC options
    /// Do not use dotted lines in the toc
    case disableDottedLines
    /// The header text of the toc (default Table of Contents)
    case tocHeaderText(String)
    /// For each level of headings in the toc indent by this length (default 1em)
    case tocLevelIndentation(Int)
    /// Do not link from toc to sections
    case disableTocLinks
    /// For each level of headings in the toc the font is scaled by this factor (default 0.8)
    case tocTextSizeShrink(Float)
    /// Use the supplied xsl style sheet for printing the table of contents
    case xslStyleSheet(String)

    // Page options
    /// Allow the file or files from the specified folder to be loaded (repeatable)
    case allow(String)
    /// Do print background (default)
    case background(Bool)
    /// Bypass proxy for host (repeatable)
    case bypassProxyFor(String)
    /// Web cache directory
    case cacheDir(String)
    /// Use this SVG file when rendering checked checkboxes
    case checkboxCheckedSvg(String)
    /// Use this SVG file when rendering unchecked checkboxes
    case checkboxSvg(String)
    /// Set an additional cookie (repeatable), value should be url encoded.
    case cookie(String, String)
    /// Set an additional HTTP header (repeatable)
    case customHeader(String, String)
    /// Add HTTP headers specified by --custom-header for each resource request
    case customHeaderPropagation
    /// Do not add HTTP headers specified by --custom-header for each resource request
    case noCustomHeaderPropagation
    /// Show javascript debugging output
    case debugJavascript
    /// Do not show javascript debugging output (default)
    case noDebugJavascript
    /// Add a default header, with the name of the page to the left, and the page number to the right
    case defaultHeader
    /// Set the default text encoding, for input
    case encoding(String)
    /// Do not make links to remote web pages
    case disableExternalLinks
    /// Make links to remote web pages (default)
    case enableExternalLinks
    /// Do not turn HTML form fields into pdf form fields (default)
    case disableForms
    /// Turn HTML form fields into pdf form fields
    case enableForms
    /// Do load or print images (default)
    case images
    /// Do not load or print images
    case noImages
    /// Do not make local links
    case disableInternalLinks
    /// Make local links (default)
    case enableInternalLinks
    /// Do not allow web pages to run javascript
    case disableJavascript
    /// Do allow web pages to run javascript (default)
    case enableJavascript
    /// Allowed conversion of a local file to read in other local files
    case enableLocalFileAccess
    /// Do not allowed conversion of a local file to read in other local files, unless explicitly allowed with --allow (default)
    case disableLocalFileAccess
    /// Disable the intelligent shrinking strategy used by WebKit that makes the pixel/dpi ratio non-constant
    case disableSmartShrinking
    /// Enable the intelligent shrinking strategy used by WebKit that makes the pixel/dpi ratio non-constant (default)
    case enableSmartShrinking
    /// Include the page in the table of contents and outlines (default)
    case includedInOutline
    /// Do not include the page in the table of contents and outlines
    case excludedFromOutline
    /// Wait some milliseconds for javascript finish (default 200)
    case javascriptDelay(Int)
    /// Keep relative external links as relative external links
    case keepRelativeLinks
    /// Specify how to handle pages that fail to load: abort, ignore or skip (default abort)
    case loadErrorHandling(ErrorHandling)
    /// Specify how to handle media files that fail to load: abort, ignore or skip (default ignore)
    case loadMediaErrorHandling(ErrorHandling)
    /// Minimum font size
    case minimumFontSize(Int)
    /// Do not print background
    case noBackground
    /// Do not use print media-type instead of screen (default)
    case noPrintMediaStyle
    /// Set the starting page number (default 0)
    case pageOffset(Int)
    /// HTTP Authentication password
    case password(String)
    /// Add an additional post field (repeatable)
    case post(String, String)
    /// Post an additional file (repeatable)
    case postFile(String, String)
    /// Use print media-type instead of screen
    case printMediaType
    /// Use a proxy
    case proxy(String)
    /// Use the proxy for resolving hostnames
    case proxyHostnameLookup
    /// Use this SVG file when rendering checked radiobuttons
    case radioButtonCheckedSvg(String)
    /// Use this SVG file when rendering unchecked radiobuttons
    case radioButtonSvg(String)
    /// Resolve relative external links into absolute links (default)
    case resolveRelativeLinks
    /// Run this additional javascript after the page is done loading (repeatable)
    case runScript(String)
    /// Disable smart width adjustment
    case disableSmartWidth
    /// Enable installed plugins (plugins will likely not work)
    case enablePlugins
    /// Disable installed plugins (default)
    case disablePlugins
    /// Path to the ssl client cert public key in OpenSSL PEM format, optionally followed by intermediate ca and trusted certs
    case sslCrtPath(String)
    /// Password to ssl client cert private key
    case sslKeyPassword(String)
    /// Path to ssl client cert private key in OpenSSL PEM format
    case sslKeyPath(String)
    /// Stop slow running javascripts (default)
    case stopSlowScripts
    /// Do not Stop slow running javascripts
    case noStopSlowScripts
    /// Do not link from section header to toc (default)
    case disableTocBackLinks
    /// Link from section header to toc
    case enableTocBackLinks
    /// Specify a user style sheet, to load with every page
    case userStyleSheet(String)
    /// HTTP Authentication username
    case username(String)
    /// Set viewport size if you have custom scrollbars or css attribute overflow to emulate window size
    case viewportSize(String)
    /// Wait until window.status is equal to this string before rendering page
    case windowStatus(String)
    /// Use this zoom factor (default 1)
    case zoom(Float)

    // Custom raw argument
    /// Add a raw argument string as is
    case rawArg(String)
    /// Add a raw flag with -- prefix
    case rawFlag(String)

    /// Page orientation
    public enum Orientation: String, Sendable {
        /// Portrait orientation
        case portrait = "Portrait"
        /// Landscape orientation
        case landscape = "Landscape"
    }

    /// Error handling behavior
    public enum ErrorHandling: String, Sendable {
        /// Abort the conversion process on error
        case abort = "abort"
        /// Ignore the error and continue
        case ignore = "ignore"
        /// Skip the page with the error and continue
        case skip = "skip"
    }

    /// Log levels
    public enum LogLevel: String, Sendable {
        /// No logging output
        case none = "none"
        /// Only error messages
        case error = "error"
        /// Warning and error messages
        case warn = "warn"
        /// All messages including informational ones (default)
        case info = "info"
    }

    // https://doc.qt.io/archives/qt-4.8/qprinter.html#PaperSize-enum
    public enum PaperSize: Sendable, Equatable {
        case a0
        case a1
        case a2
        case a3
        case a4
        case a5
        case a6
        case a7
        case a8
        case a9
        case b0
        case b1
        case b2
        case b3
        case b4
        case b5
        case b6
        case b7
        case b8
        case b9
        case b10
        case c5e
        case comm10E
        case dle
        case executive
        case folio
        case ledger
        case legal
        case letter
        case tabloid
        case custom(String)

        var rawValue: String {
            switch self {
            case .a0: "A0"
            case .a1: "A1"
            case .a2: "A2"
            case .a3: "A3"
            case .a4: "A4"
            case .a5: "A5"
            case .a6: "A6"
            case .a7: "A7"
            case .a8: "A8"
            case .a9: "A9"
            case .b0: "B0"
            case .b1: "B1"
            case .b2: "B2"
            case .b3: "B3"
            case .b4: "B4"
            case .b5: "B5"
            case .b6: "B6"
            case .b7: "B7"
            case .b8: "B8"
            case .b9: "B9"
            case .b10: "B10"
            case .c5e: "C5E"
            case .comm10E: "Comm10E"
            case .dle: "DLE"
            case .executive: "Executive"
            case .folio: "Folio"
            case .ledger: "Ledger"
            case .legal: "Legal"
            case .letter: "Letter"
            case .tabloid: "Tabloid"
            case .custom(let string): string
            }
        }
    }

    func toCLIArguments() -> [String] {
        switch self {
        // Global options
        case .collate(let enabled):
            ["--collate"] + (enabled ? [] : ["false"])
        case .cookieJar(let path):
            ["--cookie-jar", path]
        case .copies(let count):
            ["--copies", "\(count)"]
        case .dpi(let value):
            ["--dpi", "\(value)"]
        case .extendedHelp:
            ["--extended-help"]
        case .grayscale:
            ["--grayscale"]
        case .help:
            ["--help"]
        case .htmldoc:
            ["--htmldoc"]
        case .imageQuality(let value):
            ["--image-quality", "\(value)"]
        case .imagesDpi(let value):
            ["--image-dpi", "\(value)"]
        case .license:
            ["--license"]
        case .logLevel(let level):
            ["--log-level", level.rawValue]
        case .lowQuality:
            ["--lowquality"]
        case .manpage:
            ["--manpage"]
        case .marginBottom(let value):
            ["--margin-bottom", "\(value)mm"]
        case .marginLeft(let value):
            ["--margin-left", "\(value)mm"]
        case .marginRight(let value):
            ["--margin-right", "\(value)mm"]
        case .marginTop(let value):
            ["--margin-top", "\(value)mm"]
        case .margins(let value):
            [
                "--margin-left", "\(value)mm",
                "--margin-right", "\(value)mm",
                "--margin-top", "\(value)mm",
                "--margin-bottom", "\(value)mm",
            ]
        case .orientation(let orientation):
            ["--orientation", orientation.rawValue]
        case .pageHeight(let height):
            ["--page-height", height]
        case .pageSize(let size):
            ["--page-size", size.rawValue]
        case .pageWidth(let width):
            ["--page-width", width]
        case .noPdfCompression:
            ["--no-pdf-compression"]
        case .quiet:
            ["--quiet"]
        case .readArgsFromStdin:
            ["--read-args-from-stdin"]
        case .readme:
            ["--readme"]
        case .title(let title):
            ["--title", title]
        case .useXServer:
            ["--use-xserver"]

        // Outline options
        case .dumpDefaultTocXsl:
            ["--dump-default-toc-xsl"]
        case .dumpOutline(let file):
            ["--dump-outline", file]
        case .outline:
            ["--outline"]
        case .outlineDepth(let depth):
            ["--outline-depth", "\(depth)"]
        case .noOutline:
            ["--no-outline"]
        case .outlineTags(let tags):
            ["--outline-tags", tags]

        // Headers and footers
        case .footerCenter(let text):
            ["--footer-center", text]
        case .footerFontName(let name):
            ["--footer-font-name", name]
        case .footerFontSize(let size):
            ["--footer-font-size", "\(size)"]
        case .footerHTML(let url):
            ["--footer-html", url]
        case .footerLeft(let text):
            ["--footer-left", text]
        case .footerLine:
            ["--footer-line"]
        case .noFooterLine:
            ["--no-footer-line"]
        case .footerRight(let text):
            ["--footer-right", text]
        case .footerSpacing(let spacing):
            ["--footer-spacing", "\(spacing)"]
        case .headerCenter(let text):
            ["--header-center", text]
        case .headerFontName(let name):
            ["--header-font-name", name]
        case .headerFontSize(let size):
            ["--header-font-size", "\(size)"]
        case .headerHTML(let url):
            ["--header-html", url]
        case .headerLeft(let text):
            ["--header-left", text]
        case .headerLine:
            ["--header-line"]
        case .noHeaderLine:
            ["--no-header-line"]
        case .headerRight(let text):
            ["--header-right", text]
        case .headerSpacing(let spacing):
            ["--header-spacing", "\(spacing)"]
        case .replace(let name, let value):
            ["--replace", name, value]

        // TOC options
        case .disableDottedLines:
            ["--disable-dotted-lines"]
        case .tocHeaderText(let text):
            ["--toc-header-text", text]
        case .tocLevelIndentation(let indentation):
            ["--toc-level-indentation", "\(indentation)"]
        case .disableTocLinks:
            ["--disable-toc-links"]
        case .tocTextSizeShrink(let shrink):
            ["--toc-text-size-shrink", "\(shrink)"]
        case .xslStyleSheet(let file):
            ["--xsl-style-sheet", file]

        // Page options
        case .allow(let paths):
            ["--allow", paths]
        case .background(let bool):
            bool ? ["--background"] : ["--no-background"]
        case .bypassProxyFor(let hosts):
            ["--bypass-proxy-for", hosts]
        case .cacheDir(let path):
            ["--cache-dir", path]
        case .checkboxCheckedSvg(let path):
            ["--checkbox-checked-svg", path]
        case .checkboxSvg(let path):
            ["--checkbox-svg", path]
        case .cookie(let name, let value):
            ["--cookie", name, value]
        case .customHeader(let name, let value):
            ["--custom-header", name, value]
        case .customHeaderPropagation:
            ["--custom-header-propagation"]
        case .noCustomHeaderPropagation:
            ["--no-custom-header-propagation"]
        case .debugJavascript:
            ["--debug-javascript"]
        case .noDebugJavascript:
            ["--no-debug-javascript"]
        case .defaultHeader:
            ["--default-header"]
        case .encoding(let encoding):
            ["--encoding", encoding]
        case .disableExternalLinks:
            ["--disable-external-links"]
        case .enableExternalLinks:
            ["--enable-external-links"]
        case .disableForms:
            ["--disable-forms"]
        case .enableForms:
            ["--enable-forms"]
        case .images:
            ["--images"]
        case .noImages:
            ["--no-images"]
        case .disableInternalLinks:
            ["--disable-internal-links"]
        case .enableInternalLinks:
            ["--enable-internal-links"]
        case .disableJavascript:
            ["--disable-javascript"]
        case .enableJavascript:
            ["--enable-javascript"]
        case .disableLocalFileAccess:
            ["--disable-local-file-access"]
        case .enableLocalFileAccess:
            ["--enable-local-file-access"]
        case .disableSmartShrinking:
            ["--disable-smart-shrinking"]
        case .enableSmartShrinking:
            ["--enable-smart-shrinking"]
        case .includedInOutline:
            ["--include-in-outline"]
        case .excludedFromOutline:
            ["--exclude-from-outline"]
        case .javascriptDelay(let delay):
            ["--javascript-delay", "\(delay)"]
        case .keepRelativeLinks:
            ["--keep-relative-links"]
        case .loadErrorHandling(let handling):
            ["--load-error-handling", handling.rawValue]
        case .loadMediaErrorHandling(let handling):
            ["--load-media-error-handling", handling.rawValue]
        case .minimumFontSize(let size):
            ["--minimum-font-size", "\(size)"]
        case .noBackground:
            ["--no-background"]
        case .noPrintMediaStyle:
            ["--no-print-media-type"]
        case .pageOffset(let offset):
            ["--page-offset", "\(offset)"]
        case .password(let password):
            ["--password", password]
        case .post(let name, let value):
            ["--post", name, value]
        case .postFile(let name, let path):
            ["--post-file", name, path]
        case .printMediaType:
            ["--print-media-type"]
        case .proxy(let proxy):
            ["--proxy", proxy]
        case .proxyHostnameLookup:
            ["--proxy-hostname-lookup"]
        case .radioButtonCheckedSvg(let path):
            ["--radiobutton-checked-svg", path]
        case .radioButtonSvg(let path):
            ["--radiobutton-svg", path]
        case .resolveRelativeLinks:
            ["--resolve-relative-links"]
        case .runScript(let script):
            ["--run-script", script]
        case .disableSmartWidth:
            ["--disable-smart-width"]
        case .enablePlugins:
            ["--enable-plugins"]
        case .disablePlugins:
            ["--disable-plugins"]
        case .sslCrtPath(let path):
            ["--ssl-crt-path", path]
        case .sslKeyPassword(let password):
            ["--ssl-key-password", password]
        case .sslKeyPath(let path):
            ["--ssl-key-path", path]
        case .stopSlowScripts:
            ["--stop-slow-scripts"]
        case .noStopSlowScripts:
            ["--no-stop-slow-scripts"]
        case .disableTocBackLinks:
            ["--disable-toc-back-links"]
        case .enableTocBackLinks:
            ["--enable-toc-back-links"]
        case .userStyleSheet(let url):
            ["--user-style-sheet", url]
        case .username(let username):
            ["--username", username]
        case .viewportSize(let size):
            ["--viewport-size", size]
        case .windowStatus(let status):
            ["--window-status", status]
        case .zoom(let factor):
            ["--zoom", "\(factor)"]

        // Raw arguments
        case .rawArg(let arg):
            [arg]
        case .rawFlag(let flag):
            ["--\(flag)"]
        }
    }
}
