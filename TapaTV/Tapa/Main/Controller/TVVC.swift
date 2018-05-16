//
//  TVVC.swift
//  TapaTV
//
//  Created by SimpuMind on 5/15/18.
//  Copyright © 2018 SimpuMind. All rights reserved.
//

import UIKit
import ZFPlayer

class TVVC: UIViewController {
    
    var video: Video?{
        didSet{
            self.setupPlayer()
            guard let video = video else {
                navigationController?.popViewController(animated: true)
                return
            }
            let url = URL(string: video.videoUrl)!
            let controller = ZFPlayerControlView()
            let playerModel = ZFPlayerModel()
            playerModel.fatherView = view
            playerModel.videoURL = url
            playerModel.title = video.title
            playerView.playerControlView(controller, playerModel: playerModel)
            playerView.autoPlayTheVideo()
        }
    }
    
    private lazy var playerView: ZFPlayerView = {
       let view = ZFPlayerView()
        view.delegate = self
        view.playerLayerGravity = ZFPlayerLayerGravity.resizeAspectFill
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //isLandscape = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
        isLandscape = false
    }
    
    private func setupPlayer(){
        view.addSubview(playerView)
        playerView.snp.makeConstraints { (make) in
            make.top.equalTo(self.view).offset(20)
            make.left.right.equalTo(self.view)
            // Here a 16:9 aspect ratio, can customize the video aspect ratio
            make.bottom.equalTo(view.snp.bottom)
        }
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }
}

extension TVVC: ZFPlayerDelegate {
    func zf_playerBackAction() {
        navigationController?.popViewController(animated: true)
    }
}

class NavigationController: UINavigationController {
    
    var shouldLandscape = false
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if shouldLandscape {
            let orientation: UIInterfaceOrientationMask = [UIInterfaceOrientationMask.landscape]
            return orientation
        }else{
            let orientation: UIInterfaceOrientationMask = [UIInterfaceOrientationMask.all]
            return orientation
        }
    }
    
    override var shouldAutorotate: Bool{
        return true
    }
    
}
