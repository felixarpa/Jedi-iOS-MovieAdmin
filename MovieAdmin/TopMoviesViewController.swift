//
//  TopMoviesViewController.swift
//  MovieAdmin
//
//  Created by Fèlix Arribas on 30/1/17.
//  Copyright © 2017 Fèlix Arribas. All rights reserved.
//

import UIKit

class TopMoviesViewController: UIViewController {
    
    @IBOutlet weak var moviesCollectionView: UICollectionView!

    var movies: [Movie]!
    var cellWidth: Double?
    var needToLoad: Bool?
    var listGenre: MovieGenre!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.listGenre = MovieGenre.all
        self.movies = [Movie]()
        self.getMoviesWith(offset: 0)
    }
    
    func getMoviesWith(offset: Int) {
        self.needToLoad = false
        NetworkController.getTopMovies(offset: offset, genre: listGenre) {
            movies in
            self.movies.append(contentsOf: movies)
            self.moviesCollectionView.reloadData()
            self.needToLoad = true
        }
    }
    
    func setCellWidth() {
        let flow: UICollectionViewFlowLayout = moviesCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        let width = (moviesCollectionView.frame.size.width - (flow.sectionInset.right + flow.sectionInset.left) * 2) / 3
        
        self.cellWidth = Double(width) - 1.0
    }
    
    override func viewDidLayoutSubviews() {
        setCellWidth()
    }

}

extension TopMoviesViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.cellWidth!, height: (self.cellWidth! * 3) / 2)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCell", for: indexPath) as! MovieCollectionViewCell
        
        cell.initCell(movie: movies[indexPath.row])
        
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if self.needToLoad! {
        
            let offset = scrollView.contentOffset
            let bounds = scrollView.bounds
            let size = scrollView.contentSize
            let inset = scrollView.contentInset
        
            let yPosition = offset.y + bounds.size.height - inset.bottom
            let height = size.height
        
            let reloadDistance = 100
            
            if yPosition > height - CGFloat(reloadDistance) {
                self.getMoviesWith(offset: self.movies.count + 1)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "goToMovieDetail", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToMovieDetail" {
            let lastClickedIndex = moviesCollectionView.indexPathsForSelectedItems?[0]
            let movieDetailViewController = segue.destination as! MovieDetailViewController
            movieDetailViewController.movie = movies[lastClickedIndex!.row]
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionElementKindSectionHeader {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "topMoviesHeader", for: indexPath) as! TopMoviesHeader
            header.delegate = self
            return header
        }
        
        return UICollectionReusableView()
    }
    
}

extension TopMoviesViewController: MoviesGenreSelector {
    func switchToMovieWith(genre: MovieGenre) {
        movies = [Movie]()
        self.listGenre = genre
        getMoviesWith(offset: 0)
        
    }
}


