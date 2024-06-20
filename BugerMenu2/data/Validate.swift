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

    private var emailReg = ""
    private var passwordReg = ""
    private var confirmPasswordReg = ""

    private var nameReg = ""
    private var surnameReg = ""

    static let emailCharRegex = "^(?=.{1,253})(?=.*[A-Za-z0-9@._%+-]).*$"
    static let emailRegex = "^(?=[a-z0-9][a-z0-9@._%+-]{5,253}$)([a-z0-9_-]+\\.)*[a-z0-9_-]+@[a-z0-9_-]+(\\.[a-z0-9_-]+)*\\.[a-z]{2,63}$"

    static let passwordCharRegex = "^(?=.{1,20})(?=[A-Za-z0-9~@]).*$"
    //let passwordCharRegex = "^(?=.{1,20})(?=.*[A-Za-z0-9~@#$%^&+-*!=]).*$"
    static let passwordRegex = "^(?=.{8,20})(?=.*[a-z])(?=.*[0-9])(?=.*[A-Z])(?=.*[~@]).*$"
//    static let passwordRegex = "^(?=.{8,20})(?=.*[a-z])(?=.*[0-9])(?=.*[A-Z])(?=.*[~@#$%\\^&+-\\*!=]).*$"

    private init() {}

    public func valideCharForEmail(_ email: String) -> Bool {
        NSPredicate(format: "SELF MATCHES %@", Validate.emailCharRegex).evaluate(with: email)
    }

    public func valideCharForPassword(_ password: String) -> Bool {
        NSPredicate(format: "SELF MATCHES %@", Validate.passwordCharRegex).evaluate(with: password)
    }

    public func valideCharForName(_ password: String) -> Bool {
        Character(password).isLetter
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

    public func setEmailReg(_ email: String?) {
        if let email = email, valideEmail(email) {
            self.emailReg = email
        } else {
            self.emailReg = ""
        }
        print("emailReg: \(self.emailReg)")
    }

    public func setPasswordReg(_ password: String?) {
        if let password = password, validePassword(password) {
            self.passwordReg = password
        } else {
            self.passwordReg = ""
        }
        print("passwordReg: \(self.passwordReg)")
    }

    public func setConfirmPasswordReg(_ password: String?) {
        if let password = password, validePassword(password) {
            self.confirmPasswordReg = password
        } else {
            self.confirmPasswordReg = ""
        }
        print("confirmPasswordReg: \(self.confirmPasswordReg)")
    }

    public func setNameReg(_ name: String?) {
        if let name = name, !name.isEmpty {
            self.nameReg = name
        } else {
            self.nameReg = ""
        }
        print("nameReg: \(self.nameReg)")
    }

    public func setSurnameReg(_ name: String?) {
        if let name = name, !name.isEmpty {
            self.surnameReg = name
        } else {
            self.surnameReg = ""
        }
        print("surnameReg: \(self.surnameReg)")
    }

    public func isLogin() -> Bool {
        valideEmail(email) && validePassword(password) && email == emailReg && password == passwordReg
    }

    public func isValid() -> Bool {
        valideEmail(email) && validePassword(password)
    }

    public func isValidSignup() -> Bool {
        valideEmail(emailReg) && validePassword(passwordReg) && passwordReg == confirmPasswordReg && !nameReg.isEmpty && !surnameReg.isEmpty
    }
}
