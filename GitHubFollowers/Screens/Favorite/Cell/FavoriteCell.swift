//
//  FavoriteCell.swift
//  GitHubFollowers
//
//  Created by SreySros on 25/8/22.
//

import UIKit
import SnapKit

class FavoriteCell: UITableViewCell {
    
    static let reuseID = "FavoriteCell"
    let avatarImageView = CustomImageView(frame: .zero)
    let usernameLabel = CustomLabel(textAlignment: .left, fontSize: 26)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
            super.prepareForReuse()
            avatarImageView.image = UIImage(named: "avatar-placeholder")
    }
    
    func set(favorite: Follower) {
        avatarImageView.downloadImage(fromUrl: favorite.avatarUrl)
        usernameLabel.text = favorite.login
    }
    
    func configure() {
        addSubView(avatarImageView, usernameLabel)
        
        accessoryType = .disclosureIndicator
        let padding: CGFloat = 12
        
        avatarImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(layoutMarginsGuide).inset(padding)
            $0.size.equalTo(60)
        }
        
        usernameLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(avatarImageView.snp.trailing).inset(24)
            $0.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(40)
        }
        
        
    }
    
}
