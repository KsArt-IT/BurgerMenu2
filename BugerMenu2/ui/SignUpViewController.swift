//
//  SignUpViewController.swift
//  BugerMenu2
//
//  Created by KsArT on 20.06.2024.
//

import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet weak var emailHintLabel: UILabel!
    @IBOutlet weak var passHintLabel: UILabel!
    @IBOutlet weak var confirmPassHintLabel: UILabel!
    @IBOutlet weak var nameHintLabel: UILabel!
    @IBOutlet weak var surnameHintLabel: UILabel!

    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var confirmPassText: UITextField!
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var surnameText: UITextField!
    
    @IBOutlet weak var userAgreementButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
    }

    private func initView() {
        title = AppStrings.signUP
        emailHintLabel.text = AppStrings.emailHint
        passHintLabel.text = AppStrings.passHint
        confirmPassHintLabel.text = AppStrings.confirmPassHint
        nameHintLabel.text = AppStrings.nameHint
        surnameHintLabel.text = AppStrings.surnameHint

        emailText.applyBorderStyle()
        emailText.attributedPlaceholder = AppStrings.emailPlaceholder
        emailText.delegate = self

        passwordText.applyBorderStyle()
        passwordText.attributedPlaceholder = AppStrings.passPlaceholder
        passwordText.delegate = self

        confirmPassText.applyBorderStyle()
        confirmPassText.attributedPlaceholder = AppStrings.passPlaceholder
        confirmPassText.delegate = self

        nameText.applyBorderStyle()
        nameText.attributedPlaceholder = AppStrings.namePlaceholder
        nameText.delegate = self

        surnameText.applyBorderStyle()
        surnameText.attributedPlaceholder = AppStrings.surnamePlaceholder
        surnameText.delegate = self

        userAgreementButton.setTitle(AppStrings.agreementTitle, for: .normal)
        
        signUpButton.setTitle(AppStrings.signUP, for: .normal)
        signUpButton.applyGradient()
        signUpButton.isEnabled = false
    }

    @IBAction func showUserAgreement(_ sender: Any) {
        performSegue(withIdentifier: "toUserAgreementScreenSID", sender: nil)
    }

    @IBAction func signUpClick(_ sender: Any) {
        updateDataSignUp()
        if Validate.shared.isValidSignup() {
            if !Validate.shared.isUserAgreement() {
                showUserAgreement(self)
            } else {
                if Validate.shared.signup() {
                    navigationController?.popViewController(animated: true)
                } else {
                    showAlert("Error!", message: AppStrings.signUPErrorUser)
                }
            }
        } else {
            showAlert("Error!", message: AppStrings.signUPError)
        }
    }

    private func updateDataSignUp() {
        Validate.shared.setEmailReg(emailText.text)
        Validate.shared.setPasswordReg(passwordText.text)
        Validate.shared.setConfirmPasswordReg(confirmPassText.text)
        Validate.shared.setNameReg(nameText.text)
        Validate.shared.setSurnameReg(surnameText.text)
    }

}

extension SignUpViewController: UITextFieldDelegate {
    
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
                isValidData = Validate.shared.isValidSignup(email: updatedText)
            case passwordText:
                isValidChar =  Validate.shared.valideCharForPassword(string)
                isValidData = Validate.shared.isValidSignup(password: updatedText)
            case confirmPassText:
                isValidChar =  Validate.shared.valideCharForPassword(string)
                isValidData = Validate.shared.isValidSignup(passwordConfirm: updatedText)
            case nameText:
                isValidChar =  Validate.shared.valideCharForName(string)
                isValidData = Validate.shared.isValidSignup(name: updatedText)
            case surnameText:
                isValidChar =  Validate.shared.valideCharForName(string)
                isValidData = Validate.shared.isValidSignup(surname: updatedText)
            default:
                break
        }
        signUpButton.isEnabled = isValidData ?? Validate.shared.isValidSignup()
        return isValidChar
    }

    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        signUpButton.isEnabled = Validate.shared.isValidSignup()
        return true
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        signUpButton.isEnabled = Validate.shared.isValidSignup()
        switch textField {
            case emailText:
                passwordText.becomeFirstResponder()
            case passwordText:
                confirmPassText.becomeFirstResponder()
            case confirmPassText:
                nameText.becomeFirstResponder()
            case nameText:
                surnameText.becomeFirstResponder()
            case surnameText:
                emailText.becomeFirstResponder()
            default:
                textField.resignFirstResponder()
        }
        return true
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField {
            case emailText:
                Validate.shared.setEmailReg(emailText.text)
            case passwordText:
                Validate.shared.setPasswordReg(passwordText.text)
            case confirmPassText:
                Validate.shared.setConfirmPasswordReg(confirmPassText.text)
            case nameText:
                Validate.shared.setNameReg(nameText.text)
            case surnameText:
                Validate.shared.setSurnameReg(surnameText.text)
            default:
                break
        }
        signUpButton.isEnabled = Validate.shared.isValidSignup()
    }
}
