//
//  LikeMovie.swift
//  MovieAdmin
//
//  Created by Fèlix Arribas on 19/02/17.
//  Copyright © 2017 Fèlix Arribas. All rights reserved.
//

import Foundation
import RealmSwift
import SwiftyJSON

class LikeMovie: Object {
    
    dynamic var id: String?
    dynamic var title: String?
    dynamic var summary: String?
    dynamic var price: String?
    dynamic var duration: String?
    dynamic var director: String?
    dynamic var category: String?
    dynamic var categoryId: String?
    dynamic var releaseDate: String?
    dynamic var imageUrl: String?
    
    convenience init(movie: Movie) {
        self.init()
        self.id = movie.id
        self.title = movie.title
        self.summary = movie.summary
        self.price = movie.price
        self.duration = movie.duration
        self.director = movie.director
        self.category = movie.category
        self.categoryId = movie.category
        self.releaseDate = movie.releaseDate
        self.imageUrl = movie.imageUrl
    }
    
    override static func primaryKey() -> String {
        return "id"
    }
}
