// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name
internal enum L10n {

  internal enum AddScript {
    /// Done
    internal static let doneButtonTitle = L10n.tr("Localizable", "AddScript.DoneButtonTitle")
    /// Script
    internal static let scriptContentTitle = L10n.tr("Localizable", "AddScript.ScriptContentTitle")
    /// Script name
    internal static let scriptNameTitle = L10n.tr("Localizable", "AddScript.ScriptNameTitle")
  }

  internal enum MainMenu {
    /// Add script...
    internal static let addItemTitle = L10n.tr("Localizable", "MainMenu.AddItemTitle")
    /// Quit
    internal static let quitItemTitle = L10n.tr("Localizable", "MainMenu.QuitItemTitle")
  }

  internal enum ShellRun {
    internal enum Error {
      /// Something went wrong. Please check script in Preferences.
      internal static let description = L10n.tr("Localizable", "ShellRun.Error.description")
      /// Error
      internal static let title = L10n.tr("Localizable", "ShellRun.Error.title")
    }
    internal enum Success {
      /// Done
      internal static let title = L10n.tr("Localizable", "ShellRun.Success.title")
    }
  }

  internal enum StatusItem {
    /// Scripty
    internal static let title = L10n.tr("Localizable", "StatusItem.Title")
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name

// MARK: - Implementation Details

extension L10n {
  fileprivate static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    // swiftlint:disable:next nslocalizedstring_key
    let format = NSLocalizedString(key, tableName: table, bundle: Bundle(for: BundleToken.self), comment: "")
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

private final class BundleToken {}
