//
//  SearchVC.swift
//  GitHubFollowers
//
//  Created by SreySros on 30/7/22.
//

import UIKit

class SearchVC: UIViewController {
    
    private var customView: SearchView!
    var isUsernameEnter: Bool { return !customView.usernameTextField.text!.isEmpty}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        customView = SearchView()
        view = customView
        customView.usernameTextField.delegate = self
        customView.callToActionButton.addTarget(self, action: #selector(pushToFollowerListVC), for: .touchUpInside)
        createDismissKeyboard()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    func createDismissKeyboard() {
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
    
    @objc func pushToFollowerListVC() {
        guard isUsernameEnter else {
            presentCustomAlert(title: "Notice", message: "Username is empty, please enter username", buttonTitle: "Ok")
            return
        }
        
        customView.usernameTextField.resignFirstResponder()
        
        let vc = FollowerListVC(userName: customView.usernameTextField.text!)
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension SearchVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        pushToFollowerListVC()
        return true
    }
}
