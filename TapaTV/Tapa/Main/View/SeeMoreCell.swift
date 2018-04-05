//
//  SeeMoreCell.swift
//  TapaTV
//
//  Created by SimpuMind on 3/16/18.
//  Copyright © 2018 SimpuMind. All rights reserved.
//

import UIKit

class SeeMoreCell: UICollectionViewCell {
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        label.numberOfLines = 3
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        label.font = UIFont(name: "Avenir-Black", size: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.text = "more".uppercased()
        label.textColor = .white
        label.backgroundColor = .clear
        label.numberOfLines = 1
        label.textAlignment = .center
        label.font = UIFont(name: "Avenir-Black", size: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var videoThumbNail: DesignableImageView = {
        let iv = DesignableImageView()
        iv.cornerRadius = 10
        iv.backgroundColor = #colorLiteral(red: 0.9269114848, green: 0.8422334162, blue: 0.04974014119, alpha: 1)
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(titleLabel)
        addSubview(videoThumbNail)
        addSubview(label)
        
        elevate(elevation: 5.0, shadowColor: #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1), cornerRadius: 10)
        clipsToBounds = true
        
        videoThumbNail.shadowColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
        videoThumbNail.shadowOpacity = 0.5
        videoThumbNail.shadowRadius = 10
        videoThumbNail.clipsToBounds = true
    }
    
    @objc private func handleTap(){
        
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
        
        label.topAnchor.align(to: topAnchor, offset: 5)
        label.leftAnchor.align(to: leftAnchor)
        label.rightAnchor.align(to: rightAnchor)
        label.bottomAnchor.align(to: titleLabel.topAnchor, offset: -10)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
}

