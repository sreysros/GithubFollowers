//
//  CustomFollowerItemVC.swift
//  GitHubFollowers
//
//  Created by SreySros on 21/8/22.
//

import UIKit

protocol CustomFollowerItemVCDelegate: AnyObject {
    func didTapGetFollowers(for user: User)
}

class CustomFollowerItemVC: CustomItemInfoVC {
    weak var delegate: CustomFollowerItemVCDelegate!
    
    init(user: User, delegate: CustomFollowerItemVCDelegate) {
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
        itemInfoViewOne.set(itemInfoType: .followers, withCount: user.followers)
        itemInfoViewTwo.set(itemInfoType: .following, withCount: user.following)
        actionButton.set(backgroundColor: .systemGreen, title: "Get Followers")
    }
    
    override func actionButtonTapped() {
        delegate.didTapGetFollowers(for: user)
    }

}

