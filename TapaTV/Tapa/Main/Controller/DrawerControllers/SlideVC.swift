//
//  SlideVC.swift
//  TapaTV
//
//  Created by SimpuMind on 5/8/18.
//  Copyright © 2018 SimpuMind. All rights reserved.
//

import UIKit

class SlideVC: UITableViewController {

    let menuTitles = ["MY ACCOUNT", "SETTINGS", "FAQs", "SIGN OUT"]
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        let orientation: UIInterfaceOrientationMask = [UIInterfaceOrientationMask.all]
        return orientation
    }
    
    override var shouldAutorotate: Bool{
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.1977315053, green: 0.2017299144, blue: 0.262745098, alpha: 1)
        tableView.separatorStyle = .none
        self.automaticallyAdjustsScrollViewInsets = false
        tableView.register(CustomCell.self, forCellReuseIdentifier: "cell")
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return menuTitles.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomCell
        cell.textLabel?.text = menuTitles[indexPath.item]
        cell.textLabel?.textColor = .white
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let backButtonItem = UIBarButtonItem()
        backButtonItem.title = ""
        backButtonItem.tintColor = .white
        navigationItem.backBarButtonItem = backButtonItem
        switch indexPath.item {
        case 0:
            let vc = ProfileVC()
            vc.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(vc, animated: true)
            break
        case 1:
            let vc = SettingsVC()
            vc.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(vc, animated: true)
            break
        case 2:
            break
        case 3:
            ApiService.shared.logout()
            break
        default:
            print("default")
        }
    }
}
