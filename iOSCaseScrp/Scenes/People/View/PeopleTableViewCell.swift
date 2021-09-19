//
//  PeopleTableViewCell.swift
//  iOSCase
//
//  Created by Mert Saraç on 18.09.2021.
//

import UIKit

class PeopleTableViewCell: UITableViewCell {
    @IBOutlet weak var personLabel: UILabel!
    
    func set(person: Person) {
        personLabel.text = "\(person.fullName) (\(person.id))"
    }
}
