//
//  MockCloudDataProvider.swift
//  AudioPlayerTests
//
//  Created by Amit Kumar on 25/11/2023.
//

import XCTest

class MockCloudDataProvider: DataProvider {
    var fetchDeviceDataCalled = false
    var playerData: [PlayingData]?
    var deviceResponse: Device.Response?
    var error: Error?

    init(playerData: [PlayingData]? = nil, deviceResponse: Device.Response? = nil, error: Error? = nil) {
        self.playerData = playerData
        self.deviceResponse = deviceResponse
        self.error = error
    }

    func fetchDeviceData(completion: @escaping ([PlayingData]?, Device.Response?, Error?) -> Void) {
        fetchDeviceDataCalled = true

        // Simulate asynchronous behavior by dispatching to the main queue after a short delay
        DispatchQueue.global().async {
            completion(self.playerData, self.deviceResponse, self.error)
        }
    }
}
