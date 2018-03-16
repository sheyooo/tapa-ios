//
//  MoviesVC.swift
//  TapaTV
//
//  Created by SimpuMind on 3/16/18.
//  Copyright © 2018 SimpuMind. All rights reserved.
//

import UIKit

class MoviesVC: UIViewController {
    
    fileprivate lazy var searchButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "search_icon"), for: .normal)
        button.contentMode = .scaleAspectFit
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "MOVIES"
        label.textColor = .black
        label.font = UIFont(name: "Avenir", size: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        self.tabBarItem.selectedImage = #imageLiteral(resourceName: "movie_fill_icon").withRenderingMode(.alwaysOriginal)
        self.tabBarItem.image = #imageLiteral(resourceName: "movie_line_icon").withRenderingMode(.alwaysOriginal)
        
        [titleLabel, searchButton, tableView].forEach {view.addSubview($0)}
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.showsHorizontalScrollIndicator = false
        tableView.showsVerticalScrollIndicator = false
        tableView.sectionHeaderHeight = 40
        tableView.register(NowMovieCell.self, forCellReuseIdentifier: "nowMovieCell")
        tableView.register(PopularMovieCell.self, forCellReuseIdentifier: "popularMovieCell")
        tableView.tableHeaderView = MoviesHeaderView(frame: CGRect(x: 20, y: 0, width: view.frame.width - 20, height: 170))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        titleLabel.topAnchor.align(to: view.topAnchor, offset: 44)
        titleLabel.leftAnchor.align(to: view.leftAnchor, offset: 20)
        titleLabel.heightAnchor.equal(to: 45)
        titleLabel.widthAnchor.equal(to: 120)
        
        searchButton.topAnchor.align(to: view.topAnchor, offset: 44)
        searchButton.rightAnchor.align(to: view.rightAnchor, offset: -10)
        searchButton.heightAnchor.equal(to: 45)
        searchButton.widthAnchor.equal(to: 45)
        
        tableView.topAnchor.align(to: titleLabel.bottomAnchor, offset: 10)
        tableView.leftAnchor.align(to: view.leftAnchor, offset: 20)
        tableView.rightAnchor.align(to: view.rightAnchor, offset: -20)
        tableView.bottomAnchor.align(to: view.bottomAnchor, offset: -60)
    }
}

extension MoviesVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
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
        if indexPath.section == 0 {
            return 220
        }else{
            return 450
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let title = ["Now", "Popular"]
        
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: 30))
        headerView.backgroundColor = UIColor.white
        let label = UILabel(frame: CGRect(x: 0, y: headerView.frame.height - 20, width: tableView.bounds.size.width, height: 15))
        label.text = title[section]
        label.font = UIFont(name: "Avenir", size: 14)
        headerView.addSubview(label)
        return headerView
    }
    
}

