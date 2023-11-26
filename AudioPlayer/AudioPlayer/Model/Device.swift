//
//  Device.swift
//  AudioPlayer
//
//  Created by Amit Kumar on 23/11/2023.
//

import Foundation

struct Device: Codable {

    struct Response: Codable {
        var Devices: [DeviceData]
    }
    
    struct DeviceData: Codable {
        var ID: Int
        var Name: String
    }
}
