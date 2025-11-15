//
//  File.swift
//  VideoPlayer
//
//  Created by Kuanysh Yabekov on 07.11.2025.
//

import AVFoundation

extension CMTime {
    public func formatted() -> String {
        if self.isIndefinite {
            return "--:--".uppercased()
        }
        let seconds: Int = Int(self.seconds)
        let formattedSeconds = seconds % 60
        let minutes = seconds / 60
        let hours = minutes / 60
        
        if hours > 0 {
            return String(format: "%02d:%02d:%02d", hours, minutes, formattedSeconds)
        }
        return String(format: "%02d:%02d", minutes, formattedSeconds)
    }
}
