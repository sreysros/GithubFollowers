//
//  PersistnenceManager.swift
//  GitHubFollowers
//
//  Created by SreySros on 23/8/22.
//

import Foundation

enum PersistenceActionType {
    case add, remove
}

enum PersistenceManager {
    static private let defaults = UserDefaults.standard
    
    enum Keys {
        static let favorites = "favorites"
    }
    
    static func updateWith(favorite: Follower, actionType: PersistenceActionType, completed: @escaping (CustomError?) -> Void) {
        retrieveFavorites { result in
            switch result {
            case .success(let favorites):
                var retrieveFavorite = favorites
                print(retrieveFavorite, "= == retrieve")
                
                switch actionType {
                case .add:
                    
                    guard !retrieveFavorite.contains(favorite) else {
                        completed(.alreadyInFavorite)
                        return
                    }
                    retrieveFavorite.append(favorite)
                case .remove:
                    retrieveFavorite.removeAll { $0.login == favorite.login }
                }
                completed(save(favorites: retrieveFavorite))
                
            case .failure(let error):
                completed(error)
            }
        }
    }
    
    static func retrieveFavorites(completed: @escaping (Result<[Follower], CustomError>) -> Void) {
        guard let favoritesData = defaults.object(forKey: Keys.favorites) as? Data else {
            completed(.success([]))
            return
        }
        
        do {
            let decoder = JSONDecoder()
            let favorites = try decoder.decode([Follower].self, from: favoritesData)
            completed(.success(favorites))
        } catch {
            completed(.failure(.unableToFavorite))
        }
    }
    
    static func save(favorites: [Follower]) -> CustomError? {
        do {
            let encoder = JSONEncoder()
            let encodedFavorites = try encoder.encode(favorites)
            defaults.set(encodedFavorites, forKey: Keys.favorites)
            return nil
        } catch {
            return .unableToFavorite
        }
    }
    
}
