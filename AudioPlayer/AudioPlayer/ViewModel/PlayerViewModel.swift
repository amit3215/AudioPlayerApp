//
//  PlayerViewModel.swift
//  AudioPlayer
//
//  Created by Amit Kumar on 24/11/2023.
//

import Foundation
import UIKit

class PlayerViewModel: ObservableObject {
    @Published var artWorkLarge: [Data] = []
    var trackName = ""
    var artistName = ""
    @Published var isPlaying = true
    @Published var selectedSoundTrack = PlayingData(deviceID: -1, artWorkSmall: "", artWorkLarge: "", trackName: "", artistName: "")
    @Published var isMock = false
    
    func getImage() async -> UIImage {
        do {
            if let url = URL(string: self.selectedSoundTrack.artWorkSmall) {
                let data = try await ImageDownloader.shared.downloadImage(from: url, isMockData: self.isMock)
                return data
            }
        } catch {
            Logger.log(.error, "Error: \(error.localizedDescription)")
        }
        return .placeholder
    }
    
    func getImage(index: Int, array: [UIImage]) -> UIImage {
        if index == 2 {
            return self.isPlaying ? .pauseLarge : .playLarge
        } else {
            return array[index]
        }
        
    }
}
