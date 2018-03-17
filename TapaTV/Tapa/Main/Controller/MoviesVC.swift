//
//  MoviesVC.swift
//  TapaTV
//
//  Created by SimpuMind on 3/16/18.
//  Copyright © 2018 SimpuMind. All rights reserved.
//

import UIKit

class MoviesVC: UIViewController {
    
//    private let bearImageView: UIImageView = {
//        let iv = UIImageView()
//        iv.image = #imageLiteral(resourceName: "gorilla")
//        iv.contentMode = .scaleAspectFill
//        iv.clipsToBounds = true
//       // iv.translatesAutoresizingMaskIntoConstraints = false
//        return iv
//    }()
//
//    private let coverView: UIView = {
//        let iv = UIView()
//        iv.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.5)
//        //iv.translatesAutoresizingMaskIntoConstraints = false
//        return iv
//    }()
    
    fileprivate lazy var searchButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "search_icon").maskWithColor(color: primaryColor), for: .normal)
        button.contentMode = .scaleAspectFit
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "MOVIES"
        label.textColor = primaryColor
        label.font = UIFont(name: "Avenir", size: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.backgroundColor = .clear
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    private lazy var movieSideView: MoviesHeaderView = {
       let view = MoviesHeaderView(frame: .zero)
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        
        self.tabBarItem.selectedImage = #imageLiteral(resourceName: "movie_fill_icon").withRenderingMode(.alwaysOriginal)
        self.tabBarItem.image = #imageLiteral(resourceName: "movie_line_icon").withRenderingMode(.alwaysOriginal)
        
        [titleLabel, searchButton, movieSideView, tableView].forEach {view.addSubview($0)}
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.showsHorizontalScrollIndicator = false
        tableView.showsVerticalScrollIndicator = false
        tableView.sectionHeaderHeight = 40
        tableView.register(NowMovieCell.self, forCellReuseIdentifier: "nowMovieCell")
        tableView.register(PopularMovieCell.self, forCellReuseIdentifier: "popularMovieCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        //bearImageView.fill(view)
        //coverView.fill(view)
        
        titleLabel.topAnchor.align(to: view.topAnchor, offset: 20)
        titleLabel.leftAnchor.align(to: view.leftAnchor, offset: 20)
        titleLabel.heightAnchor.equal(to: 45)
        titleLabel.widthAnchor.equal(to: 120)
        
        searchButton.topAnchor.align(to: view.topAnchor, offset: 20)
        searchButton.rightAnchor.align(to: view.rightAnchor, offset: -10)
        searchButton.heightAnchor.equal(to: 45)
        searchButton.widthAnchor.equal(to: 45)
        
        movieSideView.topAnchor.align(to: titleLabel.bottomAnchor, offset: 0)
        movieSideView.leftAnchor.align(to: view.leftAnchor, offset: 20)
        movieSideView.widthAnchor.equal(to: (view.frame.width / 2) - 60)
        movieSideView.bottomAnchor.align(to: view.bottomAnchor, offset: -60)
        
        tableView.topAnchor.align(to: searchButton.bottomAnchor, offset: 0)
        tableView.leftAnchor.align(to: movieSideView.rightAnchor, offset: 20)
        if #available(iOS 11.0, *) {
            tableView.rightAnchor.align(to: view.safeAreaLayoutGuide.rightAnchor, offset: -20)
        } else {
            // Fallback on earlier versions
            tableView.rightAnchor.align(to: view.rightAnchor, offset: -40)
        }
        if #available(iOS 11.0, *) {
            tableView.bottomAnchor.align(to: view.safeAreaLayoutGuide.bottomAnchor)
        } else {
            // Fallback on earlier versions
            tableView.bottomAnchor.align(to: view.bottomAnchor, offset: -20)
        }
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
        return 220
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let title = ["Now", "Popular"]
        
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: 20))
        headerView.backgroundColor = view.backgroundColor
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: 15))
        label.text = title[section]
        label.font = UIFont(name: "Avenir", size: 14)
        label.textColor = .white
        headerView.addSubview(label)
        return headerView
    }
    
}

