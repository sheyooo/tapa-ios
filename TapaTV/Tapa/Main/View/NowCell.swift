//
//  NowCell.swift
//  TapaTV
//
//  Created by SimpuMind on 3/16/18.
//  Copyright © 2018 SimpuMind. All rights reserved.
//

import UIKit
import AlamofireImage

class NowCell: UICollectionViewCell {
    
    var movie: Movie? {
        didSet{
            guard let movie = movie else {return}
            titleLabel.text = movie.title.uppercased()
            
            videoThumbNail.af_setImage(
                withURL: URL(string: movie.posterImageUrl)!,
                placeholderImage: #imageLiteral(resourceName: "bggg")
            )
//            backgroundColor = .clear
        }
    }
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white//#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        label.numberOfLines = 3
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        label.font = UIFont(name: "Avenir-Black", size: Constant.isCompact(view: self, yes: 14, no: 18))
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var videoThumbNail: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.cornerRadius = 10
        iv.clipsToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(titleLabel)
        addSubview(videoThumbNail)
        elevate(elevation: 5.0, shadowColor: #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1), cornerRadius: 10)
        clipsToBounds = true
        
        videoThumbNail.shadowColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
        videoThumbNail.shadowOpacity = 0.5
        videoThumbNail.shadowRadius = 10
        videoThumbNail.clipsToBounds = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        titleLabel.heightAnchor.equal(to: 44)
        titleLabel.leftAnchor.align(to: leftAnchor, offset: 5)
        titleLabel.rightAnchor.align(to: rightAnchor, offset: -5)
        titleLabel.bottomAnchor.align(to: bottomAnchor, offset: -5)
        
        videoThumbNail.topAnchor.align(to: topAnchor, offset: 20)
        videoThumbNail.leftAnchor.align(to: leftAnchor)
        videoThumbNail.rightAnchor.align(to: rightAnchor)
        videoThumbNail.bottomAnchor.align(to: titleLabel.topAnchor)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
}

