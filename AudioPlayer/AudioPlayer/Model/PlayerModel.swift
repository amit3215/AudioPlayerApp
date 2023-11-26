//
//  PlayerModel.swift
//  AudioPlayer
//
//  Created by Amit Kumar on 23/11/2023.
//

import Foundation

struct Player: Codable {
    struct Response : Codable {
        var nowPlaying: [PlayingData]
        private enum CodingKeys: String, CodingKey {
            case nowPlaying = "Now Playing"

        }
    }
}

struct PlayingData: Codable {
    var deviceID: Int
    var deviceName: String?
    var artWorkSmall: String
    var artWorkLarge: String
    var trackName: String
    var artistName: String
    
    private enum CodingKeys: String, CodingKey {
        case deviceID = "Device ID"
        case artWorkSmall = "Artwork Small"
        case artWorkLarge = "Artwork Large"
        case trackName = "Track Name"
        case artistName = "Artist Name"
    }
}
