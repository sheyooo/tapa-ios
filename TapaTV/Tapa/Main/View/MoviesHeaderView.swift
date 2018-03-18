//
//  MoviesHeaderView.swift
//  TapaTV
//
//  Created by SimpuMind on 3/16/18.
//  Copyright © 2018 SimpuMind. All rights reserved.
//

import Foundation
import UIKit
import FCCarouselView

class MoviesHeaderView: UIView, UIScrollViewDelegate {
    
    var pages = [#imageLiteral(resourceName: "avater"), #imageLiteral(resourceName: "captain"), #imageLiteral(resourceName: "letmein"), #imageLiteral(resourceName: "past"), #imageLiteral(resourceName: "promities"), #imageLiteral(resourceName: "worldwar")]
    
    
    private lazy var collectionView: CarouselView = {
        let collectionView = CarouselView()
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = pages
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


extension MoviesHeaderView: CarouselViewDelegate{
    
    func carouselView(_ view: CarouselView, cellAtIndexPath indexPath: IndexPath, pageIndex: Int) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndex: pageIndex) as! ImageCell
        if let image = collectionView.dataSource[pageIndex] as? UIImage {
            cell.imageView.image = image
        }
        return cell
    }

}

class ImageCell: UICollectionViewCell {
    
    public lazy var imageView: DesignableImageView = {
        let iv = DesignableImageView()
        iv.layer.cornerRadius = 10
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFill
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    var coverView: GradientView = {
        let view = GradientView()
        view.endColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.5)
        view.startColor = #colorLiteral(red: 0.05303376773, green: 0.0541061851, blue: 0.07047112944, alpha: 0)
        view.alpha = 0.8
        view.startPoint = CGPoint(x: 0.1, y: 0.0)
        view.endPoint = CGPoint(x: 0.0, y: 0.1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Orange is the New black"
        label.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        let size: CGFloat = Constant.isCompact(view: self, yes: 22, no: 40)
        label.font = UIFont(name: "Avenir-Black", size: size)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "When I open the listing details, it shows the type of storage as the title of the listing. Instead, have the title of the space shown above the name of the storage host. As for the type of the space, show it underneath the height. So... it will look like this"
        label.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        label.numberOfLines = 2
        let size: CGFloat = Constant.isCompact(view: self, yes: 12, no: 22)
        label.font = UIFont(name: "Avenir", size: size)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(imageView)
        imageView.addSubview(coverView)
        imageView.addSubview(titleLabel)
        imageView.addSubview(descriptionLabel)
        
        
        elevate(elevation: 5.0, shadowColor: #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1), cornerRadius: 10)
        clipsToBounds = true
        
        imageView.shadowColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
        imageView.shadowOpacity = 0.5
        imageView.shadowRadius = 10
        imageView.clipsToBounds = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.leftAnchor.align(to: leftAnchor)
        imageView.rightAnchor.align(to: rightAnchor)
        imageView.topAnchor.align(to: topAnchor)
        imageView.bottomAnchor.align(to: bottomAnchor)
        
        coverView.fill(imageView)
        
        titleLabel.topAnchor.align(to: topAnchor, offset: 25)
        titleLabel.leftAnchor.align(to: imageView.leftAnchor, offset: 20)
        titleLabel.rightAnchor.align(to: imageView.rightAnchor, offset: -20)
        let size: CGFloat = Constant.isCompact(view: self, yes: 25, no: 50)
        titleLabel.heightAnchor.equal(to: size)
        
        descriptionLabel.topAnchor.align(to: titleLabel.bottomAnchor, offset: 10)
        descriptionLabel.leftAnchor.align(to: imageView.leftAnchor, offset: 20)
        let descWidth: CGFloat = Constant.isCompact(view: self, yes: 150, no: 250)
        descriptionLabel.widthAnchor.equal(to: descWidth)
        descriptionLabel.heightAnchor.equal(to: Constant.isCompact(view: self, yes: 50, no: 65))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}

