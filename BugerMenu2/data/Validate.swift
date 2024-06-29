//
//  Validate.swift
//  BugerMenu2
//
//  Created by KsArT on 19.06.2024.
//

import Foundation

class Validate {

    static let shared = Validate()

    // MARK: - Constants
    static let rememberDate = "rememberDate"
    static let rememberEmail = "rememberEmail"

    static let emailCharRegex = "^(?=.{1,253})(?=.*[A-Za-z0-9@._%+-]).*$"
    static let emailRegex = "^(?=[a-z0-9][a-z0-9@._%+-]{5,253}$)([a-z0-9_-]+\\.)*[a-z0-9_-]+@[a-z0-9_-]+(\\.[a-z0-9_-]+)*\\.[a-z]{2,63}$"

    static let passwordCharRegex = "^(?=.{1,20})(?=[A-Za-z0-9~@]).*$"
    //let passwordCharRegex = "^(?=.{1,20})(?=.*[A-Za-z0-9~@#$%^&+-*!=]).*$"
    static let passwordRegex = "^(?=.{8,20})(?=.*[a-z])(?=.*[0-9])(?=.*[A-Z])(?=.*[~@]).*$"
//    static let passwordRegex = "^(?=.{8,20})(?=.*[a-z])(?=.*[0-9])(?=.*[A-Z])(?=.*[~@#$%\\^&+-\\*!=]).*$"

    // MARK: - Init
    private var email = ""
    private var password = ""

    private var userReg = Validate.getEmptyUser()
    private var userOnline = Validate.getEmptyUser()

    private init() {}

    private static func getEmptyUser() -> User {
        User(name: "", surname: "", email: "", password: "", passwordConfirm: "", userAgreement: false, registration: nil)
    }

    public func getName() -> String {
        userOnline.name
    }

    // MARK: - Validate
    public func valideCharForEmail(_ email: String) -> Bool {
        NSPredicate(format: "SELF MATCHES %@", Validate.emailCharRegex).evaluate(with: email)
    }

    public func valideCharForPassword(_ password: String) -> Bool {
        NSPredicate(format: "SELF MATCHES %@", Validate.passwordCharRegex).evaluate(with: password)
    }

    public func valideCharForName(_ password: String) -> Bool {
        for char in password {
            if !char.isLetter {
                return false
            }
        }
        return true
    }

    private func valideEmail(_ email: String) -> Bool {
        !email.isEmpty && NSPredicate(format: "SELF MATCHES %@", Validate.emailRegex).evaluate(with: email.lowercased())
    }

    private func validePassword(_ password: String) -> Bool {
        !password.isEmpty && NSPredicate(format: "SELF MATCHES %@", Validate.passwordRegex).evaluate(with: password)
    }

    public func isUserAgreement() -> Bool {
        userReg.userAgreement
    }

    public func isLogin() -> Bool {
        if let dateEnd = UserDefaults.standard.value(forKey: Validate.rememberDate) as? Date {
            if Date() < dateEnd {
                if let mail = UserDefaults.standard.string(forKey: Validate.rememberEmail),
                   let data = getUser(of: mail),
                   let user = try? PropertyListDecoder().decode(User.self, from: data) {
                    userOnline = user
                    return true
                }
            }
        }
        return !self.email.isEmpty && login()
    }

    public func isValid(email: String? = nil, password: String? = nil) -> Bool {
        valideEmail(email ?? self.email) && validePassword(password ?? self.password)
    }

    public func isValidSignup(
        email: String? = nil,
        password: String? = nil, passwordConfirm: String? = nil,
        name: String? = nil, surname: String? = nil
    ) -> Bool {
        valideEmail(email ?? userReg.email) &&
        validePassword(password ?? userReg.password) &&
        (password ?? userReg.password) == (passwordConfirm ?? userReg.passwordConfirm) &&
        !(name ?? userReg.name).isEmpty && !(surname ?? userReg.surname).isEmpty
    }

    // MARK: - Update User
    public func setEmail(_ email: String?) {
        if let email = email, valideEmail(email) {
            self.email = email
        } else {
            self.email = ""
        }
    }

    public func setPassword(_ password: String?) {
        if let password = password, validePassword(password) {
            self.password = password
        } else {
            self.password = ""
        }
    }

    public func setEmailReg(_ email: String?) {
        if let email = email, valideEmail(email) {
            updateUserReg(email: email)
        } else {
            updateUserReg(email: "")
        }
    }

