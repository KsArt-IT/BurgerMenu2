//
//  ViewController.swift
//  BugerMenu2
//
//  Created by KsArT on 18.06.2024.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        isLogin()
    }

    private func isLogin() {
        if !Validate.shared.isLogin() {
            performSegue(withIdentifier: "toLoginScreenSID", sender: nil)
        } else {
            print("online")
        }
    }
}

