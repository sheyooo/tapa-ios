

//
//  TrailerPageViewController.swift
//  TapaTV
//
//  Created by SimpuMind on 3/16/18.
//  Copyright © 2018 SimpuMind. All rights reserved.
//

import UIKit

enum PageType {
    case first
    case second
    case third
}

class TrailerPageViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout  {
    
    
    let pages = [
        Page(imageName: #imageLiteral(resourceName: "gorilla"), bodyText: "Get the first Movie & TV information", type: .first, startColor: #colorLiteral(red: 0.9607843137, green: 0.5647058824, blue: 0.05490196078, alpha: 0.1663634418), endColor: #colorLiteral(red: 0.8588235294, green: 0.1921568627, blue: 0.4039215686, alpha: 1), startPoint: CGPoint.zero, endPoint: CGPoint.zero),
        Page(imageName: #imageLiteral(resourceName: "woman_pc"), bodyText: "Know the Movie is not worth Watching", type: .second, startColor: #colorLiteral(red: 0.9607843137, green: 0.8352941176, blue: 0.2784313725, alpha: 0), endColor: #colorLiteral(red: 0.9607843137, green: 0.8352941176, blue: 0.2784313725, alpha: 1), startPoint: CGPoint(x: 0.0, y: 0.5), endPoint: CGPoint(x: 1.0, y: 0.5)),
        Page(imageName: #imageLiteral(resourceName: "man_woman_pc"), bodyText: "Real-time update Movie Trailer", type: .third, startColor: #colorLiteral(red: 0.9764705882, green: 0.6235294118, blue: 0, alpha: 1), endColor: #colorLiteral(red: 0.8588235294, green: 0.1882352941, blue: 0.4117647059, alpha: 1), startPoint: CGPoint(x: 0.0, y: 0.5), endPoint: CGPoint(x: 1.0, y: 0.5))
    ]
    
    fileprivate lazy var pageControl: TrailerPageControl = {
        let pc = TrailerPageControl()
        pc.numberOfPages = 3
        pc.currentPage = 0
        pc.translatesAutoresizingMaskIntoConstraints = false
        return pc
    }()
    
    fileprivate lazy var nextButton: ButtonWithImage = {
        let button = ButtonWithImage()
        button.setTitle("Next", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "Avenir-Black", size: 18)
        button.setImage(#imageLiteral(resourceName: "right_arrow"), for: .normal)
        button.layer.cornerRadius = 20
        button.backgroundColor = .clear
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.white.cgColor
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    fileprivate lazy var getStartButton: GradientButton = {
        let button = GradientButton()
        button.setTitle("Get Started", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "Avenir-Black", size: 18)
        button.backgroundColor = .clear
        button.translatesAutoresizingMaskIntoConstraints = false
        button.endColor = #colorLiteral(red: 0.8588235294, green: 0.1882352941, blue: 0.4117647059, alpha: 1)
        button.startColor = #colorLiteral(red: 0.9764705882, green: 0.6235294118, blue: 0, alpha: 1)
        button.alpha = 0.8
        button.isEnabled = false
        button.isHidden = true
        button.startPoint = CGPoint(x: 0.0, y: 0.5)
        button.endPoint = CGPoint(x: 1.0, y: 0.5)
        return button
    }()
    
    @objc private func handlePrev() {
        let nextIndex = max(pageControl.currentPage - 1, 0)
        let indexPath = IndexPath(item: nextIndex, section: 0)
        pageControl.currentPage = nextIndex
        configButtons(indexPath: indexPath)
        collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    @objc private func handleNext() {
        let nextIndex = min(pageControl.currentPage + 1, pages.count - 1)
        let indexPath = IndexPath(item: nextIndex, section: 0)
        pageControl.currentPage = nextIndex
        configButtons(indexPath: indexPath)
        collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    fileprivate func setupBottomControls() {
        view.addSubview(pageControl)
        view.addSubview(nextButton)
        view.addSubview(getStartButton)
        
        nextButton.bottomAnchor.align(to: view.bottomAnchor, offset: -20)
        nextButton.widthAnchor.equal(to: 150)
        nextButton.heightAnchor.equal(to: 40)
        nextButton.centerXAnchor.align(to: view.centerXAnchor)
        
        getStartButton.bottomAnchor.align(to: view.bottomAnchor, offset: -20)
        getStartButton.widthAnchor.equal(to: 150)
        getStartButton.heightAnchor.equal(to: 40)
        getStartButton.centerXAnchor.align(to: view.centerXAnchor)
        
        pageControl.bottomAnchor.align(to: nextButton.topAnchor, offset: -20)
        pageControl.widthAnchor.equal(to: 150)
        pageControl.heightAnchor.equal(to: 20)
        pageControl.centerXAnchor.align(to: view.centerXAnchor)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBottomControls()
        if #available(iOS 11.0, *) {
            collectionView?.contentInsetAdjustmentBehavior = .never
        } else {
            // Fallback on earlier versions
        }
        collectionView?.backgroundColor = .white
        collectionView?.register(PageCell.self, forCellWithReuseIdentifier: "cellId")
        collectionView?.showsHorizontalScrollIndicator = false
        collectionView?.showsVerticalScrollIndicator = false
        collectionView?.isPagingEnabled = true
        
        nextButton.addTarget(self, action: #selector(handleNext), for: .touchUpInside)
        getStartButton.addTarget(self, action: #selector(handleGetStarted), for: .touchUpInside)
    }
    
    @objc func handleGetStarted(){
        let vc = LoginVC()
        present(vc, animated: true, completion: nil)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        pageControl.updateDots()
    }
    
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        let x = targetContentOffset.pointee.x
        
        pageControl.currentPage = Int(x / view.frame.width)
        
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        
        coordinator.animate(alongsideTransition: { (_) in
            self.collectionViewLayout.invalidateLayout()
            
            if self.pageControl.currentPage == 0 {
                self.collectionView?.contentOffset = .zero
            } else {
                let indexPath = IndexPath(item: self.pageControl.currentPage, section: 0)
                self.collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            }
            
        }) { (_) in
            
        }
    }
    
    override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        var visibleRect = CGRect()
        guard let collectionView = collectionView else {return}
        visibleRect.origin = collectionView.contentOffset
        visibleRect.size = collectionView.bounds.size
        
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
        
        guard let visibleIndexPath: IndexPath = collectionView.indexPathForItem(at: visiblePoint) else { return }
        configButtons(indexPath: visibleIndexPath)
    }
    
    func configButtons(indexPath: IndexPath){
        getStartButton.isHidden = (indexPath.item == pages.count - 1) ? false : true
        getStartButton.isEnabled = (indexPath.item == pages.count - 1) ? true : false
        nextButton.alpha = (indexPath.item == pages.count - 1) ? 0 : 1
        nextButton.isEnabled = (indexPath.item == pages.count - 1) ? false : true
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pages.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! PageCell
        
        let page = pages[indexPath.item]
        cell.page = page
        //cell.type = page.type
        return cell
    }
    

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
    
}
