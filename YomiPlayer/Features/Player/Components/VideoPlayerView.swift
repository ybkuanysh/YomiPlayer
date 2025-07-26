//
//  PlayerView.swift
//  YomiPlayer
//
//  Created by Kuanysh Yabekov on 25.07.2025.
//

import AVKit
import UIKit

class VideoPlayerView: UIView {

    var player: AVPlayer? {
        get { playerLayer.player }
        set { playerLayer.player = newValue }
    }

    var playerLayer: AVPlayerLayer {
        return layer as! AVPlayerLayer
    }
    
    init(player: AVPlayer) {
        super.init(frame: .zero)
        self.player = player
        
//        playerLayer.contentsGravity = .center
//        playerLayer.videoGravity = .center
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Override UIView property
    override static var layerClass: AnyClass {
        return AVPlayerLayer.self
    }
}
