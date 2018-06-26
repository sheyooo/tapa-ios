//
//  SportCelll.swift
//  TapaTV
//
//  Created by SimpuMind on 6/17/18.
//  Copyright © 2018 SimpuMind. All rights reserved.
//

import UIKit

class SportCell: UITableViewCell {
    
    private lazy var containerView: CardView = {
       let view = CardView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var videoThumbNail: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        iv.clipsToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    private lazy var profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.cornerRadius = 20
        iv.backgroundColor = #colorLiteral(red: 0.08235294118, green: 0.4705882353, blue: 0.7058823529, alpha: 1)
        iv.clipsToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Keyclack posters, the begining of a new era."
        label.textColor = #colorLiteral(red: 0.1770899429, green: 0.1770899429, blue: 0.1770899429, alpha: 1)
        label.numberOfLines = 3
        label.lineBreakMode = .byWordWrapping
        label.font = UIFont(name: "Avenir-Black", size: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .clear
        selectionStyle = .none
        
        contentView.addSubview(containerView)
        [videoThumbNail, profileImageView, titleLabel].forEach{containerView.addSubview($0)}
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        containerView.topAnchor.align(to: topAnchor, offset: 0)
        containerView.leftAnchor.align(to: leftAnchor, offset: 0)
        containerView.rightAnchor.align(to: rightAnchor, offset: -0)
        containerView.bottomAnchor.align(to: bottomAnchor, offset: -20)
        
        videoThumbNail.leftAnchor.align(to: containerView.leftAnchor)
        videoThumbNail.rightAnchor.align(to: containerView.rightAnchor)
        videoThumbNail.topAnchor.align(to: containerView.topAnchor)
        videoThumbNail.heightAnchor.equal(to: (frame.height) - 80)
        
        profileImageView.topAnchor.align(to: videoThumbNail.bottomAnchor, offset: 10)
        profileImageView.leftAnchor.align(to: containerView.leftAnchor, offset: 10)
        profileImageView.widthAnchor.equal(to: 40)
        profileImageView.heightAnchor.equal(to: 40)
        
        titleLabel.topAnchor.align(to: videoThumbNail.bottomAnchor, offset: 10)
        titleLabel.leftAnchor.align(to: profileImageView.rightAnchor, offset: 10)
        titleLabel.rightAnchor.align(to: containerView.rightAnchor, offset: -10)
        titleLabel.heightAnchor.equal(to: 15)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
