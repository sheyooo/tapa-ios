//
//  ViewController.swift
//  TapaTV
//
//  Created by SimpuMind on 3/15/18.
//  Copyright © 2018 SimpuMind. All rights reserved.
//

import UIKit
import Player
 
let videoUrl = "https://storage.googleapis.com/tapa-media/15105908389871182860_645949058749535_50973_n.mp4"

class StreamTvVC: UIViewController {

    fileprivate var player: IPlayerView = {
       let player = IPlayerView()
        player.translatesAutoresizingMaskIntoConstraints = false
        return player
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(player)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        constrainViews()
    }

    private func constrainViews(){
        
        player.topAnchor.align(to: view.topAnchor)
        player.leftAnchor.align(to: view.leftAnchor)
        player.rightAnchor.align(to: view.rightAnchor)
        player.bottomAnchor.align(to: view.bottomAnchor)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.player.playVideo(videoURL: videoUrl)
    }
    
}
