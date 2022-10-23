//
//  FollowerCell.swift
//  GitHubFollowers
//
//  Created by SreySros on 9/8/22.
//

import UIKit
import SnapKit

class FollowerCell: UICollectionViewCell {
    static let reuseID = "FollowerCell"
    let avatarImageView = CustomImageView(frame: .zero)
    let usernameLabel = CustomLabel(textAlignment: .center, fontSize: 16)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(follower: Follower) {
        avatarImageView.downloadImage(fromUrl: follower.avatarUrl)
        usernameLabel.text = follower.login
    }
    
    func configure() {
        addSubView(avatarImageView, usernameLabel)
        
        let padding: CGFloat = 8
        
        avatarImageView.snp.makeConstraints {
            $0.top.equalTo(padding)
            $0.leading.trailing.equalToSuperview().inset(padding)
            $0.height.equalTo(avatarImageView.snp.width)
        }

        usernameLabel.snp.makeConstraints {
            $0.top.equalTo(avatarImageView.snp.bottom).offset(12)
            $0.leading.trailing.equalToSuperview().inset(padding)
            $0.height.equalTo(20)
        }
    }
    
}
