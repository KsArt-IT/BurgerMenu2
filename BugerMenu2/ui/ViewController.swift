//
//  ViewController.swift
//  BugerMenu2
//
//  Created by KsArT on 18.06.2024.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        isLogin()
    }

    private func isLogin() {
        if !Validate.shared.isLogin() {
            title = ""
            toLoginScreen()
        } else {
            title = "Hi \(Validate.shared.getName())"
        }
    }

    @IBAction func logoutClick(_ sender: Any) {
        Validate.shared.logout()
        isLogin()
    }

    private func toLoginScreen() {
        performSegue(withIdentifier: "toLoginScreenSID", sender: nil)
    }
}

