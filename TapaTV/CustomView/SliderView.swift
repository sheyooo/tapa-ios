//
//  SliderView.swift
//  TapaTV
//
//  Created by SimpuMind on 5/7/18.
//  Copyright © 2018 SimpuMind. All rights reserved.
//

import UIKit

class SliderView: UIView {
    
    let menuTitles = ["MY ACCOUNT", "SETTINGS", "FAQs", "SIGN OUT"]
    
    var tableView: UITableView = {
        let tv = UITableView()
        tv.backgroundColor = .clear
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = #colorLiteral(red: 0.2, green: 0.2039215686, blue: 0.262745098, alpha: 0.6297891695)
        addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        tableView.fill(self)
    }
}

extension SliderView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuTitles.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = menuTitles[indexPath.item]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let vc = UserMediaVC()
//        let item = menuImages[indexPath.item]
//        if item == "audio" || item == "video"{
//            vc.mediaType = item
//            navigationController?.pushViewController(vc, animated: true)
//        }
//        dismiss(animated: true, completion: nil)
    }
    
}
