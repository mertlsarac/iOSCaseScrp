//
//  PeopleViewController.swift
//  iOSCase
//
//  Created by Mert Saraç on 18.09.2021.
//

import UIKit

protocol PeopleViewControllerProcotol {
    var presenter: PeoplePresenterProtocol? { get set }
    
    func setPeople(people: [Person])
    func showError(error: String, buttonText: String, retry: Bool)
    func startRefreshLoader()
    func stopRefreshLoader()
    func showEmptyList(with text: String)
    func hideTableView()
    func displayTableView()
    func hideNoPersonUI()
}

class PeopleViewController: UIViewController {
    @IBOutlet weak var peopleTableView: UITableView!
    var noPersonLabel: UILabel?
    var retryButton: UIButton?
    
    lazy var refreshControl = UIRefreshControl()
    
    var presenter: PeoplePresenterProtocol?
    
    var people: [Person] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureRefreshControl()
        
        presenter?.viewDidLoad()
    }
    
    private func configureRefreshControl() {
        peopleTableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refreshed), for: .valueChanged)
    }
    
    @objc func refreshed(refreshControl: UIRefreshControl) {
        presenter?.pageRefreshed()
    }
    
    @objc func retryButtonTapped() {
        presenter?.retryTapped(with: .button)
    }
}

extension PeopleViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        people.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PeopleTableViewCell", for: indexPath) as? PeopleTableViewCell else {
            fatalError("Could not find cell")
        }
        cell.set(person: people[indexPath.row])
        return cell
    }
}

extension PeopleViewController: PeopleViewControllerProcotol {
    
    func setPeople(people: [Person]) {
        self.people = people
        DispatchQueue.main.async {
            self.peopleTableView.reloadData()
        }
    }
    
    func showError(error: String, buttonText: String, retry: Bool) {
        let alert = UIAlertController(title: "", message: error, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: buttonText, style: .default, handler: { action in
            if retry {
                self.presenter?.retryTapped(with: .popup)
            }
        }))
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func startRefreshLoader() {
        DispatchQueue.main.async {
            self.refreshControl.programaticallyBeginRefreshing(in: self.peopleTableView)
        }
    }
    
    func stopRefreshLoader() {
        DispatchQueue.main.async {
            self.refreshControl.programaticallyEndRefreshing(in: self.peopleTableView)
        }
    }
    
    func showEmptyList(with text: String) {
        let emptyLabel = UILabel.getDefaultLabel(text: text)
        self.view.addSubview(emptyLabel)
        emptyLabel.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        emptyLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        emptyLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -15).isActive = true
        self.noPersonLabel = emptyLabel
        
        let retryButton = UIButton.getDefaultButton(text: "Retry")
        retryButton.addTarget(self, action: #selector(retryButtonTapped), for: .touchUpInside)
        self.view.addSubview(retryButton)
        retryButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15).isActive = true
        retryButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15).isActive = true
        retryButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        retryButton.topAnchor.constraint(equalTo: emptyLabel.bottomAnchor, constant: 25).isActive = true
        self.retryButton = retryButton
    }
    
    func hideTableView() {
        DispatchQueue.main.async {
            self.peopleTableView.isHidden = true
        }
    }
    
    func displayTableView() {
        DispatchQueue.main.async {
            self.peopleTableView.isHidden = false
        }
    }
    
    func hideNoPersonUI() {
        DispatchQueue.main.async {
            self.noPersonLabel?.removeFromSuperview()
            self.retryButton?.removeFromSuperview()
        }
    }
}
