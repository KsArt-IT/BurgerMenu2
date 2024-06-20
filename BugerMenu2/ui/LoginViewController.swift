//
//  LoginViewController.swift
//  BugerMenu2
//
//  Created by KsArT on 18.06.2024.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var emailHintLabel: UILabel!
    @IBOutlet weak var passHintLabel: UILabel!

    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passText: UITextField!

    @IBOutlet weak var rememberLabel: UILabel!
    @IBOutlet weak var rememberSwitch: UISwitch!

    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
    }

    private func initView() {
        titleLabel.text = AppStrings.loginTitle
        titleLabel.text = AppStrings.rememberHint
        emailHintLabel.text = AppStrings.emailHint
        passHintLabel.text = AppStrings.passHint
        rememberLabel.text = AppStrings.rememberHint
        rememberLabel.isEnabled = rememberSwitch.isOn

        emailText.applyBorderStyle()
        emailText.attributedPlaceholder = AppStrings.emailPlaceholder
        emailText.delegate = self
        passText.applyBorderStyle()
        passText.attributedPlaceholder = AppStrings.passPlaceholder
        passText.delegate = self

        loginButton.setTitle(AppStrings.loginButton, for: .normal)
        loginButton.applyGradient()
        loginButton.isEnabled = false

        signUpButton.setTitle(AppStrings.signUP, for: .normal)
        signUpButton.applyGradient(.lightGrayWhite)
    }

    @IBAction func changeRemember(_ sender: UISwitch) {
        rememberLabel.isEnabled = sender.isOn
    }

    @IBAction func loginClick(_ sender: Any) {
        // проверить данные и войти
    }

    @IBAction func signUpClick(_ sender: Any) {
        // перейти на экран регистрации
    }
    
}

extension LoginViewController: UITextFieldDelegate {

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard !string.isEmpty else { return true }

        switch textField {
            case emailText:
                return Validate.shared.valideCharForEmail(string)
            case passText:
                return Validate.shared.valideCharForPassword(string)
            default:
                break
        }
        return true
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        loginButton.isEnabled = Validate.shared.isValid()
        if textField == loginButton {
            return passText.becomeFirstResponder()
        } else {
            return textField.resignFirstResponder()
        }
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField {
            case emailText:
                Validate.shared.setEmail(emailText.text)
            case passText:
                Validate.shared.setPassword(passText.text)
            default:
                break
        }
        loginButton.isEnabled = Validate.shared.isValid()
    }
}
