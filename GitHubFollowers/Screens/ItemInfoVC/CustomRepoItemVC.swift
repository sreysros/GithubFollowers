//
//  CustomRepoItemVC.swift
//  GitHubFollowers
//
//  Created by SreySros on 21/8/22.
//

import UIKit

class CustomRepoItemVC: CustomItemInfoVC {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureItem()
    }
    
    private func configureItem() {
        itemInfoViewOne.set(itemInfoType: .repos, withCount: user.publicRepos)
        itemInfoViewTwo.set(itemInfoType: .gists, withCount: user.publicGists)
        actionButton.set(backgroundColor: .systemPurple, title: "GitHub Profile")
    }

}
