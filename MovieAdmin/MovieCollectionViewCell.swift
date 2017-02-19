//
//  MovieCollectionViewCell.swift
//  MovieAdmin
//
//  Created by Fèlix Arribas on 30/1/17.
//  Copyright © 2017 Fèlix Arribas. All rights reserved.
//

import UIKit
import Kingfisher

class MovieCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var likeImageView: UIImageView!
    
    func initCell(movie: Movie) {
        self.movieImageView.kf.setImage(with: URL(string: movie.imageUrl!))
        
        self.likeImageView.isHidden = !LikeController.sharedInstance.containsMovieWith(identifier: movie.id!)
    }
    
    func initCell(movie: LikeMovie) {
        self.movieImageView.kf.setImage(with: URL(string: movie.imageUrl!))
    }
    
}
