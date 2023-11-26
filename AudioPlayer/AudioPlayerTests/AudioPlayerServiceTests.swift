//
//  AudioPlayerServiceTests.swift
//  AudioPlayerTests
//
//  Created by Amit Kumar on 25/11/2023.
//

import XCTest

final class AudioPlayerServiceTests: XCTestCase {
    let playerResponseMock = JSONLoader.loadJSON(fileName: "Player", fileType: "json", modelType: Player.Response.self)
    let devicesDataMock = JSONLoader.loadJSON(fileName: "Devices", fileType: "json", modelType: Device.Response.self)

    func testFetchDeviceDataFromMock() {
        let mockDataProvider = MockDataProviderForTest()
        let expectation = XCTestExpectation(description: "Fetch device data from mock")
        
        mockDataProvider.fetchDeviceData { playingData, deviceResponse, error in
            XCTAssertTrue(mockDataProvider.fetchDeviceDataCalled)
            XCTAssertNotNil(playingData)
            XCTAssertNotNil(deviceResponse)
            XCTAssertNil(error)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testFetchDeviceData() {
        let mockError = NSError(domain: "MockErrorDomain", code: 123, userInfo: nil)
        let mockDataProvider = MockCloudDataProvider(playerData: playerResponseMock?.nowPlaying, deviceResponse: devicesDataMock, error: mockError)

            // Act
            var capturedError: Error?

            let expectation = XCTestExpectation(description: "Fetch device data in mock provider")

            mockDataProvider.fetchDeviceData { playingData, deviceResponse, error in
                XCTAssertTrue(mockDataProvider.fetchDeviceDataCalled)
                capturedError = error
                expectation.fulfill()
            }

            // Assert
            wait(for: [expectation], timeout: 5.0)

            XCTAssertTrue(mockDataProvider.fetchDeviceDataCalled)
            XCTAssertEqual(capturedError as NSError?, mockError)
        }
}






