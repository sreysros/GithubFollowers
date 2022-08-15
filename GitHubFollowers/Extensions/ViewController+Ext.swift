//
//  ViewController+Ext.swift
//  GitHubFollowers
//
//  Created by SreySros on 31/7/22.
//

import UIKit

fileprivate var containerView: UIView!

extension UIViewController {
    
    func presentCustomAlertOnMainThread(title: String, message: String, buttonTitle: String) {
        DispatchQueue.main.async {
            let alertVC = CustomAlertVC(title: title, message: message, buttonTitle: buttonTitle)
            alertVC.modalPresentationStyle = .overFullScreen
            alertVC.modalTransitionStyle = .crossDissolve
            self.present(alertVC, animated: true)
        }
    }
    
    func showLoadingView() {
        containerView = UIView(frame: view.bounds)
        view.addSubview(containerView)
        
        containerView.backgroundColor = .systemBackground
        containerView.alpha = 0
        
        UIView.animate(withDuration: 0.25) {containerView.alpha = 0.8 }
        
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
            containerView.removeFromSuperview()
            containerView = nil
        }
    }
    
    func showEmptyState(with message: String, in view: UIView) {
        let emptyStateView = CustomEmptyView(message: message)
        emptyStateView.frame = view.bounds
        view.addSubview(emptyStateView)
    }
}
