//
//  MainVC.swift
//  TapaTV
//
//  Created by SimpuMind on 4/8/18.
//  Copyright © 2018 SimpuMind. All rights reserved.
//

import UIKit
import TBEmptyDataSet


class MainVC: UIViewController {
    
    var movies = [Movie]()
    var type = "movies"
    var popover: Popover!
    fileprivate var popoverOptions: [PopoverOption] = [
        .type(.down),
        .blackOverlayColor(UIColor(white: 0.0, alpha: 0.6))
    ]
    var popoverItems = [String]()
    
    var popOverTableView: UITableView!
    
    fileprivate var itemsPerRow: CGFloat = (AppDelegate.isiPad()) ? 4 : 2
    
    fileprivate let sectionInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    
    fileprivate lazy var searchButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "search_icon").maskWithColor(color: .white), for: .normal)
        button.contentMode = .scaleAspectFit
        button.addTarget(self, action: #selector(handleSearchClick), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    fileprivate lazy var menuButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "Menu"), for: .normal)
        button.contentMode = .scaleAspectFit
        button.addTarget(self, action: #selector(handleMenuToggle), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = type.uppercased()
        label.textColor = .white
        let titleSize = Constant.isCompact(view: view, yes: 18, no: 20)
        label.font = UIFont(name: "Avenir", size: CGFloat(titleSize))
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var filterButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        
        var attr = [NSAttributedStringKey.underlineStyle : 1, NSAttributedStringKey.foregroundColor : UIColor.white, NSAttributedStringKey.font : UIFont.systemFont(ofSize: 14)] as [NSAttributedStringKey : Any]
        var attributedString = NSMutableAttributedString(string:"")
        let buttonTitleStr = NSMutableAttributedString(string:"Filter", attributes: attr)
        attributedString.append(buttonTitleStr)
        button.setAttributedTitle(attributedString, for: .normal)
        button.addTarget(self, action: #selector(handleMoreFilter), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionViewLayout = UICollectionViewFlowLayout()
       let cv = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        cv.backgroundColor = .clear
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.startAnimating()
        indicator.hidesWhenStopped = true
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    @objc private func handleMenuToggle(){
        let vc = SlideVC()
        let navVC = UISideMenuNavigationController(rootViewController: vc)
        navVC.leftSide = true
        present(navVC, animated: true, completion: nil)
    }
    
    @objc private func handleMoreFilter(){
        if movies.count == 0 {
            return
        }
        popOverTableView = UITableView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 135))
        popOverTableView.delegate = self
        popOverTableView.dataSource = self
        popOverTableView.backgroundColor = #colorLiteral(red: 0.1977315053, green: 0.2017299144, blue: 0.262745098, alpha: 1)
        popOverTableView.register(CustomCell.self, forCellReuseIdentifier: "cell")
        popOverTableView.isScrollEnabled = false
        popOverTableView.separatorColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 0.4992508562)
        popOverTableView.separatorInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        popover = Popover(options: popoverOptions)
        popover.popoverColor = #colorLiteral(red: 0.1977315053, green: 0.2017299144, blue: 0.262745098, alpha: 1)
        popover.cornerRadius = 10
        DispatchQueue.main.async {
            self.popOverTableView.sizeToFit()
            self.popover.show(self.popOverTableView, fromView: self.filterButton)
        }
    }
    
    @objc private func handleSearchClick(){
        let backButtonItem = UIBarButtonItem()
        backButtonItem.title = ""
        backButtonItem.tintColor = .white
        navigationItem.backBarButtonItem = backButtonItem
        let vc = SearchVC()
        navigationController?.pushViewController(vc, animated: false)
    }
    
    private func fetchMovies() {
        activityIndicator.startAnimating()
        ApiService.shared.fetchContentList(type: type) { (contents, message) in
            self.collectionView.emptyDataSetDataSource = self
            self.collectionView.emptyDataSetDelegate = self
            self.activityIndicator.stopAnimating()
            self.setupCollectionView()
            if contents == nil {
                self.collectionView.reloadData()
                return
            }
            self.popoverItems = (self.type == "sports") ? ["Soccer", "Other Sports"] : ["Films", "Documentary", "Reality", "Random"]
            guard let movies = contents else {return}
            self.movies = movies
            self.collectionView.reloadData()
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        let orientation: UIInterfaceOrientationMask = [UIInterfaceOrientationMask.all]
        return orientation
    }
    
    override var shouldAutorotate: Bool{
        return true
    }
    
    override func viewDidLoad() {
        view.backgroundColor = #colorLiteral(red: 0.2, green: 0.2, blue: 0.2666666667, alpha: 1)
        //navigationItem.title = "MOVIES"
        
        let searchBarButton = UIBarButtonItem(image: #imageLiteral(resourceName: "search_icon"), style: .plain, target: self, action: #selector(handleSearchClick))
        searchBarButton.tintColor = .white
        self.navigationItem.rightBarButtonItem = searchBarButton
        
        let menuBarButton = UIBarButtonItem(image: #imageLiteral(resourceName: "Menu"), style: .plain, target: self, action: #selector(handleMenuToggle))
        menuBarButton.tintColor = .white
        self.navigationItem.leftBarButtonItem = menuBarButton
        
        [titleLabel, filterButton, collectionView, activityIndicator].forEach {view.addSubview($0)}
        
        NotificationCenter.default.addObserver(self, selector: #selector(deviceRotated), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
        
        fetchMovies()
        
        
    }
    
    private func setupCollectionView(){
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(NowCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.register(MovieHeaderView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "movieHeaderView")

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
        //AppUtility.lockOrientation(.all)
        navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let size: CGFloat =  Constant.isCompact(view: view, yes: 45, no: 65)
        
        titleLabel.topAnchor.align(to: view.layoutMarginsGuide.topAnchor, offset: 10)
        titleLabel.leftAnchor.align(to: view.layoutMarginsGuide.leftAnchor, offset: 20)
        titleLabel.heightAnchor.equal(to: size)
        titleLabel.widthAnchor.equal(to: 150)
        
        filterButton.topAnchor.align(to: view.layoutMarginsGuide.topAnchor, offset: 10)
        filterButton.rightAnchor.align(to: view.layoutMarginsGuide.rightAnchor, offset: -20)
        filterButton.heightAnchor.equal(to: size)
        filterButton.widthAnchor.equal(to: 80)
        
        collectionView.topAnchor.align(to: titleLabel.bottomAnchor, offset: 10)
        collectionView.leftAnchor.align(to: view.layoutMarginsGuide.leftAnchor)
        collectionView.rightAnchor.align(to: view.layoutMarginsGuide.rightAnchor)
        collectionView.bottomAnchor.align(to: view.layoutMarginsGuide.bottomAnchor)
        
        activityIndicator.centerYAnchor.align(to: view.centerYAnchor)
        activityIndicator.centerXAnchor.align(to: view.centerXAnchor)
        activityIndicator.widthAnchor.equal(to: 40)
        activityIndicator.heightAnchor.equal(to: 40)
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

extension MainVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
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
        let movie = movies[indexPath.item]
        didSelectMovie(movie: movie)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        var reusableView : UICollectionReusableView? = nil
        
        if (kind == UICollectionElementKindSectionHeader) {
            // Create Header
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "movieHeaderView", for: indexPath) as! MovieHeaderView
            headerView.type = type
            headerView.headerDelegate = self
            reusableView = headerView
        }
        return reusableView!
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var width: CGFloat = 0
        switch UIDevice.current.orientation {
        case .portrait, .portraitUpsideDown:
            width = view.layoutMarginsGuide.layoutFrame.width
        case .landscapeLeft, .landscapeRight:
            width = view.layoutMarginsGuide.layoutFrame.width
        default:
            width = view.layoutMarginsGuide.layoutFrame.width
        }
        
        let paddingSpace = sectionInsets.right * (itemsPerRow + 1)
        let availableWidth = width - paddingSpace
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

extension MainVC: HeaderViewDelegate {
    
    func didSelectMovie(movie: Movie) {
        let vc = MovieDetailsVC()
        vc.movie = movie
        let nav = UINavigationController(rootViewController: vc)
        present(nav, animated: true, completion: nil)
    }
}

extension MainVC: TBEmptyDataSetDelegate, TBEmptyDataSetDataSource {
    
    func imageForEmptyDataSet(in scrollView: UIScrollView) -> UIImage? {
        return nil
    }
    
    func titleForEmptyDataSet(in scrollView: UIScrollView) -> NSAttributedString? {
        return NSAttributedString(string: "Something went wrong!", attributes: [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 18)])
    }
    
    func descriptionForEmptyDataSet(in scrollView: UIScrollView) -> NSAttributedString? {
        return NSAttributedString(string: " Please check that you are connected to the internet.\n\n Tap to retry!", attributes: [NSAttributedStringKey.font : UIFont.systemFont(ofSize: 14)])
    }
    
    func emptyDataSetTapEnabled(in scrollView: UIScrollView) -> Bool {
        return true
    }
    func emptyDataSetDidTapEmptyView(in scrollView: UIScrollView) {
        fetchMovies()
    }
}

extension MainVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return popoverItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomCell
        cell.textLabel?.font = UIFont.systemFont(ofSize: 14)
        cell.textLabel?.text = popoverItems[indexPath.item]
        cell.textLabel?.textColor = .white
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //let item = popoverItems[indexPath.item]
        
        self.popover.dismiss()
    }
}

class CustomCell: UITableViewCell {
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        selectionStyle = .gray
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.backgroundColor = #colorLiteral(red: 0.1367795458, green: 0.1363631674, blue: 0.184029981, alpha: 1)
        super.touchesBegan(touches, with: event)
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.backgroundColor = .clear
        super.touchesBegan(touches, with: event)
    }
    
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.1977315053, green: 0.2017299144, blue: 0.262745098, alpha: 1)
        selectedBackgroundView = view
    }
}
