//
//  FavoriteVC.swift
//  GitHubFollowers
//
//  Created by SreySros on 30/7/22.
//

import UIKit

class FavoriteVC: CustomLoadingViewController {
    
    var tableView: FavoriteView!
    var favorites: [Follower] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView = FavoriteView()
        view = tableView
        configureViewController()
        configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getFavorites()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
        title = "Favorites"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func configureTableView() {
        tableView.tableView.delegate = self
        tableView.tableView.dataSource = self
        tableView.tableView.removeExcessCells()
        tableView.tableView.register(FavoriteCell.self, forCellReuseIdentifier: FavoriteCell.reuseID)
    }
    
    func getFavorites() {
        PersistenceManager.retrieveFavorites { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let favorites):
                if favorites.isEmpty {
                    self.showEmptyState(with: "No Favorites?\nAdd one on the follower screen.", in: self.view)
                } else {
                    self.favorites = favorites
                    DispatchQueue.main.async {
                        self.tableView.tableView.reloadData()
                        self.view.bringSubviewToFront(self.tableView)
                    }
                }
                
            case .failure(let error):
                self.presentCustomAlert(title: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }
}

extension FavoriteVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteCell.reuseID) as! FavoriteCell
        let favorite = favorites[indexPath.row]
        cell.set(favorite: favorite)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let favorite = favorites[indexPath.row]
        let destVC = FollowerListVC(userName: favorite.login)
        navigationController?.pushViewController(destVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        
        PersistenceManager.updateWith(favorite: favorites[indexPath.row], actionType: .remove) { [weak self] error in
            guard let self = self else { return }
            guard let error = error else {
                self.favorites.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .left)
                return }
            self.presentCustomAlert(title: "Unable to remove", message: error.rawValue, buttonTitle: "Ok")
        }
    }
    
    
}
