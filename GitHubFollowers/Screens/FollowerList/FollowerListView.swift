//
//  FollowerListView.swift
//  GitHubFollowers
//
//  Created by SreySros on 17/9/22.
//

import UIKit
import SnapKit

class FollowerListView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UIHelper.createThreeColumnFlowLayout())
        collectionView.backgroundColor = .systemBackground
        return collectionView
    }()
    
    func configure() {
        addSubView(collectionView)
        
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
