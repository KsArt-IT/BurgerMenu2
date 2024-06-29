//
//  UIViewExt.swift
//  BugerMenu2
//
//  Created by KsArT on 18.06.2024.
//

import UIKit

extension UIButton {

    func applyGradient(_ color: UIColor = .mainBlue) {
        let externalColor = color.withAlphaComponent(0.3).cgColor
        let centerColor = color.withAlphaComponent(0.21).cgColor

        let gradient = CAGradientLayer()

        gradient.frame = CGRect(x: 0, y: 0, width: 1000, height: self.frame.size.height)

        gradient.colors = [externalColor, centerColor, externalColor]
        gradient.startPoint = CGPoint(x: 0.5, y: 0)
        gradient.endPoint = CGPoint(x: 0.5, y: 1)
        gradient.locations = [-0.1, 0.5, 1.1]

        self.layer.addSublayer(gradient)
        self.layer.cornerRadius = Constants.cornerRadius
        self.clipsToBounds = true
    }
}

extension UIView {

    func applyBorderStyle() {
        self.layer.cornerRadius = Constants.cornerRadius
        self.layer.borderWidth = Constants.borderWidth
        self.layer.borderColor = UIColor.darkBlue.withAlphaComponent(0.3).cgColor
        self.layer.masksToBounds = true
    }

    func animateCorner(){
        UIView.animate(withDuration: 0.5, delay: 0.5, options: [.autoreverse,.repeat]) { [weak self] in
            self?.layer.cornerRadius = Constants.cornerRadius
        }
    }
}

extension UIViewController {

    func showAlert(_ title: String = "", message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }

}
