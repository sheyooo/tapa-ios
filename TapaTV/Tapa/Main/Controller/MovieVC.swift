//
//  MovieVC.swift
//  TapaTV
//
//  Created by SimpuMind on 4/8/18.
//  Copyright © 2018 SimpuMind. All rights reserved.
//

import UIKit

class MovieVC: UIViewController {
    
    var movies = [Movie]()
    
    var pages = [#imageLiteral(resourceName: "jumani"), #imageLiteral(resourceName: "lastjedi"), #imageLiteral(resourceName: "ohnoviginsa"), #imageLiteral(resourceName: "pirates"), #imageLiteral(resourceName: "spiderman"), #imageLiteral(resourceName: "starwars"), #imageLiteral(resourceName: "titanic"), #imageLiteral(resourceName: "jumani"), #imageLiteral(resourceName: "lastjedi"), #imageLiteral(resourceName: "ohnoviginsa"), #imageLiteral(resourceName: "pirates"), #imageLiteral(resourceName: "spiderman"), #imageLiteral(resourceName: "starwars"), #imageLiteral(resourceName: "titanic"), #imageLiteral(resourceName: "jumani"), #imageLiteral(resourceName: "lastjedi"), #imageLiteral(resourceName: "ohnoviginsa"), #imageLiteral(resourceName: "pirates"), #imageLiteral(resourceName: "spiderman"), #imageLiteral(resourceName: "starwars"), #imageLiteral(resourceName: "titanic")]
    
    fileprivate var itemsPerRow: CGFloat = (AppDelegate.isiPad()) ? 4 : 2
    
    fileprivate let sectionInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    
    fileprivate lazy var searchButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "search_icon").maskWithColor(color: .white), for: .normal)
        button.contentMode = .scaleAspectFit
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "MOVIES"
        label.textColor = .white
        let titleSize = Constant.isCompact(view: view, yes: 18, no: 20)
        label.font = UIFont(name: "Avenir", size: CGFloat(titleSize))
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionViewLayout = UICollectionViewFlowLayout()
       let cv = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        cv.backgroundColor = .clear
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    
    private func fetchMovies() {
        ApiService.shared.fetchMovieList { (movies, message) in
            if movies == nil {
                return
            }
            
            guard let movies = movies else {return}
            self.movies = movies
            self.collectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.2, green: 0.2, blue: 0.2666666667, alpha: 1)
        
        self.tabBarItem.selectedImage = #imageLiteral(resourceName: "movie_fill_icon").withRenderingMode(.alwaysOriginal)
        self.tabBarItem.image = #imageLiteral(resourceName: "movie_line_icon").withRenderingMode(.alwaysOriginal)
        
        [titleLabel, searchButton, collectionView].forEach {view.addSubview($0)}
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(NowCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.register(MovieHeaderView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "movieHeaderView")
        
        NotificationCenter.default.addObserver(self, selector: #selector(deviceRotated), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
        
        fetchMovies()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
    }
    
    @objc func deviceRotated(){
        if UIDeviceOrientationIsLandscape(UIDevice.current.orientation) {
            print("Landscape")
            // Resize other things
            self.itemsPerRow = 4
            self.collectionView.reloadData()
        }
        if UIDeviceOrientationIsPortrait(UIDevice.current.orientation) {
            print("Portrait")
            // Resize other things
            if !AppDelegate.isiPad() {
                self.itemsPerRow = 2
                self.collectionView.reloadData()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let size: CGFloat = (self.view.traitCollection.horizontalSizeClass == .compact) ? 45 : 65
        titleLabel.topAnchor.align(to: view.topAnchor, offset: 35)
        titleLabel.leftAnchor.align(to: view.leftAnchor, offset: 20)
        titleLabel.heightAnchor.equal(to: size)
        titleLabel.widthAnchor.equal(to: 150)
        
        searchButton.topAnchor.align(to: view.topAnchor, offset: 20)
        searchButton.rightAnchor.align(to: view.rightAnchor, offset: -10)
        searchButton.heightAnchor.equal(to: size)
        searchButton.widthAnchor.equal(to: size)
        
        collectionView.topAnchor.align(to: titleLabel.bottomAnchor, offset: 10)
        collectionView.leftAnchor.align(to: view.layoutMarginsGuide.leftAnchor)
        collectionView.rightAnchor.align(to: view.layoutMarginsGuide.rightAnchor)
        collectionView.bottomAnchor.align(to: view.layoutMarginsGuide.bottomAnchor)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        coordinator.animate(alongsideTransition: { (UIViewControllerTransitionCoordinatorContext) -> Void in
            
            let orient = UIApplication.shared.statusBarOrientation
            
            switch orient {
                
            case .portrait:
                
                print("Portrait")
                
            case .landscapeLeft, .landscapeRight :
                
                print("Landscape")
                
            default:
                
                print("Anything But Portrait")
            }
            
        }, completion: { (UIViewControllerTransitionCoordinatorContext) -> Void in
            //refresh view once rotation is completed not in will transition as it returns incorrect frame size.Refresh here
            
        })
        super.viewWillTransition(to: size, with: coordinator)
    }
}

extension MovieVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! NowCell
        cell.movie = movies[indexPath.item]
//        cell.videoThumbNail.image = pages[indexPath.item]
//        cell.titleLabel.text = "GOES HERE (8201)"
        return cell

    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = MovieDetailsVC()
        let movie = movies[indexPath.item]
        vc.movie = movie
        let nav = UINavigationController(rootViewController: vc)
        present(nav, animated: true, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        var reusableView : UICollectionReusableView? = nil
        
        if (kind == UICollectionElementKindSectionHeader) {
            // Create Header
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "movieHeaderView", for: indexPath) as! MovieHeaderView
            
            reusableView = headerView
        }
        return reusableView!
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let paddingSpace = sectionInsets.right * (itemsPerRow + 1)
        let availableWidth = collectionView.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        
        return CGSize(width: widthPerItem - 10, height: widthPerItem + 90)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.right
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width - 0, height: Constant.isCompact(view: view, yes: 200, no: 400))
    }
}
