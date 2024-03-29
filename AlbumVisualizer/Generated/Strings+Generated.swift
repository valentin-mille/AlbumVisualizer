// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
public enum Strings {

  public enum Album {
    /// Albums 📒
    public static let title = Strings.tr("Localizable", "album.title")
  }

  public enum Network {
    /// You are not connected to Internet. Please try again later.
    public static let message = Strings.tr("Localizable", "network.message")
    /// Network Error
    public static let title = Strings.tr("Localizable", "network.title")
  }

  public enum OnBoarding {
    /// Get Started
    public static let buttonTitle = Strings.tr("Localizable", "onBoarding.buttonTitle")
    /// Find all your photos in one single place. Search something that matters to you inside your photos.
    public static let subtitle = Strings.tr("Localizable", "onBoarding.subtitle")
    /// A new way to admire your Albums
    public static let title = Strings.tr("Localizable", "onBoarding.title")
  }

  public enum Photo {
    /// Photos 🎞
    public static let title = Strings.tr("Localizable", "photo.title")
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension Strings {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: nil, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
