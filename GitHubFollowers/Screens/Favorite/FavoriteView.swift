//
//  FavoriteView.swift
//  GitHubFollowers
//
//  Created by SreySros on 17/9/22.
//

import UIKit
import SnapKit

class FavoriteView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let tableView: UITableView = {
       let tableView = UITableView()
        tableView.rowHeight = 80
        return tableView
    }()
    
    func configure() {
        addSubView(tableView)
        
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

