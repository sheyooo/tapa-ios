//
//  MovieHeaderView.swift
//  TapaTV
//
//  Created by SimpuMind on 4/8/18.
//  Copyright © 2018 SimpuMind. All rights reserved.
//

import Foundation
import UIKit
import FCCarouselView

class MovieHeaderView: UICollectionReusableView, UIScrollViewDelegate {
    
    
    var movies = [Movie]()
    
    private func fetchMovies() {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
            ApiService.shared.fetchMovieList { (movies, message) in
                if movies == nil {
                    return
                }
                
                guard let movies = movies else {return}
                self.movies = movies
                let images = movies.map({ (movie) -> String in
                    return movie.posterImageUrl
                })
                self.collectionView.dataSource = images
            }
        }
    }
    
    
    private lazy var collectionView: CarouselView = {
        let collectionView = CarouselView()
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.autoScrollOptions = [.enable(true)]
        collectionView.pageControlOptions = [.hidden(false), .currentIndicatorTintColor(UIColor.white), .indicatorTintColor(primaryColor)]
        collectionView.registerClass(ImageCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.elevate(elevation: 2.0, shadowColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.5), cornerRadius: 10)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    fileprivate lazy var playButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "pc_play"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        fetchMovies()
    }
    
    private func setupViews(){
        backgroundColor = .clear
        addSubview(collectionView)
        addSubview(playButton)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.fill(self)
        
        playButton.centerXAnchor.align(to: centerXAnchor)
        playButton.centerYAnchor.align(to: centerYAnchor)
        playButton.widthAnchor.equal(to: frame.height - 80)
        playButton.heightAnchor.equal(to: frame.height - 80)
    }
}


extension MovieHeaderView: CarouselViewDelegate{
    
    func carouselView(_ view: CarouselView, cellAtIndexPath indexPath: IndexPath, pageIndex: Int) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndex: pageIndex) as! ImageCell
        if let image = collectionView.dataSource[pageIndex] as? UIImage {
            cell.imageView.image = image
        }
        return cell
    }
    
}
