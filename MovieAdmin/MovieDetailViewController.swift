//
//  MovieDetailViewController.swift
//  MovieAdmin
//
//  Created by Fèlix Arribas on 31/1/17.
//  Copyright © 2017 Fèlix Arribas. All rights reserved.
//

import UIKit
import Kingfisher

class MovieDetailViewController: UIViewController {
    
    var movie: Movie?
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var directorLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var bigLikeImageView: UIImageView!
    @IBOutlet weak var likeImageView: UIImageView!
    
    var scaleIndex: Int = 0
    var scales: [CGFloat] = [ 1.4, 1.0, 1.1 ]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureDoubeTap()
        
        self.titleLabel.text = movie!.title!.uppercased()
        self.priceLabel.text = movie!.price!
        
        self.movieImageView.kf.setImage(with: URL(string: (movie?.imageUrl)!))
        
        let categoryString = self.getLightPlusRegularString(light: self.categoryLabel.text!, regular: movie!.category!)
        self.categoryLabel.attributedText = categoryString
        
        let directorString = self.getLightPlusRegularString(light: self.directorLabel.text!, regular: movie!.director!)
        self.directorLabel.attributedText = directorString
        
        let durationString = self.getLightPlusRegularString(light: self.durationLabel.text!, regular: movie!.duration!)
        self.durationLabel.attributedText = durationString
        
        self.summaryLabel.text = movie!.summary!
        
        self.likeImageView.isHidden = !(LikeController.sharedInstance.containsMovieWith(identifier: movie!.id!))
        
    }
    
    func configureDoubeTap() {
        movieImageView.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(startAnimating))
        gestureRecognizer.numberOfTapsRequired = 2
        movieImageView.addGestureRecognizer(gestureRecognizer)
//        movieImageView.gestureRecognizers?.append(gestureRecognizer)
    }
    
    func startAnimating() {
        self.bigLikeImageView.alpha = 1.0
        animateLike(scaleIndex: 0)
    }
    
    func endAnimation() {
        UIView.animate(
            withDuration: 0.5,
            animations: {
                self.bigLikeImageView.alpha = 0.0
        },  completion: {
            value in
            self.likeImageView.isHidden = LikeController.sharedInstance.bigLikeTo(movie: self.movie!)
        })
        
    }
    
    func animateLike(scaleIndex: Int) {
        let value = self.scales[scaleIndex]
        UIView.animate(
            withDuration: 0.15,
            animations: {
                self.bigLikeImageView.transform = CGAffineTransform(scaleX: value, y: value)
        },  completion: {
            value in
                let index = scaleIndex + 1
                if index < self.scales.count {
                    self.animateLike(scaleIndex: index)
                } else {
                    self.endAnimation()
                }
        })
    }
    
    
    
    @IBAction func backPressed() {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    func getLightPlusRegularString(light: String, regular: String) -> NSAttributedString {
        
        let lightAttribute = [ NSFontAttributeName: UIFont(name: "Montserrat-Light", size: 17.0)!]
        
        let lightString = NSMutableAttributedString(string: light, attributes: lightAttribute )
        
        let regularAttribute = [ NSFontAttributeName: UIFont(name: "Montserrat-Regular", size: 17.0)! ]
        
        let regularString = NSMutableAttributedString(string: regular, attributes: regularAttribute )
        
        lightString.append(regularString)
        
        return lightString

    }
    

}
