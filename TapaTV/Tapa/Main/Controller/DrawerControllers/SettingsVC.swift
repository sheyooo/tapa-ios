//
//  SettingsVC.swift
//  TapaTV
//
//  Created by SimpuMind on 5/8/18.
//  Copyright © 2018 SimpuMind. All rights reserved.
//

import UIKit

class SettingsVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let items = ["Caption", "Save Videos", "Terms Of Use/Privacy Policy"]
    
    private lazy var tableView: UITableView = {
       let tv = UITableView()
        tv.backgroundColor = .clear
        tv.separatorColor = UIColor(white: 0.3, alpha: 0.5)
        tv.delegate = self
        tv.dataSource = self
        tv.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tv.register(SettingsCustomCell.self, forCellReuseIdentifier: "customCell")
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = primaryColor
        
        navigationItem.title = "SETTINGS"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        
        view.addSubview(tableView)
        
        tableView.sizeToFit()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        DispatchQueue.main.async {
            self.tableView.sizeToFit()
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.topAnchor.align(to: view.topAnchor, offset: 74)
        tableView.bottomAnchor.align(to: view.bottomAnchor)
        tableView.leftAnchor.align(to: view.leftAnchor)
        tableView.rightAnchor.align(to: view.rightAnchor)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = items[indexPath.item]
        if indexPath.item == 0 || indexPath.item == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! SettingsCustomCell
            cell.index = indexPath.item
            cell.titleLabel.text = item
            cell.backgroundColor = .clear
            cell.selectionStyle = .none
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel?.text = item
            cell.backgroundColor = .clear
            cell.textLabel?.textColor = .white
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}


class SettingsCustomCell: UITableViewCell {
    
    var index = 0
    
    public lazy var titleLabel: UILabel = {
       let label = UILabel()
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var switchButton: UISwitch = {
       let sw = UISwitch()
        //sw.tintColor = darkPrimaryColor
        sw.translatesAutoresizingMaskIntoConstraints = false
        return sw
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        [titleLabel, switchButton].forEach {addSubview($0)}
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        titleLabel.topAnchor.align(to: topAnchor)
        titleLabel.bottomAnchor.align(to: bottomAnchor)
        titleLabel.leftAnchor.align(to: leftAnchor, offset: 20)
        titleLabel.widthAnchor.equal(to: 250)
        
        switchButton.centerYAnchor.align(to: centerYAnchor)
        switchButton.heightAnchor.equal(to: 30)
        switchButton.rightAnchor.align(to: rightAnchor, offset: -20)
        switchButton.widthAnchor.equal(to: 60)
    }
}
