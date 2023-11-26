//
//  DataProvider.swift
//  AudioPlayer
//
//  Created by Amit Kumar on 23/11/2023.
//

import Foundation

// Protocol for data provider
protocol DataProvider {
    func fetchDeviceData(completion: @escaping ([PlayingData]?, Device.Response?, Error?) -> Void)
}

// Implement the protocol for actual and mock data providers
struct CloudDataProvider: DataProvider {
    private let service: AudioPlayerDataService = .init()

    func fetchDeviceData(completion: @escaping ([PlayingData]?,  Device.Response?, Error?) -> Void) {
        // Fetch data from the cloud
        self.fetchPlayerData { playingData, deviceResponse, error   in
            completion(playingData, deviceResponse, error)
        }
    }
    
    //  Player and Devcie API cal in sequence to send data to View model to get final model 

    private func fetchPlayerData(completion: @escaping ([PlayingData]?, Device.Response?, Error?) -> Void) {
        Task(priority: .background) {
            var playerResponse: [PlayingData]?
            var deviceResponse: Device.Response?
            var errorValue: Error?
            // 1: API to get Audio Player data
            let resultPlayerAPI = await service.getPlayerData()
            switch resultPlayerAPI {
            case .success( let response):
                playerResponse =  response.nowPlaying
            case .failure(let error):
                errorValue = error
            }
            // 2: API to get Device Data  data
            
            let resultDeviceAPI = await service.getDeviceData()
            switch resultDeviceAPI {
            case .success( let response):
                deviceResponse = response
            case .failure(let error):
                errorValue = error
            }
            completion(playerResponse, deviceResponse, errorValue)
        }
    }

}

struct MockDataProvider: DataProvider {
    func fetchDeviceData(completion: @escaping ([PlayingData]?, Device.Response?, Error?) -> Void) {
        let playerResponse = JSONLoader.loadJSON(fileName: "Player", fileType: "json", modelType: Player.Response.self)
        let devicesData = JSONLoader.loadJSON(fileName: "Devices", fileType: "json", modelType: Device.Response.self)
        completion(playerResponse?.nowPlaying, devicesData, NSError())
    }
}
