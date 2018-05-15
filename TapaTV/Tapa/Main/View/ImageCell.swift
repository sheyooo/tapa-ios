//
//  ImageCell.swift
//  TapaTV
//
//  Created by SimpuMind on 5/15/18.
//  Copyright © 2018 SimpuMind. All rights reserved.
//

import UIKit

class ImageCell: UICollectionViewCell {
    
    var movie: Movie? {
        didSet{
            guard let movie = movie else { return}
            
            titleLabel.text = movie.title
            descriptionLabel.text = movie.contentDescription
            imageView.af_setImage(
                withURL: URL(string: movie.posterImageUrl)!,
                placeholderImage: #imageLiteral(resourceName: "bggg")
            )

        }
    }
    
    public lazy var imageView: UIImageView = {
        let iv = UIImageView()
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
        label.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        let size: CGFloat = Constant.isCompact(view: self, yes: 22, no: 40)
        label.font = UIFont(name: "Avenir-Black", size: size)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        label.numberOfLines = 2
        label.alpha = 0
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
        backgroundColor = .clear
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


