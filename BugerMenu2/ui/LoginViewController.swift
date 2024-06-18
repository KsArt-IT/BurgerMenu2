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
    @IBOutlet weak var rememberLabel: UILabel!

    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passText: UITextField!

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
        passText.applyBorderStyle()
        passText.attributedPlaceholder = AppStrings.passPlaceholder

        loginButton.setTitle(AppStrings.loginButton, for: .normal)
        loginButton.applyGradient()

        signUpButton.setTitle(AppStrings.signUP, for: .normal)
        signUpButton.applyGradient(.lightGrayWhite)
    }

    @IBAction func changeRemember(_ sender: UISwitch) {
        rememberLabel.isEnabled = sender.isOn
    }

    @IBAction func login(_ sender: Any) {
        // проверить данные и войти
    }

    @IBAction func signUp(_ sender: Any) {
        // перейти на экран регистрации
    }
    
}
