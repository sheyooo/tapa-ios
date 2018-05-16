//
//  IPlayerView.swift
//  TapaTV
//
//  Created by SimpuMind on 3/15/18.
//  Copyright © 2018 SimpuMind. All rights reserved.
//

import UIKit
import Player
import AVFoundation

protocol IPlayerViewDelegate {
    
}

class IPlayerView: UIView {
    
    var sliderValue: Double = 0
    
    fileprivate var activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge)
    fileprivate var muteBtn = UIButton(type: UIButtonType.custom)
    fileprivate var player = Player()
    //var delegate: IPlayerViewDelegate? = nil
    
    deinit {
        self.player.view.removeFromSuperview()
        self.player.removeFromParentViewController()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        print(frame)
        setupIPlayer()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupIPlayer()
    }
    
    open func playVideo(videoURL: String){
        self.player.url = URL(string: videoURL)
        self.player.playbackLoops = true
        self.player.playFromBeginning()
        activityIndicator.startAnimating()
    }
    
    open func stopVideo(){
        self.player.stop()
        self.player.url = nil
    }
    
    private lazy var currentTimeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .left
        label.text = "00:00"
        label.font = UIFont(name: "Arial-BoldMT", size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var trackDurationLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = "00:00"
        label.textAlignment = .right
        label.font = UIFont(name: "Arial-BoldMT", size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var seekbarView: UISlider = {
        let seek = UISlider()
        seek.thumbTintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.2957245291)
        seek.tintColor =  #colorLiteral(red: 0.3215686275, green: 0.5450980392, blue: 1, alpha: 1)
        seek.setThumbImage(#imageLiteral(resourceName: "fill_circle").maskWithColor(color: #colorLiteral(red: 0.3215686275, green: 0.5450980392, blue: 1, alpha: 1)), for: .normal)
        seek.addTarget(self, action: #selector(handleSliderChange), for: .touchUpInside)
        seek.translatesAutoresizingMaskIntoConstraints = false
        return seek
    }()
    
    private lazy var playButton: UIButton = {
        let iv = UIButton()
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    private lazy var impressionView: UIView = {
        let iv = UIView()
        iv.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.2069777397)
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    private func setupIPlayer(){
        setupPlayerView()
        setupActivityIndicator()
        setupImpressionView()
        setupButton()
        setupPlayButton()
        setupCurrentTime()
        setupDurationTime()
        setupSeekBar()
        let tapGestureRecognizer: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTapGestureRecognizer(_:)))
        tapGestureRecognizer.numberOfTapsRequired = 1
        self.player.view.addGestureRecognizer(tapGestureRecognizer)
    }
    
    //sideSpacing is space of UIView from its right + left sides of superview
    //width = UIScreen.main.bounds.width when using square view
    private func setupPlayerView(){
        let sideSpacing: CGFloat = 0.0
        self.frame = CGRect(x: 0.0, y: 0.0, width: UIScreen.main.bounds.width - sideSpacing, height: UIScreen.main.bounds.width - sideSpacing)
        self.player.playerDelegate = self
        self.player.playbackDelegate = self
        self.player.view.translatesAutoresizingMaskIntoConstraints = false
        self.player.view.clipsToBounds = true
        player.fillMode = PlayerFillMode.resizeAspectFill.avFoundationType
        player.layerBackgroundColor = UIColor.white
        self.addSubview(self.player.view)
        self.player.view.topAnchor.align(to: self.topAnchor)
        self.player.view.leftAnchor.align(to: self.leftAnchor)
        self.player.view.rightAnchor.align(to: self.rightAnchor)
        self.player.view.bottomAnchor.align(to: self.bottomAnchor)
    }
    
    private func setupButton(){
        muteBtn.setImage(#imageLiteral(resourceName: "unMuteSpeaker.png").maskWithColor(color: UIColor.white), for: .normal)
        muteBtn.setImage(#imageLiteral(resourceName: "muteSpeaker.png").maskWithColor(color: UIColor.white), for: .selected)
        muteBtn.frame = CGRect(x: 15.0, y: player.view.frame.maxY - 33.0, width: 25.0, height: 25.0)
        muteBtn.addTarget(self, action: #selector(self.muteAction(_:)), for: .touchUpInside)
        self.addSubview(muteBtn)
    }
    
    private func setupImpressionView(){
        self.addSubview(impressionView)
        impressionView.heightAnchor.equal(to: 44)
        impressionView.leftAnchor.align(to: self.leftAnchor)
        impressionView.rightAnchor.align(to: self.rightAnchor)
        impressionView.bottomAnchor.align(to: self.bottomAnchor)
    }
    
    private func setupPlayButton(){
        playButton.setImage(#imageLiteral(resourceName: "ic_pause").maskWithColor(color: UIColor.white), for: .normal)
        playButton.setImage(#imageLiteral(resourceName: "ic_play").maskWithColor(color: UIColor.white), for: .selected)
        playButton.addTarget(self, action: #selector(self.pausePlayAction(_:)), for: .touchUpInside)
        
        self.addSubview(playButton)
        playButton.bottomAnchor.align(to: impressionView.bottomAnchor, offset: 0)
        playButton.leftAnchor.align(to: muteBtn.rightAnchor, offset: 30)
        playButton.widthAnchor.equal(to: 40)
        playButton.heightAnchor.equal(to: 40)
    }
    
    private func setupActivityIndicator(){
        activityIndicator.color = #colorLiteral(red: 0.3215686275, green: 0.5450980392, blue: 1, alpha: 1)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(activityIndicator)
        activityIndicator.centerXAnchor.align(to: self.centerXAnchor)
        activityIndicator.centerYAnchor.align(to: self.centerYAnchor)
        activityIndicator.widthAnchor.equal(to: 40)
        activityIndicator.heightAnchor.equal(to: 40)
    }
    
    private func setupCurrentTime(){
        self.addSubview(currentTimeLabel)
        currentTimeLabel.bottomAnchor.align(to: impressionView.bottomAnchor, offset: -13)
        currentTimeLabel.leftAnchor.align(to: playButton.rightAnchor, offset: 20)
        currentTimeLabel.widthAnchor.equal(to: 70)
        currentTimeLabel.heightAnchor.equal(to: 14)
    }
    
    private func setupDurationTime() {
        self.addSubview(trackDurationLabel)
        trackDurationLabel.bottomAnchor.align(to: impressionView.bottomAnchor, offset: -13)
        trackDurationLabel.rightAnchor.align(to: impressionView.rightAnchor, offset: -30)
        trackDurationLabel.widthAnchor.equal(to: 70)
        trackDurationLabel.heightAnchor.equal(to: 14)
    }
    
    private func setupSeekBar(){
        self.addSubview(seekbarView)
        seekbarView.leftAnchor.align(to: currentTimeLabel.rightAnchor, offset: 20)
        seekbarView.rightAnchor.align(to: trackDurationLabel.leftAnchor, offset: -20)
        seekbarView.bottomAnchor.align(to: impressionView.bottomAnchor, offset: -15)
        seekbarView.heightAnchor.equal(to: 10)
    }
    private func hideImpression(){
        self.impressionView.isHidden = !self.impressionView.isHidden
        self.muteBtn.isHidden = !self.muteBtn.isHidden
        self.playButton.isHidden = !self.playButton.isHidden
        self.currentTimeLabel.isHidden = !self.currentTimeLabel.isHidden
        self.seekbarView.isHidden = !self.seekbarView.isHidden
        self.trackDurationLabel.isHidden = !self.trackDurationLabel.isHidden
    }
    
    @objc private func handleSliderChange() {
        let time = CMTimeMake(Int64(seekbarView.value), 1)
        player.seek(to: time)
    }
    
    @objc private func muteAction(_ sender: UIButton) {
        sender.isSelected = sender.isSelected ? false:true
        player.muted = sender.isSelected
    }
    
    @objc private func pausePlayAction(_ sender: UIButton) {
        sender.isSelected = sender.isSelected ? false : true
        switch (self.player.playbackState.rawValue) {
        case PlaybackState.stopped.rawValue:
            self.player.playFromBeginning()
            break
        case PlaybackState.paused.rawValue:
            self.player.playFromCurrentTime()
            break
        case PlaybackState.playing.rawValue:
            self.player.pause()
            break
        case PlaybackState.failed.rawValue:
            self.player.pause()
            break
        default:
            self.player.pause()
            break
        }

    }
    
    open func setButtonRect(x: CGFloat?, y: CGFloat?, width: CGFloat?, height: CGFloat?){
        muteBtn.frame = CGRect(x: x ?? 8.0, y: y ?? player.view.frame.maxY - 38.0, width: width ?? 30.0, height: height ?? 30.0)
    }
    
    open func setButtonImages(defaultImage: UIImage, selectedImage: UIImage){
        muteBtn.setImage(defaultImage, for: .normal)
        muteBtn.setImage(selectedImage, for: .selected)
    }
    
    
}

// MARK: - UIGestureRecognizer

extension IPlayerView {
    
    @objc func handleTapGestureRecognizer(_ gestureRecognizer: UITapGestureRecognizer) {
        self.hideImpression()
//        switch (self.player.playbackState.rawValue) {
//        case PlaybackState.stopped.rawValue:
//            self.player.playFromBeginning()
//            break
//        case PlaybackState.paused.rawValue:
//            self.player.playFromCurrentTime()
//            break
//        case PlaybackState.playing.rawValue:
//            self.player.pause()
//            break
//        case PlaybackState.failed.rawValue:
//            self.player.pause()
//            break
//        default:
//            self.player.pause()
//            break
//        }
    }
    
}

extension IPlayerView:PlayerDelegate {
    
    func playerReady(_ player: Player) {
        seekbarView.maximumValue = Float(player.maximumDuration)
        let seconds = player.maximumDuration
        
        hmsFrom(seconds: Int(seconds)) { hours, minutes, seconds in
            
            let hours = self.getStringFrom(seconds: hours)
            let minutes = self.getStringFrom(seconds: minutes)
            let seconds = self.getStringFrom(seconds: seconds)
        
            self.trackDurationLabel.text = "\(hours):\(minutes):\(seconds)"
        }
    }
    
    func playerPlaybackStateDidChange(_ player: Player) {
        
    }
    
    func playerBufferingStateDidChange(_ player: Player) {
        if player.bufferingState == .ready {
            activityIndicator.stopAnimating()
            seekbarView.value = Float(player.currentTime)
        } else {
            activityIndicator.startAnimating()
        }
    }
    func playerBufferTimeDidChange(_ bufferTime: Double) {
        
    }
    
}

// MARK: - PlayerPlaybackDelegate

extension IPlayerView: PlayerPlaybackDelegate {
    
    func playerCurrentTimeDidChange(_ player: Player) {
        
        let fraction = Double(player.currentTime) / Double(player.maximumDuration)
    
        let seconds = player.currentTime
        let secondsString = String(format: "%02d", Int(seconds.truncatingRemainder(dividingBy: 60)))
        let minutesString = String(format: "%02d", Int(seconds / 60))
        let hoursString = String(format: "%02d", Int(seconds / 60))
        
        self.currentTimeLabel.text = "\(hoursString):\(minutesString):\(secondsString)"
        
        seekbarView.value = Float(player.currentTime)
        sliderValue = fraction
    }
    
    func playerPlaybackWillStartFromBeginning(_ player: Player) {
        self.setupButton()
    }
    
    func playerPlaybackDidEnd(_ player: Player) {
        self.playButton.setImage(#imageLiteral(resourceName: "ic_play").maskWithColor(color: UIColor.white), for: .normal)
    }
    
    func playerPlaybackWillLoop(_ player: Player) {
        self.seekbarView.value = 0.0
    }
    
    func hmsFrom(seconds: Int, completion: @escaping (_ hours: Int, _ minutes: Int, _ seconds: Int)->()) {
        
        completion(seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
        
    }
    
    func getStringFrom(seconds: Int) -> String {
        
        return seconds < 10 ? "0\(seconds)" : "\(seconds)"
    }
    
}

