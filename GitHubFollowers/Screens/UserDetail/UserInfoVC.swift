//
//  UserInfoVC.swift
//  GitHubFollowers
//
//  Created by SreySros on 16/8/22.
//

import UIKit
import SafariServices

protocol UserInfoVCDelegate: AnyObject {
    func didRequestFollowers(for username: String)
}

class UserInfoVC: CustomLoadingViewController {
    
    private var customView: UserInfoView!
    var username: String!
    weak var delegate: UserInfoVCDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customView = UserInfoView()
        view = customView
        configureViewController()
        getUserInfo()
    }
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem = doneButton
    }
    
    func getUserInfo() {
        Task {
            do {
                let user = try await NetworkManager.shared.getUserInfo(for: username)
                configureElementUI(with: user)
            } catch {
                if let customError = error as? CustomError {
                    presentCustomAlert(title: "Something Went Wrong", message: customError.rawValue, buttonTitle: "Ok")
                } else {
                    presentDefaultError()
                }
            }
        }
    }
    
    func configureElementUI(with user: User) {
        self.add(childVC: CustomRepoItemVC(user: user, delegate: self), to: self.customView.itemViewOne)
        self.add(childVC: CustomFollowerItemVC(user: user, delegate: self), to: self.customView.itemViewTwo)
        self.add(childVC: CustomUserInfoHeaderVC(user: user), to: self.customView.headerView)
        self.customView.dateLabel.text = "GitHub Since \(user.createdAt.convertToMonthYearFormat())"
    }
    
    func add(childVC: UIViewController, to containerView: UIView) {
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
    }
    
    @objc func dismissVC() {
        dismiss(animated: true)
    }

}

extension UserInfoVC: CustomRepoItemVCDelegate {
    func didTapGitHubProfile(for user: User) {
        guard let url = URL(string: user.htmlUrl) else {
            presentCustomAlert(title: "Invalid URL", message: "The URL attached to this user is invalid.", buttonTitle: "Ok")
            return
        }
        presentSafariVC(with: url)
    }
    
}

extension UserInfoVC: CustomFollowerItemVCDelegate {
    func didTapGetFollowers(for user: User) {
        guard user.followers != 0 else {
            presentCustomAlert(title: "No Followers", message: "This user has no followers.", buttonTitle: "So Sad!")
            return
        }
        delegate.didRequestFollowers(for: user.login)
        dismissVC()
    }
    
}
