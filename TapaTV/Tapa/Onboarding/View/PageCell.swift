//
//  PageCell.swift
//  TapaTV
//
//  Created by SimpuMind on 3/16/18.
//  Copyright © 2018 SimpuMind. All rights reserved.
//

import UIKit

class PageCell: UICollectionViewCell {
    
    var page: Page? {
        didSet {
            //            print(page?.imageName)
            
            guard let unwrappedPage = page else { return }
            
            bearImageView.image = unwrappedPage.imageName
            descriptionTextView.text = unwrappedPage.bodyText
        }
    }
    
    var coverView: GradientView = {
        let view = GradientView()
        view.endColor = #colorLiteral(red: 0.2380433058, green: 0.1593357317, blue: 0.02270878988, alpha: 1)
        view.startColor = #colorLiteral(red: 0.2853941942, green: 0.2471860356, blue: 0.0871911636, alpha: 0.955265411)
        view.alpha = 0.8
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var coverView2: GradientView = {
        let view = GradientView()
        view.endColor = #colorLiteral(red: 0.2800999365, green: 0.243942765, blue: 0.08351068305, alpha: 1)
        view.startColor = #colorLiteral(red: 0.4794971447, green: 0.4176004491, blue: 0.1429601683, alpha: 0.6019905822)
        view.alpha = 0.8
        view.startPoint = CGPoint(x: 0.0, y: 0.5)
        view.endPoint = CGPoint(x: 1.0, y: 0.5)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var coverView3: GradientView = {
        let view = GradientView()
        view.endColor = #colorLiteral(red: 0.07843137255, green: 0.1333333333, blue: 0.2745098039, alpha: 1)
        view.startColor = #colorLiteral(red: 0.2039215686, green: 0.3607843137, blue: 0.7725490196, alpha: 0)
        view.alpha = 0.8
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    ///
    //var centerView: GradientView = {
    //    let view = GradientView()
    //    view.backgroundColor = .clear
        //view.multipleEndColor = [#colorLiteral(red: 0.1333333333, green: 0.1333333333, blue: 0.1333333333, alpha: 0), #colorLiteral(red: 0.1333333333, green: 0.1333333333, blue: 0.1333333333, alpha: 1), #colorLiteral(red: 0.1333333333, green: 0.1333333333, blue: 0.1333333333, alpha: 1)]
     //   view.translatesAutoresizingMaskIntoConstraints = false
    //    return view
    //}()
    
    private let bearImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    private let descriptionTextView: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.numberOfLines = 4
        label.textAlignment = .center
        label.font = UIFont(name: "Avenir", size: 36)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func layoutSubviews() {
        setupLayout()
    }
    
    private func setupLayout() {
        
        guard let page = page else {return}
        switch page.type {
        case .first:
            backgroundColor = #colorLiteral(red: 0.2380433058, green: 0.1593357317, blue: 0.02270878988, alpha: 1)
            [bearImageView,
             coverView, descriptionTextView].forEach {addSubview($0)}
            bearImageView.fill(self)
            
            coverView.fill(self)
        case .second:
            backgroundColor = #colorLiteral(red: 0.2666666667, green: 0.4196078431, blue: 0.8117647059, alpha: 1)
            [bearImageView, coverView2, descriptionTextView].forEach {addSubview($0)}
            bearImageView.fill(self)
            coverView2.fill(self)
        case .third:
            backgroundColor = #colorLiteral(red: 0.2666666667, green: 0.4196078431, blue: 0.8117647059, alpha: 1)
            [bearImageView, coverView3, descriptionTextView].forEach {addSubview($0)}
            bearImageView.fill(self)
            coverView3.fill(self)
        }
        
        descriptionTextView.widthAnchor.equal(to: 260)
        descriptionTextView.centerYAnchor.align(to: centerYAnchor)
        descriptionTextView.centerXAnchor.align(to: centerXAnchor)
        descriptionTextView.heightAnchor.equal(to: 160)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