    public func setPasswordReg(_ password: String?) {
        if let password = password, validePassword(password) {
            updateUserReg(password: password)
        } else {
            updateUserReg(password: "")
        }
    }

    public func setConfirmPasswordReg(_ password: String?) {
        if let password = password, validePassword(password) {
            updateUserReg(confirmPassword: password)
        } else {
            updateUserReg(confirmPassword: "")
        }
    }

    public func setNameReg(_ name: String?) {
        if let name = name, !name.isEmpty {
            updateUserReg(name: name)
        } else {
            updateUserReg(name: "")
        }
    }

    public func setSurnameReg(_ name: String?) {
        if let name = name, !name.isEmpty {
            updateUserReg(surname: name)
        } else {
            updateUserReg(surname: "")
        }
    }

    public func setUserAgreement() {
        updateUserReg(userAgreement: true)
    }

    private func updateUserReg(
        name: String? = nil, surname: String? = nil,
        email: String? = nil, password: String? = nil, confirmPassword: String? = nil,
        userAgreement: Bool? = nil, date: Date? = nil
    ) {
        self.userReg = User(
            name: name ?? userReg.name,
            surname: surname ?? userReg.surname,
            email: email?.trimmingCharacters(in: .whitespaces).lowercased() ?? userReg.email,
            password: password ?? userReg.password,
            passwordConfirm: confirmPassword ?? userReg.passwordConfirm,
            userAgreement: userAgreement ?? userReg.userAgreement,
            registration: date ?? userReg.registration
        )
    }

    // MARK: - Sing Up
    public func signup() -> Bool {
        guard isValidSignup() else { return false }

        // проверить такого пользователя
        if getUser(of: userReg.email) == nil {
            // обновить дату регистрации
            updateUserReg(date: Date())
            // сохранить
            if let data = try? PropertyListEncoder().encode(userReg), saveUser(of: userReg.email, data: data) {
                userReg = Validate.getEmptyUser()
                email = ""
                password = ""
                return true
            } else {
                print("Failed to encode user data")
            }
        } else {
            print("User already exists")
        }
        return false
    }

    // MARK: - Login
    public func login(_ remember: Bool = false) -> Bool {
        guard !self.email.isEmpty else { return false }

        // проверить такого пользователя
        if let data = getUser(of: self.email) {
            do {
                let user = try PropertyListDecoder().decode(User.self, from: data)
                print("Decoded user: \(user)")
                if user.email == self.email && user.password == self.password {
                    if remember {
                        rememberEndDate()
                    }
                    userOnline = user
                    return true
                } else {
                    print("Email or password do not match")
                }
            } catch {
                print("Error decoding user: \(error)")
            }
        } else {
            print("No data found for email: \(self.email)")
        }
        return false
    }

    public func logout() {
        rememberEndDate(logout: true)
        self.email = ""
        self.password = ""
    }

    private func saveUser(of email: String, data: Data) -> Bool {
        guard !email.isEmpty else { return false }

        let key = email.trimmingCharacters(in: .whitespaces).lowercased()
        print("Save key user: \(key)")
        // сохраним
        UserDefaults.standard.setValue(data, forKey: key)
        UserDefaults.standard.synchronize()
        // прочитаем
        return (UserDefaults.standard.object(forKey: key) as? Data) != nil
    }

    private func getUser(of email: String) -> Data? {
        guard !email.isEmpty else { return nil }

        let key = email.trimmingCharacters(in: .whitespaces).lowercased()
        print("Read key user: \(key)")
        return UserDefaults.standard.object(forKey: key) as? Data
    }

    private func rememberEndDate(logout: Bool = false) {
        if logout {
            UserDefaults.standard.removeObject(forKey: Validate.rememberDate)
            UserDefaults.standard.removeObject(forKey: Validate.rememberEmail)
        } else {
            let calendar = Calendar.current
            let dateEnd = calendar.date(byAdding: .day, value: 2, to: calendar.startOfDay(for: Date()))
            UserDefaults.standard.setValue(dateEnd, forKey: Validate.rememberDate)
            UserDefaults.standard.setValue(self.email, forKey: Validate.rememberEmail)
        }
    }

}

// MARK: - User
public struct User: Codable {
    let name: String
    let surname: String
    let email: String
    let password: String
    let passwordConfirm: String
    let userAgreement: Bool
    let registration: Date?
}
