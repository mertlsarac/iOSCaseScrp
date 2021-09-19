//
//  UIButton.swift
//  iOSCase
//
//  Created by Mert Saraç on 19.09.2021.
//

import UIKit

extension UIButton {
    static func getDefaultButton(text: String) -> UIButton {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemGray
        button.setTitle(text, for: .normal)
        return button
    }
}
