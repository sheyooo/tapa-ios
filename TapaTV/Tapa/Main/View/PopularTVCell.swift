//
//  PopularTVCell.swift
//  TapaTV
//
//  Created by SimpuMind on 3/16/18.
//  Copyright © 2018 SimpuMind. All rights reserved.
//

import UIKit

class PopularTVCell: UITableViewCell {
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Title of Movie (2018)".uppercased()
        label.textColor = .black
        label.font = UIFont(name: "Avenir", size: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var videoThumbNail: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.backgroundColor = .red
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(titleLabel)
        addSubview(videoThumbNail)
        videoThumbNail.layer.cornerRadius = 10
        videoThumbNail.elevate(elevation: 4.0, shadowColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.5))
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        titleLabel.heightAnchor.equal(to: 44)
        titleLabel.leftAnchor.align(to: leftAnchor)
        titleLabel.rightAnchor.align(to: rightAnchor)
        titleLabel.bottomAnchor.align(to: bottomAnchor, offset: -5)
        
        videoThumbNail.topAnchor.align(to: topAnchor, offset: 10)
        videoThumbNail.leftAnchor.align(to: leftAnchor)
        videoThumbNail.rightAnchor.align(to: rightAnchor)
        videoThumbNail.bottomAnchor.align(to: titleLabel.topAnchor)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

