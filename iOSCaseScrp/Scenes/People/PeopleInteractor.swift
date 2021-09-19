//
//  PeopleInteractor.swift
//  iOSCase
//
//  Created by Mert Saraç on 18.09.2021.
//

import Foundation

protocol PeopleInteractorProtocol {
    var presenter: PeoplePresenterProtocol? { get set }
    var peopleManager: PeopleManager { get }
    var timerManager: TimerManager { get }
    
    func fetchPeople(next: String?, checkTime: Bool)
    func checkBackendBug(list: [Person]) -> [Person]
}

class PeopleInteractor: PeopleInteractorProtocol {
    var presenter: PeoplePresenterProtocol?
    var peopleManager: PeopleManager
    var timerManager: TimerManager
    
    
    init(peopleManager: PeopleManager, timerManager: TimerManager) {
        self.peopleManager = peopleManager
        self.timerManager = timerManager
    }
    
    func fetchPeople(next: String?, checkTime: Bool) {
        timerManager.processRequest(checkTime: checkTime) { permission in
            guard permission else {
                self.presenter?.tooMuchRequestReceived()
                return
            }
            
            DataSource.fetch(next: next) { (response, error) in
                if let response = response {
                    self.presenter?.peopleDidFetch(with: .success(response))
                } else if let error = error {
                    self.presenter?.peopleDidFetch(with: .failure(error))
                } else {
                    print("unknown error")
                }
            }
        }

    }
    
    func checkBackendBug(list: [Person]) -> [Person] {
        return peopleManager.checkBackendBug(newPeople: list)
    }
}
