//
//  HTTPClientTests.swift
//  AudioPlayerTests
//
//  Created by Amit Kumar on 25/11/2023.
//

import XCTest

class HTTPClientTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    func testSendRequestSuccess() async {
        let mockHTTPClient = MockHTTPClient()
        mockHTTPClient.data = """
               {
                 "Devices": [
                   {
                     "ID": 1,
                     "Name": "Nick Jonas"
                   },
                   {
                     "ID": 2,
                     "Name": "Beyoncee"
                   }
                 ]
               }
           """.data(using: .utf8)

        let endpoint = MockEndpoint(
            scheme: "https",
            host: "example.com",
            path: "/api/data",
            method: .get,
            header: ["Authorization": "Bearer token"],
            body: nil
        )
        do {
            let result: Result<Device.Response, RequestError> = try await mockHTTPClient.sendRequest(endpoint: endpoint, responseModel: Device.Response.self)
            switch result {
            case .success(let response):
                // Assert that the devices are decoded correctly
                XCTAssertEqual(response.Devices.count, 2)
                XCTAssertEqual(response.Devices[0].ID, 1)
                XCTAssertEqual(response.Devices[0].Name, "Nick Jonas")
                XCTAssertEqual(response.Devices[1].ID, 2)
                XCTAssertEqual(response.Devices[1].Name, "Beyoncee")
            case .failure:
                XCTFail("Request should not fail")
            }
        } catch {
            XCTFail("Error thrown: \(error)")
        }
        
    }
    
    func testSendRequestFailureDecoding() async {
        let expectation = XCTestExpectation(description: "Request should fail decoding")
        
        let mockHTTPClient = MockHTTPClient()
        // Provide invalid JSON data to simulate a decoding failure
        mockHTTPClient.data = "Invalid JSON".data(using: .utf8)
        
        let endpoint = MockEndpoint(
            scheme: "https",
            host: "example.com",
            path: "/api/data",
            method: .get,
            header: ["Authorization": "Bearer token"],
            body: nil
        )
        
        do {
            let result: Result<Device.Response, RequestError> = try await mockHTTPClient.sendRequest(endpoint: endpoint, responseModel: Device.Response.self)
            switch result {
            case .success:
                XCTFail("Request should fail decoding, but it succeeded")
            case .failure(let error):
                // Add assertions or log the error for debugging
                XCTAssertEqual(error, .decode, "Unexpected error type")
                expectation.fulfill()
            }
        } catch {
            XCTFail("Error thrown: \(error)")
        }
    
        await XCTWaiter().fulfillment(of: [expectation], timeout: 5.0)
    }

    func testSendRequestSuccessfullyDecodesNowPlaying() async {
        let expectation = XCTestExpectation(description: "Request completes successfully")

        let mockHTTPClient = MockHTTPClient()
        mockHTTPClient.data = """
            {
              "Now Playing": [
                {
                  "Device ID": 1,
                  "Artwork Small": "https://skyegloup-eula.s3.amazonaws.com/heos_app/code_test/artist1.jpg",
                  "Artwork Large": "https://skyegloup-eula.s3.amazonaws.com/heos_app/code_test/artist1.jpg",
                  "Track Name": "Welcome To The Jungle",
                  "Artist Name": "Guns N' Roses"
                },
                {
                  "Device ID": 2,
                  "Artwork Small": "https://skyegloup-eula.s3.amazonaws.com/heos_app/code_test/artist2.jpg",
                  "Artwork Large": "https://skyegloup-eula.s3.amazonaws.com/heos_app/code_test/artist2.jpg",
                  "Track Name": "Down To The Waterline",
                  "Artist Name": "Dire Straights"
                }
              ]
            }
        """.data(using: .utf8)

        let endpoint = MockEndpoint(
            scheme: "https",
            host: "example.com",
            path: "/api/nowplaying",
            method: .get,
            header: ["Authorization": "Bearer token"],
            body: nil
        )

        do {
            let result: Result<Player.Response, RequestError> = try await mockHTTPClient.sendRequest(endpoint: endpoint, responseModel: Player.Response.self)
            switch result {
            case .success(let response):
                // Your assertions here
                XCTAssertEqual(response.nowPlaying.count, 2)
                XCTAssertEqual(response.nowPlaying[0].deviceID, 1)
                XCTAssertEqual(response.nowPlaying[0].trackName, "Welcome To The Jungle")
                XCTAssertEqual(response.nowPlaying[1].deviceID, 2)
                XCTAssertEqual(response.nowPlaying[1].trackName, "Down To The Waterline")

                // Fulfill the expectation when the assertions are successful
                expectation.fulfill()
            case .failure(let error):
                XCTFail("Request should not fail with error: \(error)")
            }
        } catch {
            XCTFail("Error thrown: \(error)")
        }

        // Wait for the expectation with a timeout
        await XCTWaiter().fulfillment(of: [expectation], timeout: 5.0)
    }
    
}
