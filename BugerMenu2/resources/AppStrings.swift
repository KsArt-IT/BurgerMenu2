//
//  AppStrings.swift
//  BugerMenu2
//
//  Created by KsArT on 18.06.2024.
//

import UIKit

enum AppStrings {
    static let loginTitle = String(localized: "Login")


    static let rememberHint = String(localized: "Remember me")

    static let emailHint = String(localized: "Email")
    static let emailPlaceholder = NSAttributedString(
        string: String(localized: "EmailPlaceholder"),
        attributes: [NSAttributedString.Key.foregroundColor: UIColor.mainBlue.withAlphaComponent(0.3)]
    )
    
    static let passHint = String(localized: "Password")
    static let passPlaceholder = NSAttributedString(
        string: String(localized: "PasswordPlaceholder"),
        attributes: [NSAttributedString.Key.foregroundColor: UIColor.mainBlue.withAlphaComponent(0.3)]
    )
    static let confirmPassHint = String(localized: "Confirm Password")

    static let loginButton = String(localized: "Login")
    static let signUP = String(localized: "Sign UP")
}
