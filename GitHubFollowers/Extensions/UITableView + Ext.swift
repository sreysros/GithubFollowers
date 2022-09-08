//
//  UITableView + Ext.swift
//  GitHubFollowers
//
//  Created by SreySros on 27/8/22.
//

import UIKit

extension UITableView {
    
    func reloadTableOnMainThread() {
        DispatchQueue.main.async {
            self.reloadData()
        }
    }
    
    func removeExcessCells () {
        tableFooterView = UIView(frame: .zero)
    }
}
