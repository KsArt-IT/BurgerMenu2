//
//  LoginViewController.swift
//  BugerMenu2
//
//  Created by KsArT on 18.06.2024.
//

import UIKit

class LoginViewController: UIViewController {

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
        title = AppStrings.loginTitle

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
        updateLoginData()
        if Validate.shared.isValid() {
            if Validate.shared.login(rememberSwitch.isOn) {
                navigationController?.popViewController(animated: true)
            } else {
                showAlert("Error!", message: AppStrings.loginErrorUser)
            }
        } else {
            showAlert("Error!", message: AppStrings.loginError)
        }
    }

    private func updateLoginData() {
        Validate.shared.setEmail(emailText.text)
        Validate.shared.setPassword(passText.text)
    }
}

extension LoginViewController: UITextFieldDelegate {

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard !string.isEmpty else { return true }
        
        // Получение текущего текста
        let currentText = textField.text ?? ""

        // Получение нового текста после замены
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        
        // Определение валидности символа и обновленного текста в зависимости от поля ввода
        var isValidChar: Bool = true
        var isValidData: Bool?

        switch textField {
            case emailText:
                isValidChar = Validate.shared.valideCharForEmail(string)
                isValidData = Validate.shared.isValid(email: updatedText)
            case passText:
                isValidChar = Validate.shared.valideCharForPassword(string)
                isValidData = Validate.shared.isValid(password: updatedText)
            default:
                break
        }
        if isValidChar {
            loginButton.isEnabled = isValidData ?? Validate.shared.isValid()
        }
        return isValidChar
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        loginButton.isEnabled = Validate.shared.isValid()
        if textField == loginButton {
            return passText.becomeFirstResponder()
        } else {
            return textField.resignFirstResponder()
        }
    }

    // окончание редактирования
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
