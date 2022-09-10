//
//  CustomRepoItemVC.swift
//  GitHubFollowers
//
//  Created by SreySros on 21/8/22.
//

import UIKit

protocol CustomRepoItemVCDelegate: AnyObject {
    func didTapGitHubProfile(for user: User)
}

class CustomRepoItemVC: CustomItemInfoVC {
    weak var delegate: CustomRepoItemVCDelegate!
    
    init(user: User, delegate: CustomRepoItemVCDelegate) {
        super.init(user: user)
        self.delegate = delegate
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItem()
    }
    
    private func configureItem() {
        itemInfoViewOne.set(itemInfoType: .repos, withCount: user.publicRepos)
        itemInfoViewTwo.set(itemInfoType: .gists, withCount: user.publicGists)
        actionButton.set(backgroundColor: .systemPurple, title: "GitHub Profile")
    }
    
    override func actionButtonTapped() {
        delegate.didTapGitHubProfile(for: user)
    }

}
