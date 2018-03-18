//
//  PopularMovieCell.swift
//  TapaTV
//
//  Created by SimpuMind on 3/16/18.
//  Copyright © 2018 SimpuMind. All rights reserved.
//

import UIKit

class PopularMovieCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var viewController: UIViewController?
    
    var pages = [#imageLiteral(resourceName: "antman"), #imageLiteral(resourceName: "assasin"), #imageLiteral(resourceName: "b2f"), #imageLiteral(resourceName: "babydriver"), #imageLiteral(resourceName: "beautyandbeast"), #imageLiteral(resourceName: "blackmirror"), #imageLiteral(resourceName: "fear")]
    
    private lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(NowCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.register(SeeMoreCell.self, forCellWithReuseIdentifier: "seeMoreCell")
        selectionStyle = .none
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.fill(self)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.item == pages.count - 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "seeMoreCell", for: indexPath) as! SeeMoreCell
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! NowCell
            cell.videoThumbNail.image = pages[indexPath.item]
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = MovieListVC()
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
//        
//        let paddingSpace = sectionInsets.left * (2 + 1)
//        let availableWidth = collectionView.frame.width - paddingSpace
//        let widthPerItem = availableWidth / 2
        
        let size = CGSize(width: Constant.isCompact(view: self, yes: frame.height - 80, no: frame.height - 100), height: Constant.isCompact(view: self, yes: collectionView.frame.height, no: collectionView.frame.height + 20))
        return CGSize(width: size.width, height: size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: Constant.isCompact(view: self, yes: 15, no: 25))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: Constant.isCompact(view: self, yes: 15, no: 25)).right
    }
    
}

