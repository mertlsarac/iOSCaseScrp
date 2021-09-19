//
//  Storyboard.swift
//  iOSCase
//
//  Created by Mert Saraç on 18.09.2021.
//

import UIKit

extension UIStoryboard {
    convenience init(type: StoryboardType) {
        self.init(type: type, bundle: nil)
    }
    
    convenience init(type: StoryboardType, bundle: Bundle?) {
        switch type {
        case .people:
            self.init(name: "People", bundle: bundle)
        }
    }
}

enum StoryboardType {
    case people
}
