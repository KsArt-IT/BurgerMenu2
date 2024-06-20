//
//  Validate.swift
//  BugerMenu2
//
//  Created by KsArT on 19.06.2024.
//

import Foundation

class Validate {

    static let shared = Validate()

    private var email = ""
    private var password = ""

    static let emailCharRegex = "^(?=.{1,253})(?=.*[A-Za-z0-9@._%+-]).*$"
    static let emailRegex = "^(?=[a-z0-9][a-z0-9@._%+-]{5,253}$)([a-z0-9_-]+\\.)*[a-z0-9_-]+@[a-z0-9_-]+(\\.[a-z0-9_-]+)*\\.[a-z]{2,63}$"

    static let passwordCharRegex = "^(?=.{1,20})(?=[A-Za-z0-9~@]).*$"
    //let passwordCharRegex = "^(?=.{1,20})(?=.*[A-Za-z0-9~@#$%^&+-*!=]).*$"
    static let passwordRegex = "^(?=.{8,20})(?=.*[a-z])(?=.*[0-9])(?=.*[A-Z])(?=.*[~@]).*$"
//    static let passwordRegex = "^(?=.{8,20})(?=.*[a-z])(?=.*[0-9])(?=.*[A-Z])(?=.*[~@#$%\\^&+-\\*!=]).*$"

    private init() {}

    func valideCharForEmail(_ email: String) -> Bool {
        NSPredicate(format: "SELF MATCHES %@", Validate.emailCharRegex).evaluate(with: email)
    }

    func valideCharForPassword(_ password: String) -> Bool {
        NSPredicate(format: "SELF MATCHES %@", Validate.passwordCharRegex).evaluate(with: password)
    }

    private func valideEmail(_ email: String) -> Bool {
        !email.isEmpty && NSPredicate(format: "SELF MATCHES %@", Validate.emailRegex).evaluate(with: email)
    }

    private func validePassword(_ password: String) -> Bool {
        !password.isEmpty && NSPredicate(format: "SELF MATCHES %@", Validate.passwordRegex).evaluate(with: password)
    }

    public func setEmail(_ email: String?) {
        if let email = email, valideEmail(email) {
            self.email = email
        } else {
            self.email = ""
        }
        print("email: \(self.email)")
    }

    public func setPassword(_ password: String?) {
        if let password = password, validePassword(password) {
            self.password = password
        } else {
            self.password = ""
        }
        print("password: \(self.password)")
    }

    public func isValid() -> Bool {
        valideEmail(email) && validePassword(password)
    }
}
