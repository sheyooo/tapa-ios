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

protocol HeaderViewDelegate {
    func didSelectHeaderViewCell(movie: Movie)
}

class MovieHeaderView: UICollectionReusableView, UIScrollViewDelegate {
    
    var delegate: HeaderViewDelegate?
    
    var movies = [Movie]()
    var images = [String]()
    var type = "movies"
    private func fetchMovies() {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
            ApiService.shared.fetchContentList(type: self.type) { (movies, message) in
                if movies == nil {
                    self.collectionView.isHidden = true
                    self.playButton.isHidden = true
                    return
                }
                self.collectionView.isHidden = false
                self.playButton.isHidden = false
                guard let movies = movies else {return}
                self.movies = movies
                self.images = movies.map({ (movie) -> String in
                    return movie.posterImageUrl
                })
                self.collectionView.delegate = self
                self.collectionView.dataSource = self.images
                self.collectionView.registerClass(ImageCell.self, forCellWithReuseIdentifier: "cell")
                let scroll = movies.count > 0 ? false : true
                self.collectionView.autoScrollOptions = [.enable(scroll)]
            }
        }
    }
    
    
    private lazy var collectionView: CarouselView = {
        let collectionView = CarouselView()
        collectionView.isHidden = true
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.pageControlOptions = [.hidden(false), .currentIndicatorTintColor(UIColor.white), .indicatorTintColor(primaryColor)]
        collectionView.registerClass(ImageCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.elevate(elevation: 2.0, shadowColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.5), cornerRadius: 10)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    fileprivate lazy var playButton: UIImageView = {
        let iv = UIImageView()
        iv.isHidden = true
        iv.image = #imageLiteral(resourceName: "pc_play")
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
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
        backgroundColor = .clear
        self.setupViews()
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
        cell.movie = movies[pageIndex]
        return cell
    }
    
    func carouselView(_ view: CarouselView, didSelectItemAtIndex index: NSInteger) {
        let movie = movies[index]
        self.delegate?.didSelectHeaderViewCell(movie: movie)
    }
    
}
