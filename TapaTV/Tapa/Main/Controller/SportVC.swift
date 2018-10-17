//
//  SportVC.swift
//  TapaTV
//
//  Created by SimpuMind on 6/17/18.
//  Copyright © 2018 SimpuMind. All rights reserved.
//

import UIKit
import TBEmptyDataSet

class SportVC: UIViewController {

    var popover: Popover!
    fileprivate var popoverOptions: [PopoverOption] = [
        .type(.down),
        .blackOverlayColor(UIColor(white: 0.0, alpha: 0.6))
    ]
    var popoverItems = ["Soccer", "Other Sports"]
    var popOverTableView: UITableView!
    
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
    
    
    private lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.backgroundColor = .clear
        tv.separatorStyle = .none
        tv.showsHorizontalScrollIndicator = false
        tv.showsVerticalScrollIndicator = false
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    private lazy var refereshControl: UIRefreshControl = {
        let rc = UIRefreshControl()
        rc.attributedTitle = NSAttributedString(string: "Fetching Movies...", attributes: [.font: UIFont.systemFont(ofSize: 17), .foregroundColor: UIColor.white])
        //rc.addTarget(self, action: #selector(fetchMovies), for: .valueChanged)
        return rc
    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        //indicator.startAnimating()
        indicator.hidesWhenStopped = true
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return  indicator
    }()
    
    @objc private func handleMenuToggle(){
        let vc = SlideVC()
        let navVC = UISideMenuNavigationController(rootViewController: vc)
        navVC.leftSide = true
        present(navVC, animated: true, completion: nil)
    }
    
    @objc private func handleMoreFilter(sender: UIBarButtonItem){
//        if movies.count == 0 {
//            return
//        }
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
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = #colorLiteral(red: 0.2, green: 0.2, blue: 0.2666666667, alpha: 1)
        //navigationItem.title = "MOVIES"
        
        let filterBarButton = UIBarButtonItem(image: #imageLiteral(resourceName: "filter"), style: .plain, target: self, action: #selector(handleMoreFilter(sender:)))
        filterBarButton.tintColor = .white
        self.navigationItem.rightBarButtonItem = filterBarButton
        
        let menuBarButton = UIBarButtonItem(image: #imageLiteral(resourceName: "Menu"), style: .plain, target: self, action: #selector(handleMenuToggle))
        menuBarButton.tintColor = .white
        self.navigationItem.leftBarButtonItem = menuBarButton
        
        [tableView, activityIndicator].forEach {view.addSubview($0)}
        searchView.addSubview(searchTextField)
          
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 15))
        imageView.image = #imageLiteral(resourceName: "search_icon")
        imageView.contentMode = .scaleAspectFit
        searchTextField.leftViewMode = .always
        searchTextField.leftView = imageView
        searchTextField.addTarget(self, action: #selector(handleSearchClick), for: .touchDown)
        navigationItem.titleView = searchView
        
        setupTableView()
    }
    
    private func setupTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.refreshControl = refereshControl
        tableView.register(SportCell.self, forCellReuseIdentifier: "sportProtriatCell")
        //collectionView.register(MovieHeaderView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "movieHeaderView")
        
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tableView.topAnchor.align(to: view.layoutMarginsGuide.topAnchor, offset: 10)
        tableView.leftAnchor.align(to: view.layoutMarginsGuide.leftAnchor)
        tableView.rightAnchor.align(to: view.layoutMarginsGuide.rightAnchor)
        tableView.bottomAnchor.align(to: view.layoutMarginsGuide.bottomAnchor)
        
        activityIndicator.centerYAnchor.align(to: view.centerYAnchor)
        activityIndicator.centerXAnchor.align(to: view.centerXAnchor)
        activityIndicator.widthAnchor.equal(to: 40)
        activityIndicator.heightAnchor.equal(to: 40)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIDevice.orientationDidChangeNotification, object: nil)
    }
    
}

extension SportVC: TBEmptyDataSetDelegate, TBEmptyDataSetDataSource {
    
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
        
    }
}

extension SportVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        if tableView == self.tableView {
            return 5
        }else{
            return popoverItems.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        if tableView == self.popOverTableView{
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomCell
            cell.textLabel?.font = UIFont.systemFont(ofSize: 14)
            cell.textLabel?.text = popoverItems[indexPath.item]
            cell.textLabel?.textColor = .white
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "sportProtriatCell", for: indexPath) as! SportCell
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //let item = popoverItems[indexPath.item]
        if tableView == self.tableView {
            
        }else{
            self.popover.dismiss()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == self.tableView {
            return 250
        }else{
            return 44
        }
    }
}
