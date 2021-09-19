//
//  PeopleManager.swift
//  iOSCase
//
//  Created by Mert Saraç on 19.09.2021.
//

import Foundation

class PeopleManager {
    var ids: Set<Int> = []
    
    // this function checks the backend bug then return the proper list
    func checkBackendBug(newPeople: [Person]) -> [Person] {
        return newPeople.filter { person in
            if ids.contains(person.id) {
                return false
            } else {
                ids.insert(person.id)
                return true
            }
        }
    }
}
