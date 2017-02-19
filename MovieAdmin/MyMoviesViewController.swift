//
//  MyMoviesViewController.swift
//  MovieAdmin
//
//  Created by Fèlix Arribas on 19/02/17.
//  Copyright © 2017 Fèlix Arribas. All rights reserved.
//

import UIKit

class MyMoviesViewController: TopMoviesViewController {
    
    var likeMovies: [LikeMovie]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.likeMovies = [LikeMovie]()
        self.getMoviesWith(offset: 0)
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
    }
    
    override func getMoviesWith(offset: Int) {
        self.likeMovies = LikeController.sharedInstance.all()
        self.moviesCollectionView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getMoviesWith(offset: 0)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.likeMovies.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCell", for: indexPath) as! MovieCollectionViewCell
        
        cell.initCell(movie: self.likeMovies[indexPath.row])
        
        return cell
    }
    
    override func lastClickedMovie() -> Movie {
        let lastClickedIndex = moviesCollectionView.indexPathsForSelectedItems?[0]
        return Movie(likeMovie: likeMovies[lastClickedIndex!.row])
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        return UICollectionReusableView()
    }
}
