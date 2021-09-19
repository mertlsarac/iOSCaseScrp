//
//  UILabel.swift
//  iOSCase
//
//  Created by Mert Saraç on 19.09.2021.
//

import UIKit

extension UILabel {
    static func getDefaultLabel(text: String) -> UILabel {
        let defaultLabel = UILabel()
        defaultLabel.text = text
        defaultLabel.translatesAutoresizingMaskIntoConstraints = false
        defaultLabel.lineBreakMode = .byWordWrapping
        defaultLabel.numberOfLines = 0
        defaultLabel.textAlignment = .center
        
        return defaultLabel
    }
}
