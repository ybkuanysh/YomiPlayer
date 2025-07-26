//
//  PlayerView.swift
//  YomiPlayer
//
//  Created by Kuanysh Yabekov on 25.07.2025.
//

import AVKit
import AppKit

class PlayerView: NSView {

//    var player: AVPlayer? {
//        get { playerLayer.player }
//        set { playerLayer.player = newValue }
//    }
//
//    var playerLayer: AVPlayerLayer {
//        return layer as! AVPlayerLayer
//    }
//    
//    init(player: AVPlayer) {
//        super.init(frame: .zero)
//        self.player = player
//        
//        playerLayer.contentsGravity = .resize
//        playerLayer.videoGravity = .resize
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    var player: AVPlayer? {
        get { (layer as? AVPlayerLayer)?.player }
        set { (layer as? AVPlayerLayer)?.player = newValue }
    }

    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        setupLayer()
    }

    convenience init(player: AVPlayer) {
        self.init(frame: .zero)
        self.player = player
    }

    required init?(coder decoder: NSCoder) {
        super.init(coder: decoder)
        setupLayer()
    }

    private func setupLayer() {
        wantsLayer = true
        let playerLayer = AVPlayerLayer()
        playerLayer.videoGravity = .resizeAspect // или .resize, если нужно
        layer = playerLayer
    }
    
}
