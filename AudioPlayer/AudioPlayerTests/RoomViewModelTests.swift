//
//  RoomViewModelTests.swift
//  AudioPlayerTests
//
//  Created by Amit Kumar on 25/11/2023.
//

import XCTest
import XCTest

final class RoomViewModelTests: XCTestCase {

    func testFetchDeviceDataInRoomsViewModel() {
        let playerResponseMock = JSONLoader.loadJSON(fileName: "Player", fileType: "json", modelType: Player.Response.self)
        let devicesDataMock = JSONLoader.loadJSON(fileName: "Devices", fileType: "json", modelType: Device.Response.self)

        let viewModel = RoomsViewModel()
        let expectation = XCTestExpectation(description: "Fetch device data in view model")

        viewModel.fetchDeviceData(isMockDataEnabled: true)

        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            XCTAssertFalse(viewModel.devices.isEmpty)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 5.0)
    }

}
