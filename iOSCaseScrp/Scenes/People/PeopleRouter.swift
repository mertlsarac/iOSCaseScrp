//
//  PeopleRouter.swift
//  iOSCase
//
//  Created by Mert Saraç on 18.09.2021.
//

import UIKit

typealias PeopleEntryPoint = PeopleViewControllerProcotol & UIViewController

protocol PeopleRouterProtocol {
    var entry: PeopleEntryPoint? { get }
    static func build() -> PeopleRouterProtocol
}

final class PeopleRouter: PeopleRouterProtocol {
    private enum Constants {
        static let viewControllerName = "PeopleViewController"
    }
    
    var entry: PeopleEntryPoint?
    
    static func build() -> PeopleRouterProtocol {
        let router = PeopleRouter()
        
        let storyboard = UIStoryboard.init(type: .people)
        var view = storyboard.instantiateViewController(withIdentifier: Constants.viewControllerName) as! PeopleViewControllerProcotol
        
        var presenter: PeoplePresenterProtocol = PeoplePresenter()
        var interactor: PeopleInteractorProtocol = PeopleInteractor(peopleManager: PeopleManager(), timerManager: TimerManager())
        
        view.presenter = presenter
        interactor.presenter = presenter
        
        presenter.router = router
        presenter.view = view
        presenter.interactor = interactor
        
        router.entry = view as? PeopleEntryPoint
        
        return router
    }
}
