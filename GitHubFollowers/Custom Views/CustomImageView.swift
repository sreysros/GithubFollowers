//
//  CustomImageView.swift
//  GitHubFollowers
//
//  Created by SreySros on 9/8/22.
//

import UIKit

class CustomImageView: UIImageView {
    
    let cache               = NetworkManager.shared.cache
    let placeholderImage = UIImage(named: "avatar-placeholder")!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        layer.cornerRadius = 10
        clipsToBounds = true
        image = placeholderImage
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func downloadImage(fromUrl url: String) {
        Task { image = await NetworkManager.shared.downloadImage(from: url) ?? placeholderImage}
    }
}
