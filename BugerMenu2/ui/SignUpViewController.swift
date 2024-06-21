//
//  SignUpViewController.swift
//  BugerMenu2
//
//  Created by KsArT on 20.06.2024.
//

import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
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
        titleLabel.text = AppStrings.loginTitle
        titleLabel.text = AppStrings.rememberHint
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
        checkDataSignUp()
        if Validate.shared.isValidSignup() {
            if !Validate.shared.isUserAgreement() {
                showUserAgreement(self)
            } else {
                dismiss(animated: true)
            }
        } else {
            showAlert("Error!", message: AppStrings.signUPError)
        }
    }

    private func checkDataSignUp() {
        Validate.shared.setEmailReg(emailText.text)
        Validate.shared.setPasswordReg(passwordText.text)
        Validate.shared.setConfirmPasswordReg(confirmPassText.text)
        Validate.shared.setNameReg(confirmPassText.text)
        Validate.shared.setSurnameReg(confirmPassText.text)
    }

}

extension SignUpViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard !string.isEmpty else { return true }

        switch textField {
            case emailText:
                return Validate.shared.valideCharForEmail(string)
            case passwordText, confirmPassText:
                return Validate.shared.valideCharForPassword(string)
            case nameText, surnameText:
                return Validate.shared.valideCharForName(string)
            default:
                break
        }
        return true
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
                Validate.shared.setNameReg(confirmPassText.text)
            case surnameText:
                Validate.shared.setSurnameReg(confirmPassText.text)
            default:
                break
        }
        signUpButton.isEnabled = Validate.shared.isValidSignup()
    }
}
