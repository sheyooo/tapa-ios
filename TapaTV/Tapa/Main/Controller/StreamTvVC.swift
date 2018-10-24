//
//  ViewController.swift
//  TapaTV
//
//  Created by SimpuMind on 3/15/18.
//  Copyright © 2018 SimpuMind. All rights reserved.
//

import UIKit
import VersaPlayer
import AVFoundation
import NVActivityIndicatorView


class StreamTvVC: UIViewController {

    var video: Video?
    
    
    private lazy var player: VersaPlayer = {
        let view = VersaPlayer()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(player)
        view.fill(player)
        
        guard let urlString = video?.videoUrl else {return}
        if let url = URL.init(string: urlString) {
            let item = VPlayerItem(url: url)
            player.set(item: item)
        }
    }
}

