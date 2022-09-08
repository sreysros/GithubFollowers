//
//  CustomLoadingViewController.swift
//  GitHubFollowers
//
//  Created by SreySros on 27/8/22.
//

import UIKit

class CustomLoadingViewController: UIViewController {
    var containerView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func showLoadingView() {
        containerView = UIView(frame: view.bounds)
        view.addSubview(containerView)
        
        containerView.backgroundColor = .systemBackground
        containerView.alpha = 0
        
        UIView.animate(withDuration: 0.25) {self.containerView.alpha = 0.8 }
        
        let activatityIndicator = UIActivityIndicatorView(style: .large)
        containerView.addSubview(activatityIndicator)
        
        activatityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            activatityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            activatityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        activatityIndicator.startAnimating()
    }
    
    func dismissLoadingView() {
        DispatchQueue.main.async {
            self.containerView.removeFromSuperview()
            self.containerView = nil
        }
    }
    
    func showEmptyState(with message: String, in view: UIView) {
        let emptyStateView = CustomEmptyView(message: message)
        emptyStateView.frame = view.bounds
        view.addSubview(emptyStateView)
    }
    

}
