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
    
    private lazy var containerView: CardView = {
       let view = CardView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.numberOfLines = 3
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        label.font = UIFont(name: "Avenir-Black", size: Constant.isCompact(view: self, yes: 14, no: 18))
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var videoThumbNail: UIImageView = {
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
        addSubview(containerView)
        containerView.addSubview(videoThumbNail)
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
        
        containerView.topAnchor.align(to: topAnchor, offset: 20)
        containerView.leftAnchor.align(to: leftAnchor)
        containerView.rightAnchor.align(to: rightAnchor)
        containerView.bottomAnchor.align(to: titleLabel.topAnchor)
        videoThumbNail.fill(containerView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
}

