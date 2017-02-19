//
//  NetworkController.swift
//  MovieAdmin
//
//  Created by Fèlix Arribas on 30/1/17.
//  Copyright © 2017 Fèlix Arribas. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class NetworkController {
    
    static let iTunesURL = "https://itunes.apple.com/us/rss/topmovies/limit=OFFSET_LIMIT/genre=MOVIE_GENRE/json"
    
    static let genreDictionary = [
        MovieGenre.action : "4401",
        MovieGenre.scifi : "4413",
        MovieGenre.comedy : "4410"
    ]
    
    static func getUrlWithOffset(offset: Int, url: String) -> String {
        let limit = offset + 30
        let offsetUrl = url.replacingOccurrences(of: "OFFSET_LIMIT", with: "\(limit)")
        return offsetUrl
    }
    
    static func gerUrlWithGenre(genre: MovieGenre, url: String) -> String {
        if genre == MovieGenre.all {
            return url.replacingOccurrences(of: "genre=MOVIE_GENRE/", with: "")
        } else {
            return url.replacingOccurrences(of: "MOVIE_GENRE", with: genreDictionary[genre]!)
        }
    }
    
    static func getTopMovies(offset: Int, genre: MovieGenre, completion: @escaping (_ movies: [Movie]) -> Void) {
        
        let genreUrl = gerUrlWithGenre(genre: genre, url: iTunesURL)
        let url = getUrlWithOffset(offset: offset, url: genreUrl)
        
        Alamofire.request(url).responseJSON {
            response in
            
            switch response.result {
            case .success(let data):
                let json = JSON(data)
                let entries = json["feed"]["entry"].arrayValue
                var movies = [Movie]()
                
                for i in offset..<entries.count {
                    let jsonMovie = entries[i]
                    let newMovie = Movie(json: jsonMovie)
                    movies.append(newMovie)
                }
                
                completion(movies)
                
            case .failure(let error):
                print(error)
                return
            
            
            }
        }
    }
    
    
}
