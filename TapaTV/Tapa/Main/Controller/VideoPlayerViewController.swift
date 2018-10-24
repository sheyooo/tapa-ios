//
//  VideoPlayerViewController.swift
//  TapaTV
//
//  Created by SimpuMind on 10/23/18.
//  Copyright © 2018 SimpuMind. All rights reserved.
//

import UIKit
import VersaPlayer
import DateToolsSwift

class VideoPlayerViewController: UIViewController {

    @IBOutlet weak var player: VersaPlayer!
    @IBOutlet var control: VersaPlayerControls!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    var video: Video?

    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.font = UIFont(name: "Avenir-Black", size: 22)
        timeLabel.font = UIFont(name: "Avenir", size: 14)
        player.autoplay = true
        player.use(controls: control)
        guard let video = video else {return}
        titleLabel.text = video.title.uppercased()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        dateFormatter.locale = Locale.current
        if let date = dateFormatter.date(from: video.createdAt) {
            timeLabel.text = date.timeAgoSinceNow
        }
        
        if let url = URL.init(string: "http://www.exit109.com/~dnn/clips/RW20seconds_2.mp4") {
            let item = VPlayerItem(url: url)
            player.set(item: item)
        }
    }
    
    
    @IBAction func handleDismiss(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
