//
//  UIImage+Extensions.swift
//  AudioPlayer
//
//  Created by Amit Kumar on 24/11/2023.
//

import UIKit
extension UIImage {
    
    // Play- pause icons
    static var playSmall : UIImage { self ["now_playing_controls_play_small"]}
    static var pauseSmall: UIImage { self ["now_playing_controls_pause_small"]}
    static var playLarge : UIImage { self ["now_playing_controls_play"]}
    static var pauseLarge: UIImage { self ["now_playing_controls_pause"]}
    
    static var placeholder: UIImage { self ["placeholder"]}
    
    // Music icons
    static var musicPlay: UIImage { self ["music_play"]}
    static var previous: UIImage { self ["previous"]}
    static var next: UIImage { self ["next"]}
    static var repeatIcon: UIImage { self ["repeat"]}
    static var shuffle: UIImage { self ["shuffle"]}
    static var volume: UIImage { self ["medium_volume"]}
}

extension UIImage {
    private static subscript(name: String) -> UIImage {
        guard let image = UIImage(named: name) else {
            fatalError("Failed to load image \(name)")
        }
        return image
    }
    
}

