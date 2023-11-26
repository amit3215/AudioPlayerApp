//
//  MockDataProviderForTest.swift
//  AudioPlayerTests
//
//  Created by Amit Kumar on 25/11/2023.
//

import XCTest

// Mock implementation of DataProvider for testing
class MockDataProviderForTest: DataProvider {
    var fetchDeviceDataCalled = false
    
    func fetchDeviceData(completion: @escaping ([PlayingData]?, Device.Response?, Error?) -> Void) {
        fetchDeviceDataCalled = true
        let playerResponse = JSONLoader.loadJSON(fileName: "Player", fileType: "json", modelType: Player.Response.self)
        let devicesData = JSONLoader.loadJSON(fileName: "Devices", fileType: "json", modelType: Device.Response.self)
        completion(playerResponse?.nowPlaying, devicesData, nil)
    }
}
