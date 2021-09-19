//
//  UIRefreshControl.swift
//  iOSCase
//
//  Created by Mert Saraç on 19.09.2021.
//

import UIKit

extension UIRefreshControl {
    func programaticallyBeginRefreshing(in tableView: UITableView) {
        beginRefreshing()
        let offsetPoint = CGPoint.init(x: 0, y: -frame.size.height)
        tableView.setContentOffset(offsetPoint, animated: true)
    }
    
    func programaticallyEndRefreshing(in tableView: UITableView) {
        endRefreshing()

        UIView.animate(withDuration: 0.5, animations: {
            tableView.contentOffset = CGPoint.zero
        })
    }
}
