//
//  UserInfoView.swift
//  GitHubFollowers
//
//  Created by sreysros_leak on 3/11/22.
//

import UIKit
import SnapKit

class UserInfoView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let scrollView = UIScrollView()
    let contentView = UIView()
    let headerView = UIView()
    let itemViewOne = UIView()
    let itemViewTwo = UIView()
    let dateLabel = CustomBodyLabel(textAlignment: .center)
    
    func configure() {
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(headerView)
        contentView.addSubview(itemViewOne)
        contentView.addSubview(itemViewTwo)
        contentView.addSubview(dateLabel)
        
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints {
            $0.top.equalTo(layoutMarginsGuide)
            $0.leading.trailing.bottom.equalTo(layoutMarginsGuide)
            $0.height.equalTo(600)
        }
        
        headerView.snp.makeConstraints {
            $0.top.equalTo(layoutMarginsGuide)
            $0.leading.trailing.equalTo(layoutMarginsGuide)
            $0.height.equalTo(180)
        }
        
        itemViewOne.snp.makeConstraints {
            $0.top.equalTo(headerView.snp.bottom).offset(20)
            $0.leading.trailing.equalTo(layoutMarginsGuide)
            $0.height.equalTo(140)
        }
        
        itemViewTwo.snp.makeConstraints {
            $0.top.equalTo(itemViewOne.snp.bottom).offset(20)
            $0.leading.trailing.equalTo(layoutMarginsGuide)
            $0.height.equalTo(140)
        }
        
        dateLabel.snp.makeConstraints {
            $0.top.equalTo(itemViewTwo.snp.bottom).offset(20)
            $0.leading.trailing.equalTo(layoutMarginsGuide)
            $0.height.equalTo(18)
        }
    }
}
