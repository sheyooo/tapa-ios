//
//  NowCell.swift
//  TapaTV
//
//  Created by SimpuMind on 3/16/18.
//  Copyright © 2018 SimpuMind. All rights reserved.
//

import UIKit

class NowCell: UICollectionViewCell {
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Title of Movie (2018)".uppercased()
        label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        label.numberOfLines = 3
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        label.font = UIFont(name: "Avenir-Black", size: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var videoThumbNail: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.backgroundColor = .cyan
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(titleLabel)
        addSubview(videoThumbNail)
        videoThumbNail.layer.cornerRadius = 5
        videoThumbNail.elevate(elevation: 2.0, shadowColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.5))
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        titleLabel.heightAnchor.equal(to: 44)
        titleLabel.leftAnchor.align(to: leftAnchor, offset: 5)
        titleLabel.rightAnchor.align(to: rightAnchor, offset: -5)
        titleLabel.bottomAnchor.align(to: bottomAnchor, offset: -5)
        
        videoThumbNail.topAnchor.align(to: topAnchor, offset: 5)
        videoThumbNail.leftAnchor.align(to: leftAnchor)
        videoThumbNail.rightAnchor.align(to: rightAnchor)
        videoThumbNail.bottomAnchor.align(to: titleLabel.topAnchor, offset: -10)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
}

