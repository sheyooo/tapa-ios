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
    
    private var collectionView: ScalingCarouselView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        collectionView = ScalingCarouselView(withFrame: CGRect(x: 50, y: 0, width: frame.width - 50, height: frame.height), andInset: 40)
        collectionView.center = self.center
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(ImageCell.self, forCellWithReuseIdentifier: "cell")
        addSubview(collectionView)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        collectionView.didScroll()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
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
        imageView.elevate(elevation: 4.0, shadowColor: #colorLiteral(red: 0.8588235294, green: 0.1921568627, blue: 0.4039215686, alpha: 0.5488013699))
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

