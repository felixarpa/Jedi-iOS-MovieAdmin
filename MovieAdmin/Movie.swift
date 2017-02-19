//
//  Movie.swift
//  MovieAdmin
//
//  Created by Fèlix Arribas on 30/1/17.
//  Copyright © 2017 Fèlix Arribas. All rights reserved.
//

import Foundation
import SwiftyJSON

class Movie {
    
    var title: String?
    var summary: String?
    var price: String?
    var duration: String?
    var director: String?
    var category: String?
    var categoryId: String?
    var releaseDate: String?
    var imageUrl: String?
    
    
    init(json: JSON) {
        
        self.title = json["title"]["label"].stringValue
        self.summary = json["summary"]["label"].stringValue
        self.price = json["im:price"]["label"].stringValue
        let durationValue = json["link"][1]["im:duration"]["label"].floatValue
        let intDuration: Int = Int(durationValue / 1000)
        if intDuration % 60 >= 10 {
            self.duration = "\(intDuration / 60):\(intDuration % 60)"
        } else {
            self.duration = "\(intDuration / 60):0\(intDuration % 60)"
        }
        self.director = json["im:artist"]["label"].stringValue
        self.category = json["category"]["attributes"]["label"].stringValue
        self.categoryId = json["category"]["attributes"]["im:id"].stringValue
        self.releaseDate = json["im:releaseDate"]["attributes"]["label"].stringValue
        
        let imImageLabel = json["im:image"][0]["label"].stringValue
        let height = json["im:image"][0]["attributes"]["height"].stringValue
        let heightString = height + "x" + height
        self.imageUrl = imImageLabel.replacingOccurrences(of: heightString, with: "300x300")
    }
}
