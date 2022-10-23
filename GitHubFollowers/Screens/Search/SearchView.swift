//
//  SearchView.swift
//  GitHubFollowers
//
//  Created by SreySros on 11/9/22.
//

import UIKit
import SnapKit

class SearchView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let containerView: UIView = {
       let view = UIView()
        return view
    }()
    
    let logoImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "gh-logo")
        return image
    }()
    
    let usernameTextField = CustomTextField()
    let callToActionButton = CustomButton(backgroundColor: .systemGreen, title: "Get Followers")
    
    func configure() {
        backgroundColor = .systemBackground
        addSubview(containerView)
        containerView.addSubView(logoImageView)
        containerView.addSubView(usernameTextField)
        containerView.addSubView(callToActionButton)
        
        containerView.snp.makeConstraints {
            $0.top.equalTo(layoutMarginsGuide)
            $0.edges.equalTo(layoutMarginsGuide)
            $0.center.equalToSuperview()
        }
        
        logoImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(80)
            $0.centerX.equalToSuperview()
            $0.size.equalTo(200)
        }
        
        usernameTextField.snp.makeConstraints {
            $0.top.equalTo(logoImageView.snp.bottom).offset(48)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(50)
        }
        
        callToActionButton.snp.makeConstraints {
            
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.bottom.equalToSuperview().offset(-50)
            $0.height.equalTo(50)
        }
    }

}
