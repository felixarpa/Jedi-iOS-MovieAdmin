//
//  TopMoviesHeader.swift
//  MovieAdmin
//
//  Created by Fèlix Arribas on 2/2/17.
//  Copyright © 2017 Fèlix Arribas. All rights reserved.
//

import UIKit

protocol MoviesGenreSelector {
    func switchToMovieWith(genre: MovieGenre)
}

enum MovieGenre {
    case all
    case action
    case scifi
    case comedy
}

class TopMoviesHeader: UICollectionReusableView {
    
    var delegate: MoviesGenreSelector?
    
    @IBAction func categorySelected(_ sender: UISegmentedControl) {
        
        
        switch sender.selectedSegmentIndex {
        case 0:
            delegate?.switchToMovieWith(genre: .all)
        case 1:
            delegate?.switchToMovieWith(genre: .action)
        case 2:
            delegate?.switchToMovieWith(genre: .scifi)
        case 3:
            delegate?.switchToMovieWith(genre: .comedy)
        default: break
        }
        
        
    }
    
}
