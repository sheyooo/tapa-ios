//
//  SportVC.swift
//  TapaTV
//
//  Created by SimpuMind on 3/16/18.
//  Copyright © 2018 SimpuMind. All rights reserved.
//

import UIKit

class SportVC: UIViewController {
    
    
    var popover: Popover!
    fileprivate var popoverOptions: [PopoverOption] = [
        .type(.down),
        .blackOverlayColor(UIColor(white: 0.0, alpha: 0.6))
    ]
    let popoverItems = ["Soccer", "Other Sports"]
    
    var popOverTableView: UITableView!
    
    fileprivate lazy var searchButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "search_icon").maskWithColor(color: .white), for: .normal)
        button.contentMode = .scaleAspectFit
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
        label.text = "SPORT >"
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
    
    @objc func handleMoreFilter(){
        
        popOverTableView = UITableView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 135))
        popOverTableView.delegate = self
        popOverTableView.dataSource = self
        popOverTableView.isScrollEnabled = false
        popOverTableView.separatorColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        popover = Popover(options: popoverOptions)
        popover.popoverColor = #colorLiteral(red: 0.1977315053, green: 0.2017299144, blue: 0.262745098, alpha: 1)
        DispatchQueue.main.async {
            self.popOverTableView.sizeToFit()
            self.popover.show(self.popOverTableView, fromView: self.filterButton)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.2, green: 0.2, blue: 0.2666666667, alpha: 1)
        
        [menuButton, titleLabel, filterButton, searchButton, tableView].forEach {view.addSubview($0)}
        
        //tableView.delegate = self
        //tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.showsHorizontalScrollIndicator = false
        tableView.showsVerticalScrollIndicator = false
        tableView.sectionHeaderHeight = 40
        tableView.register(PopularTVCell.self, forCellReuseIdentifier: "popularTVCell")
        
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
        
        menuButton.topAnchor.align(to: view.topAnchor, offset: 20)
        menuButton.leftAnchor.align(to: view.leftAnchor, offset: 10)
        menuButton.heightAnchor.equal(to: size)
        menuButton.widthAnchor.equal(to: size)
        
        searchButton.topAnchor.align(to: view.topAnchor, offset: 20)
        searchButton.rightAnchor.align(to: view.rightAnchor, offset: -10)
        searchButton.heightAnchor.equal(to: size)
        searchButton.widthAnchor.equal(to: size)
        
        titleLabel.topAnchor.align(to: menuButton.bottomAnchor, offset: 15)
        titleLabel.leftAnchor.align(to: view.leftAnchor, offset: 20)
        titleLabel.heightAnchor.equal(to: size)
        titleLabel.widthAnchor.equal(to: 150)
        
        filterButton.topAnchor.align(to: searchButton.bottomAnchor, offset: 15)
        filterButton.rightAnchor.align(to: view.rightAnchor, offset: -20)
        filterButton.heightAnchor.equal(to: size)
        filterButton.widthAnchor.equal(to: 80)
        
        tableView.topAnchor.align(to: titleLabel.bottomAnchor, offset: 10)
        tableView.leftAnchor.align(to: view.leftAnchor, offset: 20)
        tableView.rightAnchor.align(to: view.rightAnchor, offset: -20)
        tableView.bottomAnchor.align(to: view.bottomAnchor, offset: -60)
    }
}

extension SportVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return popoverItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.textLabel?.font = UIFont.systemFont(ofSize: 14)
        cell.textLabel?.text = popoverItems[indexPath.item]
        cell.textLabel?.textColor = .white
        cell.backgroundColor = #colorLiteral(red: 0.1977315053, green: 0.2017299144, blue: 0.262745098, alpha: 1)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //let item = popoverItems[indexPath.item]
        
        self.popover.dismiss()
    }
}



