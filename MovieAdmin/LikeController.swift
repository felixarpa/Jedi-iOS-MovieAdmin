//
//  LikeController.swift
//  MovieAdmin
//
//  Created by Fèlix Arribas on 19/02/17.
//  Copyright © 2017 Fèlix Arribas. All rights reserved.
//

import Foundation
import RealmSwift

class LikeController {
    
    static let sharedInstance = LikeController()
    
    fileprivate init() {}
    
    fileprivate var realm: Realm = try! Realm()
    
    func all() -> [LikeMovie] {
        return Array(self.realm.objects(LikeMovie.self))
    }
    
    func containsMovieWith(identifier: String) -> Bool {
        return all().map({ (likedMovie: LikeMovie) -> String in
            return likedMovie.id!
        }).contains(identifier)
    }
    
    fileprivate func add(movie: Movie) {
        if !containsMovieWith(identifier: movie.id!) {
            try! self.realm.write {
                self.realm.add(LikeMovie(movie: movie))
            }
        }
    }
    
    fileprivate func removieMovieWith(identifier: String) {
        let movie = realm.objects(LikeMovie.self).filter("id == %@", identifier)
        if containsMovieWith(identifier: identifier) {
            try! self.realm.write {
                self.realm.delete(movie)
            }
        }
    }
    
    func bigLikeTo(movie: Movie) -> Bool {
        var shouldLikeBeHidden: Bool
        if containsMovieWith(identifier: movie.id!) {
            removieMovieWith(identifier: movie.id!)
            shouldLikeBeHidden = true
        } else {
            add(movie: movie)
            shouldLikeBeHidden = false
        }
        return shouldLikeBeHidden
    }
}
