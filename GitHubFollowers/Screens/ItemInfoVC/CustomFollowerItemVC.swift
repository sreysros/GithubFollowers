//
//  CustomFollowerItemVC.swift
//  GitHubFollowers
//
//  Created by SreySros on 21/8/22.
//

import UIKit

class CustomFollowerItemVC: CustomItemInfoVC {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureItem()
    }
    
    private func configureItem() {
        itemInfoViewOne.set(itemInfoType: .followers, withCount: user.followers)
        itemInfoViewTwo.set(itemInfoType: .following, withCount: user.following)
        actionButton.set(backgroundColor: .systemGreen, title: "Get Followers")
    }

}

