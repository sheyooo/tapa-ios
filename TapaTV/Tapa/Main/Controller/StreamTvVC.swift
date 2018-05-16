//
//  ViewController.swift
//  TapaTV
//
//  Created by SimpuMind on 3/15/18.
//  Copyright © 2018 SimpuMind. All rights reserved.
//

import UIKit
import Player
import BMPlayer
import AVFoundation
import NVActivityIndicatorView

func delay(_ seconds: Double, completion:@escaping ()->()) {
    let popTime = DispatchTime.now() + Double(Int64( Double(NSEC_PER_SEC) * seconds )) / Double(NSEC_PER_SEC)
    
    DispatchQueue.main.asyncAfter(deadline: popTime) {
        completion()
    }
}
class StreamTvVC: UIViewController {

    var video: Video?
    
    
    var player: BMPlayer!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupPlayerManager()
        preparePlayer()
        setupPlayerResource()
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(applicationDidEnterBackground),
                                               name: NSNotification.Name.UIApplicationDidEnterBackground,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(applicationWillEnterForeground),
                                               name: NSNotification.Name.UIApplicationWillEnterForeground,
                                               object: nil)
        
        player.backBlock = { [unowned self] (isFullScreen) in
            if isFullScreen == true {
                self.handleDismiss()
                return
            }
            let _ = self.navigationController?.popViewController(animated: true)
        }
    }
    
    @objc private func handleDismiss(){
        dismiss(animated: true, completion: nil)
    }
    
    @objc func applicationWillEnterForeground() {
        
    }
    
    @objc func applicationDidEnterBackground() {
        player.pause(allowAutoPlay: false)
    }
    
    /**
     prepare playerView
     */
    func preparePlayer() {
        let controller = BMPlayerCustomControlView()
        
        player = BMPlayer(customControlView: controller)
        view.addSubview(player)
        
        player.snp.makeConstraints { (make) in
            make.top.equalTo(view.snp.top)
            make.left.equalTo(view.snp.left)
            make.right.equalTo(view.snp.right)
            make.bottom.equalTo(view.safeArea.bottom)
            //make.height.equalTo(view.snp.width).multipliedBy(9.0/16.0).priority(500)
        }
        
        player.delegate = self
        player.backBlock = { [unowned self] (isFullScreen) in
            if isFullScreen {
                self.handleDismiss()
                return
            } else {
                let _ = self.navigationController?.popViewController(animated: true)
            }
        }
        
        self.view.layoutIfNeeded()
    }
    
    
    func setupPlayerResource() {
        guard let video = video else {
            navigationController?.popViewController(animated: true)
            return
        }
        player.videoGravity = AVLayerVideoGravity.resizeAspect
        let url = URL(string: video.videoUrl)!
        
        
        let asset = BMPlayerResource(name: video.title,
                                     definitions: [BMPlayerResourceDefinition(url: url, definition: "480p")],
                                     cover: nil,
                                     subtitles: nil)
        
        player.setVideo(resource: asset)

    }
    
    // 设置播放器单例，修改属性
    func setupPlayerManager() {
        resetPlayerManager()
        BMPlayerConf.topBarShowInCase = .horizantalOnly
    }
    
    func resetPlayerManager() {
        BMPlayerConf.allowLog = false
        BMPlayerConf.shouldAutoPlay = true
        BMPlayerConf.tintColor = UIColor.white
        BMPlayerConf.topBarShowInCase = .horizantalOnly
        BMPlayerConf.loaderType  = NVActivityIndicatorType.ballRotateChase
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        UIApplication.shared.statusBarStyle = .lightContent
        player.pause(allowAutoPlay: true)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)

        navigationController?.navigationBar.shadowImage = UIImage()
        
        UIApplication.shared.statusBarStyle = .lightContent
        player.autoPlay()
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // Or to rotate and lock
        // AppUtility.lockOrientation(.portrait, andRotateTo: .portrait)
        
    }
    
    deinit {
        // If use the slide to back, remember to call this method
        // 使用手势返回的时候，调用下面方法手动销毁
        player.prepareToDealloc()
        print("VideoPlayViewController Deinit")
    }
    
}

// MARK:- BMPlayerDelegate example
extension StreamTvVC: BMPlayerDelegate {
    // Call when player orinet changed
    func bmPlayer(player: BMPlayer, playerOrientChanged isFullscreen: Bool) {
        
        player.snp.remakeConstraints { (make) in
            make.top.equalTo(view.snp.top)
            make.left.equalTo(view.snp.left)
            make.right.equalTo(view.snp.right)
            if isFullscreen {
                self.navigationController?.setNavigationBarHidden(true, animated: true)
                make.bottom.equalTo(view.safeArea.bottom)
            } else {
                make.height.equalTo(view.snp.width).multipliedBy(9.0/16.0).priority(500)
            }
        }
    }
    
    // Call back when playing state changed, use to detect is playing or not
    func bmPlayer(player: BMPlayer, playerIsPlaying playing: Bool) {
        print("| BMPlayerDelegate | playerIsPlaying | playing - \(playing)")
    }
    
    // Call back when playing state changed, use to detect specefic state like buffering, bufferfinished
    func bmPlayer(player: BMPlayer, playerStateDidChange state: BMPlayerState) {
        print("| BMPlayerDelegate | playerStateDidChange | state - \(state)")
    }
    
