//
//  MoviesHeaderView.swift
//  TapaTV
//
//  Created by SimpuMind on 3/16/18.
//  Copyright © 2018 SimpuMind. All rights reserved.
//

import Foundation
import UIKit
import ScalingCarousel

class MoviesHeaderView: UIView, UIScrollViewDelegate {
    
    fileprivate let sectionInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    
    private var collectionView: ScalingCarouselView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        let collectionView = ScalingCarouselView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.isPagingEnabled = true
        collectionView.backgroundColor = .clear
        collectionView.inset = 20
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Orange is the New black"
        label.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        label.font = UIFont(name: "Avenir-Black", size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "When I open the listing details, it shows the type of storage as the title of the listing. Instead, have the title of the space shown above the name of the storage host. As for the type of the space, show it underneath the height. So... it will look like this"
        label.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        label.numberOfLines = 0
        label.font = UIFont(name: "Avenir", size: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ImageCell.self, forCellWithReuseIdentifier: "cell")
        addSubview(collectionView)
        addSubview(titleLabel)
        addSubview(descriptionLabel)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        collectionView.didScroll()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.topAnchor.align(to: topAnchor)
        collectionView.leftAnchor.align(to: leftAnchor)
        collectionView.rightAnchor.align(to: rightAnchor, offset: -20)
        collectionView.heightAnchor.equal(to: frame.width / 2)
        
        titleLabel.topAnchor.align(to: collectionView.bottomAnchor, offset: 20)
        titleLabel.leftAnchor.align(to: leftAnchor, offset: 0)
        titleLabel.rightAnchor.align(to: rightAnchor, offset: -20)
        titleLabel.heightAnchor.equal(to: 17)
        
        descriptionLabel.topAnchor.align(to: titleLabel.bottomAnchor, offset: 5)
        descriptionLabel.leftAnchor.align(to: leftAnchor, offset: 0)
        descriptionLabel.rightAnchor.align(to: rightAnchor, offset: -20)
        descriptionLabel.bottomAnchor.align(to: bottomAnchor, offset: -10)
    }
}


extension MoviesHeaderView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ImageCell
        
        return cell
    }

}

class ImageCell: ScalingCarouselCell {
    
    private lazy var imageView: UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "woman_pc")
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.backgroundColor = .red
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentMode = .center
        mainView = UIView(frame: CGRect(x: 0, y: 0, width: contentView.bounds.width, height: contentView.bounds.height - 10))
        contentView.addSubview(mainView)
        mainView.addSubview(imageView)
        imageView.elevate(elevation: 4.0, shadowColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.5))
        imageView.layer.cornerRadius = 5
        
        imageView.leftAnchor.align(to: leftAnchor)
        imageView.rightAnchor.align(to: rightAnchor)
        imageView.topAnchor.align(to: topAnchor)
        imageView.bottomAnchor.align(to: bottomAnchor, offset: -20)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

