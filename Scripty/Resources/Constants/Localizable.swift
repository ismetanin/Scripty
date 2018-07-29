// Generated using SwiftGen, by O.Halligon — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// swiftlint:disable explicit_type_interface identifier_name line_length nesting type_body_length type_name
enum L10n {

  enum Addscript {
    /// Done
    static let doneButtonTitle = L10n.tr("Localizable", "AddScript.DoneButtonTitle")
    /// Script
    static let scriptContentTitle = L10n.tr("Localizable", "AddScript.ScriptContentTitle")
    /// Script name
    static let scriptNameTitle = L10n.tr("Localizable", "AddScript.ScriptNameTitle")
  }

  enum Error {

    enum Shellrun {
      /// Something went wrong. Please check script in Preferences.
      static let description = L10n.tr("Localizable", "Error.ShellRun.description")
      /// Error
      static let title = L10n.tr("Localizable", "Error.ShellRun.title")
    }
  }

  enum Mainmenu {
    /// Add script...
    static let addItemTitle = L10n.tr("Localizable", "MainMenu.AddItemTitle")
    /// Quit
    static let quitItemTitle = L10n.tr("Localizable", "MainMenu.QuitItemTitle")
  }

  enum Statusitem {
    /// Scripty
    static let title = L10n.tr("Localizable", "StatusItem.Title")
  }
}
// swiftlint:enable explicit_type_interface identifier_name line_length nesting type_body_length type_name

extension L10n {
  fileprivate static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = NSLocalizedString(key, tableName: table, bundle: Bundle(for: BundleToken.self), comment: "")
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

private final class BundleToken {}
