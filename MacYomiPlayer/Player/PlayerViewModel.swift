//
//  PlayerViewModel.swift
//  YomiPlayer
//
//  Created by Kuanysh Yabekov on 25.07.2025.
//

import AVKit

class PlayerViewModel: ObservableObject {

    let player: AVPlayer
    
    init(fileName: String) {
        let url = Bundle.main.url(forResource: fileName, withExtension: "mp4")
        self.player = AVPlayer(playerItem: AVPlayerItem(url: url!))
        self.play()
    }
    
    func play() {
        let currentItem = player.currentItem
        if currentItem?.currentTime() == currentItem?.duration {
            currentItem?.seek(to: .zero, completionHandler: nil)
        }
        
        player.play()
    }
    
    func pause() {
        player.pause()
    }
    
}
