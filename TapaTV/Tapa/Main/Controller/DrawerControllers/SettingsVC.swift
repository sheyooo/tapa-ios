//
//  SettingsVC.swift
//  TapaTV
//
//  Created by SimpuMind on 5/8/18.
//  Copyright © 2018 SimpuMind. All rights reserved.
//

import UIKit

class SettingsVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = primaryColor
        
        navigationItem.title = "SETTINGS"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
    }

}
