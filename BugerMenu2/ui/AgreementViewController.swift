//
//  AgreementViewController.swift
//  BugerMenu2
//
//  Created by KsArT on 20.06.2024.
//

import UIKit

class AgreementViewController: UIViewController {

    @IBOutlet weak var agreementText: UITextView!
    @IBOutlet weak var okButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
    }
 
    private func initView() {
        title = AppStrings.agreementTitle
        agreementText.text = AppStrings.agreementText
        okButton.applyGradient()
    }

    @IBAction func okClick(_ sender: Any) {
        Validate.shared.setUserAgreement()

        navigationController?.popViewController(animated: true)
    }

}