    // Call back when play time change
    func bmPlayer(player: BMPlayer, playTimeDidChange currentTime: TimeInterval, totalTime: TimeInterval) {
        //        print("| BMPlayerDelegate | playTimeDidChange | \(currentTime) of \(totalTime)")
    }
    
    // Call back when the video loaded duration changed
    func bmPlayer(player: BMPlayer, loadedTimeDidChange loadedDuration: TimeInterval, totalDuration: TimeInterval) {
        //        print("| BMPlayerDelegate | loadedTimeDidChange | \(loadedDuration) of \(totalDuration)")
    }
}

class BMPlayerCustomControlView: BMPlayerControlView {
    
    var playbackRateButton = UIButton(type: .custom)
    var playRate: Float = 1.0
    
    var rotateButton = UIButton(type: .custom)
    var rotateCount: CGFloat = 0
    
    /**
     Override if need to customize UI components
     */
    override func customizeUIComponents() {
        mainMaskView.backgroundColor   = UIColor.clear
        topMaskView.backgroundColor    = UIColor.black.withAlphaComponent(0.4)
        bottomMaskView.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        timeSlider.setThumbImage(UIImage(named: "custom_slider_thumb"), for: .normal)
        
        topMaskView.addSubview(playbackRateButton)
        
        playbackRateButton.layer.cornerRadius = 2
        playbackRateButton.layer.borderWidth  = 1
        playbackRateButton.layer.borderColor  = UIColor ( red: 1.0, green: 1.0, blue: 1.0, alpha: 0.8 ).cgColor
        playbackRateButton.setTitleColor(UIColor ( red: 1.0, green: 1.0, blue: 1.0, alpha: 0.9 ), for: .normal)
        playbackRateButton.setTitle("  rate \(playRate)  ", for: .normal)
        playbackRateButton.addTarget(self, action: #selector(onPlaybackRateButtonPressed), for: .touchUpInside)
        playbackRateButton.titleLabel?.font   = UIFont.systemFont(ofSize: 12)
        playbackRateButton.isHidden = true
        playbackRateButton.snp.makeConstraints {
            $0.right.equalTo(chooseDefitionView.snp.left).offset(-5)
            $0.centerY.equalTo(chooseDefitionView)
        }
        
        topMaskView.addSubview(rotateButton)
        rotateButton.layer.cornerRadius = 2
        rotateButton.layer.borderWidth  = 1
        rotateButton.layer.borderColor  = UIColor ( red: 1.0, green: 1.0, blue: 1.0, alpha: 0.8 ).cgColor
        rotateButton.setTitleColor(UIColor ( red: 1.0, green: 1.0, blue: 1.0, alpha: 0.9 ), for: .normal)
        rotateButton.setTitle("  rotate  ", for: .normal)
        rotateButton.addTarget(self, action: #selector(onRotateButtonPressed), for: .touchUpInside)
        rotateButton.titleLabel?.font   = UIFont.systemFont(ofSize: 12)
        rotateButton.isHidden = true
        rotateButton.snp.makeConstraints {
            $0.right.equalTo(playbackRateButton.snp.left).offset(-5)
            $0.centerY.equalTo(chooseDefitionView)
        }
        
        fullscreenButton.isHidden = true
    }
    
    
    
    override func updateUI(_ isForFullScreen: Bool) {
        super.updateUI(isForFullScreen)
        playbackRateButton.isHidden = !isForFullScreen
        rotateButton.isHidden = !isForFullScreen
        if let layer = player?.playerLayer {
            layer.frame = player!.bounds
        }
    }
    
    override func controlViewAnimation(isShow: Bool) {
        self.isMaskShowing = isShow
        UIApplication.shared.setStatusBarHidden(!isShow, with: .fade)
        
        UIView.animate(withDuration: 0.24, animations: {
            self.topMaskView.snp.remakeConstraints {
                $0.top.equalTo(self.mainMaskView).offset(isShow ? 0 : -65)
                $0.left.right.equalTo(self.mainMaskView)
                $0.height.equalTo(65)
            }
            
            self.bottomMaskView.snp.remakeConstraints {
                $0.bottom.equalTo(self.mainMaskView).offset(isShow ? 0 : 50)
                $0.left.right.equalTo(self.mainMaskView)
                $0.height.equalTo(50)
            }
            self.layoutIfNeeded()
        }) { (_) in
            self.autoFadeOutControlViewWithAnimation()
        }
    }
    
    @objc func onPlaybackRateButtonPressed() {
        autoFadeOutControlViewWithAnimation()
        switch playRate {
        case 1.0:
            playRate = 1.5
        case 1.5:
            playRate = 0.5
        case 0.5:
            playRate = 1.0
        default:
            playRate = 1.0
        }
        playbackRateButton.setTitle("  rate \(playRate)  ", for: .normal)
        delegate?.controlView?(controlView: self, didChangeVideoPlaybackRate: playRate)
    }
    
    
    
    @objc func onRotateButtonPressed() {
        guard let layer = player?.playerLayer else {
            return
        }
        print("rotated")
        rotateCount += 1
        layer.transform = CGAffineTransform(rotationAngle: rotateCount * CGFloat(Double.pi/2))
        layer.frame = player!.bounds
    }
}

