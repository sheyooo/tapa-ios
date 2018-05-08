//
//  MoviesVC.swift
//  TapaTV
//
//  Created by SimpuMind on 3/16/18.
//  Copyright © 2018 SimpuMind. All rights reserved.
//

import UIKit

class MoviesVC: UIViewController {
    
    var movies = [Movie]()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "MOVIES"
        label.textColor = .white
        let titleSize = Constant.isCompact(view: view, yes: 18, no: 20)
        label.font = UIFont(name: "Avenir", size: CGFloat(titleSize))
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.backgroundColor = .clear
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    @objc private func handleMenuToggle(){
        let vc = SlideVC()
        let navVC = UISideMenuNavigationController(rootViewController: vc)
        navVC.leftSide = true
        present(navVC, animated: true, completion: nil)

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.2, green: 0.2, blue: 0.2666666667, alpha: 1)
        
        self.tabBarItem.selectedImage = #imageLiteral(resourceName: "movie_fill_icon").withRenderingMode(.alwaysOriginal)
        self.tabBarItem.image = #imageLiteral(resourceName: "movie_line_icon").withRenderingMode(.alwaysOriginal)
        
        
        let menuBarButton = UIBarButtonItem(image: #imageLiteral(resourceName: "Menu"), style: .plain, target: self, action: #selector(handleMenuToggle))
        menuBarButton.tintColor = .white
        navigationItem.leftBarButtonItem = menuBarButton
        
        let searchButton = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: nil)
        searchButton.tintColor = .white
        navigationItem.rightBarButtonItem = menuBarButton
        
        [titleLabel, tableView].forEach {view.addSubview($0)}
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.showsHorizontalScrollIndicator = false
        tableView.showsVerticalScrollIndicator = false
        tableView.sectionHeaderHeight = 40
        tableView.register(NowMovieCell.self, forCellReuseIdentifier: "nowMovieCell")
        tableView.register(PopularMovieCell.self, forCellReuseIdentifier: "popularMovieCell")
        
        tableView.tableHeaderView = MoviesHeaderView(frame: CGRect(x: 0, y: 0, width: view.frame.width - 0, height: Constant.isCompact(view: view, yes: 200, no: 400)))
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
        
        titleLabel.topAnchor.align(to: view.topAnchor, offset: 15)
        titleLabel.leftAnchor.align(to: view.leftAnchor, offset: 20)
        titleLabel.heightAnchor.equal(to: size)
        titleLabel.widthAnchor.equal(to: 150)
        
        tableView.topAnchor.align(to: titleLabel.bottomAnchor, offset: 10)
        tableView.leftAnchor.align(to: view.layoutMarginsGuide.leftAnchor)
        tableView.rightAnchor.align(to: view.layoutMarginsGuide.rightAnchor)
        tableView.bottomAnchor.align(to: view.layoutMarginsGuide.bottomAnchor)
    }
}

extension MoviesVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "nowMovieCell", for: indexPath) as! NowMovieCell
            cell.viewController = self
            return cell
        }else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "popularMovieCell", for: indexPath) as! PopularMovieCell
            cell.viewController = self
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return Constant.isCompact(view: view, yes: 220, no: 400)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let title = ["Now", "Popular"]
        
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: 30))
        headerView.backgroundColor = view.backgroundColor
        let label = UILabel(frame: CGRect(x: 0, y: headerView.frame.height - 20, width: tableView.bounds.size.width, height: 22))
        label.text = title[section]
        label.textColor = .white
        let size: CGFloat = Constant.isCompact(view: view, yes: 14, no: 20)
        label.font = UIFont(name: "Avenir", size: size)
        headerView.addSubview(label)
        return headerView
    }
    
}
