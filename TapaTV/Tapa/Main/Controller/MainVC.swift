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
    
    private lazy var searchView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width - 100, height: 36))
        view.backgroundColor = #colorLiteral(red: 0.968627451, green: 0.968627451, blue: 0.968627451, alpha: 1)
        view.layer.cornerRadius = 18
        return view
    }()
    
    private lazy var searchTextField: UITextField = {
        let tf = UITextField(frame: CGRect(x: 10, y: 0, width: searchView.frame.width - 10, height: 36))
        let titleSize = Constant.isCompact(view: view, yes: 14, no: 14)
        tf.font = UIFont(name: "Avenir", size: CGFloat(titleSize))
        tf.borderStyle = .none
        tf.placeholder = "Type location"
        return tf
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
    
    private lazy var refereshControl: UIRefreshControl = {
       let rc = UIRefreshControl()
        rc.attributedTitle = NSAttributedString(string: "Fetching Movies...", attributes: [.font: UIFont.systemFont(ofSize: 17), .foregroundColor: UIColor.white])
        rc.addTarget(self, action: #selector(fetchMovies), for: .valueChanged)
        return rc
    }()
    
    @objc private func handleMenuToggle(){
        let vc = SlideVC()
        let navVC = UISideMenuNavigationController(rootViewController: vc)
        navVC.leftSide = true
        present(navVC, animated: true, completion: nil)
    }
    
    @objc private func handleMoreFilter(sender: UIBarButtonItem){
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
            self.popover.show(self.popOverTableView, fromView: sender.view!)
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
    
    @objc private func fetchMovies() {
        activityIndicator.startAnimating()
        ApiService.shared.fetchContentList(type: type) { (contents, message) in
            self.collectionView.emptyDataSetDataSource = self
            self.collectionView.emptyDataSetDelegate = self
            self.activityIndicator.stopAnimating()
            self.refereshControl.endRefreshing()
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
    
    override func viewDidLoad() {
        view.backgroundColor = #colorLiteral(red: 0.2, green: 0.2, blue: 0.2666666667, alpha: 1)
        //navigationItem.title = "MOVIES"
        
        let filterBarButton = UIBarButtonItem(image: #imageLiteral(resourceName: "filter"), style: .plain, target: self, action: #selector(handleMoreFilter))
        filterBarButton.tintColor = .white
        self.navigationItem.rightBarButtonItem = filterBarButton
        
        let menuBarButton = UIBarButtonItem(image: #imageLiteral(resourceName: "Menu"), style: .plain, target: self, action: #selector(handleMenuToggle))
        menuBarButton.tintColor = .white
        self.navigationItem.leftBarButtonItem = menuBarButton
        
        [collectionView, activityIndicator].forEach {view.addSubview($0)}
        searchView.addSubview(searchTextField)
        
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 15))
        imageView.image = #imageLiteral(resourceName: "search_icon")
        imageView.contentMode = .scaleAspectFit
        searchTextField.leftViewMode = .always
        searchTextField.leftView = imageView
        searchTextField.addTarget(self, action: #selector(handleSearchClick), for: .touchDown)
        
        navigationItem.titleView = searchView
        
        fetchMovies()
        
        
    }
    
    private func setupCollectionView(){
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.refreshControl = refereshControl
        collectionView.register(NowCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.register(MovieHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "movieHeaderView")

    }
    
    @objc func deviceRotated(){
        if UIDeviceOrientation.landscapeLeft == UIDevice.current.orientation {
            print("Landscape")
            // Resize other things
            self.itemsPerRow = 4
            self.collectionView.reloadData()
        }
        
        if UIDeviceOrientation.landscapeRight == UIDevice.current.orientation {
            print("Landscape")
            // Resize other things
            self.itemsPerRow = 4
            self.collectionView.reloadData()
        }
        
        if UIDeviceOrientation.portrait == UIDevice.current.orientation  {
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
        
        collectionView.topAnchor.align(to: view.layoutMarginsGuide.topAnchor, offset: 10)
        collectionView.leftAnchor.align(to: view.layoutMarginsGuide.leftAnchor)
        collectionView.rightAnchor.align(to: view.layoutMarginsGuide.rightAnchor)
        collectionView.bottomAnchor.align(to: view.layoutMarginsGuide.bottomAnchor)
        
        activityIndicator.centerYAnchor.align(to: view.centerYAnchor)
        activityIndicator.centerXAnchor.align(to: view.centerXAnchor)
        activityIndicator.widthAnchor.equal(to: 40)
        activityIndicator.heightAnchor.equal(to: 40)
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
        didShowViewController(movie: movie)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        var reusableView : UICollectionReusableView? = nil
        
        if (kind == UICollectionView.elementKindSectionHeader) {
            // Create Header
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "movieHeaderView", for: indexPath) as! MovieHeaderView
            headerView.type = type
            headerView.layer.cornerRadius = 10
            headerView.clipsToBounds = true
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

extension MainVC: MovieDetailDelegate {
    
    
    func didShowViewController(movie: Movie) {
        let backButtonItem = UIBarButtonItem()
        backButtonItem.title = ""
        backButtonItem.tintColor = .white
        navigationItem.backBarButtonItem = backButtonItem
        let vc = UIStoryboard.init(name: "Player", bundle: nil).instantiateViewController(withIdentifier: "VideoPlayerViewController") as! VideoPlayerViewController
        vc.video = movie.video
        present(vc, animated: true, completion: nil)
        //navigationController?.pushViewController(vc, animated: true)
    }
}

extension MainVC: TBEmptyDataSetDelegate, TBEmptyDataSetDataSource {
    
    func imageForEmptyDataSet(in scrollView: UIScrollView) -> UIImage? {
        return nil
    }
    
    func titleForEmptyDataSet(in scrollView: UIScrollView) -> NSAttributedString? {
        return NSAttributedString(string: "Something went wrong!", attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 18)])
    }
    
    func descriptionForEmptyDataSet(in scrollView: UIScrollView) -> NSAttributedString? {
        return NSAttributedString(string: " Please check that you are connected to the internet.\n\n Tap to retry!", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14)])
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
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
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
