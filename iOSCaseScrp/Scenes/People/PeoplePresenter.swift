//
//  PeoplePresenter.swift
//  iOSCase
//
//  Created by Mert Saraç on 18.09.2021.
//

import Foundation

struct PeoplePresenterConstants {
    static let emptyListText = "No one here :)"
    static let retryButtonName = "Retry"
    static let okButtonName = "Okay"
}

enum RetryButtonType {
    case popup, button
}

protocol PeoplePresenterProtocol {
    var router: PeopleRouterProtocol? { get set }
    var interactor: PeopleInteractorProtocol? { get set }
    var view: PeopleViewControllerProcotol? { get set }
    
    var next: String? { get }
    
    func viewDidLoad()
    func peopleDidFetch(with : Result<FetchResponse, FetchError>)
    func pageRefreshed()
    func retryTapped(with type: RetryButtonType)
    func tooMuchRequestReceived()
}

class PeoplePresenter: PeoplePresenterProtocol {
    var router: PeopleRouterProtocol?
    var interactor: PeopleInteractorProtocol?
    var view: PeopleViewControllerProcotol?
    
    var next: String?
    
    var tooMuchRequestError: String {
        "You can try \(TimerManagerConstants.maxNumberOfRequestInTimeInterval) requests in \(Int(TimerManagerConstants.timeIntervalThreshold)) second."
    }
    
    func viewDidLoad() {
        fetchPeople()
    }
    
    func peopleDidFetch(with result: Result<FetchResponse, FetchError>) {
        view?.stopRefreshLoader()

        switch result {
        case .success(let response):
            self.next = response.next
            
            let filteredPeopleList = interactor!.checkBackendBug(list: response.people)
            
            if response.people.count > 0 {
                view?.setPeople(people: filteredPeopleList)
            } else {
                view?.hideTableView()
                view?.showEmptyList(with: PeoplePresenterConstants.emptyListText)
            }
            
        case .failure(let error):
            view?.showError(error: error.errorDescription, buttonText: PeoplePresenterConstants.retryButtonName, retry: true)
        }
    }
    
    func pageRefreshed() {
        fetchPeople()
    }
    
    func retryTapped(with type: RetryButtonType) {
        switch type {
        case .button:
            view?.hideNoPersonUI()
            view?.displayTableView()
        case .popup:
            break
        }
        
        fetchPeople()
    }
    
    private func fetchPeople() {
        view?.displayTableView()
        view?.startRefreshLoader()
        
        // if it is first requeest, do not add request time queue
        var isFirstRequest = next == nil ? true : false
        
        interactor?.fetchPeople(next: next, checkTime: isFirstRequest)
    }
    
    func tooMuchRequestReceived() {
        view?.stopRefreshLoader()
        view?.showError(error: tooMuchRequestError, buttonText: PeoplePresenterConstants.okButtonName, retry: false)
    }
}
