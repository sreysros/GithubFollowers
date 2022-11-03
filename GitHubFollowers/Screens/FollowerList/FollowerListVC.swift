//
//  FollowerListVC.swift
//  GitHubFollowers
//
//  Created by SreySros on 31/7/22.
//

import UIKit

class FollowerListVC: CustomLoadingViewController {
    
    enum Section {
        case main
    }
    
    var userName: String!
    var customView: FollowerListView!
    var followers: [Follower] = []
    var filterFollower: [Follower] = []
    var page: Int = 1
    var hasMoreFollower: Bool = true
    var isSearching: Bool = false

    
    init(userName: String) {
        super.init(nibName: nil, bundle: nil)
        self.userName = userName
        title = userName
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customView = FollowerListView()
        view = customView
        configureViewController()
        configureSearchController()
        getFollowers(username: userName, page: page)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        customView.collectionView.delegate = self
        customView.collectionView.dataSource = self
        customView.collectionView.backgroundColor = .systemBackground
        customView.collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseID)
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        navigationItem.rightBarButtonItem = addButton
    }
    
    func configureSearchController() {
        let searchController = UISearchController()
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.definesPresentationContext = true
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Search for a username"
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
    }
    
    func getFollowers(username: String, page: Int) {
        showLoadingView()
        Task {
            do {
                let followers = try await NetworkManager.shared.getFollowers(for: username, page: page)
                updateUI(with: followers)
                dismissLoadingView()
            } catch {
                if let customError = error as? CustomError {
                    presentCustomAlert(title: "Bad Stuff happened", message: customError.rawValue, buttonTitle: "Ok")
                } else {
                    presentDefaultError()
                }
                dismissLoadingView()
            }
        }
    }
    
    func updateUI(with fan: [Follower]) {
        if fan.count < 50 { self.hasMoreFollower = false }
        self.followers.append(contentsOf: fan)
        if self.followers.isEmpty {
            let message = "This user doesn't have any followers. Go follow them."
            DispatchQueue.main.async {
                self.showEmptyState(with: message, in: self.view)
                return
            }
        }
        customView.collectionView.reloadData()
    }
    
    @objc func addButtonTapped() {
        showLoadingView()
        
        Task {
            do {
                let user = try await NetworkManager.shared.getUserInfo(for: userName)
                addUserToFavorite(user: user)
                dismissLoadingView()
            } catch {
                if let customError = error as? CustomError {
                    presentCustomAlert(title: "Something went wrong", message: customError.rawValue, buttonTitle: "Ok")
                } else {
                    presentDefaultError()
                }
                dismissLoadingView()
            }
        }
    }
    
    func addUserToFavorite(user: User) {
        let favorite = Follower(login: user.login, avatarUrl: user.avatarUrl)
        PersistenceManager.updateWith(favorite: favorite, actionType: .add) { [weak self] error in
            guard let self = self else { return }
            guard let error = error else {
                DispatchQueue.main.async {
                    self.presentCustomAlert(title: "Success!", message: "You have success favorites", buttonTitle: "Horray")
                }
                return
            }
            DispatchQueue.main.async {
                self.presentCustomAlert(title: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
            }
            
        }
    }
}

extension FollowerListVC: UICollectionViewDelegate {
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        
        if offsetY > contentHeight - height {
            guard hasMoreFollower else { return }
            page += 1
            getFollowers(username: userName, page: page)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let activeArray = isSearching ? filterFollower : followers
        let follower = activeArray[indexPath.item]
        let destVC = UserInfoVC()
        destVC.username = follower.login
        destVC.delegate = self
        let navController = UINavigationController(rootViewController: destVC)
        present(navController, animated: true)
        
    }
}

extension FollowerListVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return !filterFollower.isEmpty ? filterFollower.count : followers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.reuseID, for: indexPath) as! FollowerCell
        cell.set(follower: !filterFollower.isEmpty ? filterFollower[indexPath.row] : followers[indexPath.row])
        return cell
    }
}
extension FollowerListVC: UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        guard let filter = searchController.searchBar.text, !filter.isEmpty else {
            filterFollower.removeAll()
            customView.collectionView.reloadData()
            isSearching = false
            return
        }
        
        isSearching = true
        filterFollower = followers.filter { $0.login.lowercased().contains(filter.lowercased())}
        customView.collectionView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false
        customView.collectionView.reloadData()
    }
}

// still wrong get followers of user info

extension FollowerListVC: UserInfoVCDelegate {
    func didRequestFollowers(for username: String) {
        isSearching = false
        self.userName = username
        title = username
        page = 1
//        followers.removeAll()
        filterFollower.removeAll()
        customView.collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: true)
        getFollowers(username: username, page: page)
    }
}
