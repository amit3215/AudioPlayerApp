//
//  PlayerViewModelTests.swift
//  AudioPlayerTests
//
//  Created by Amit Kumar on 26/11/2023.
//

import XCTest

final class PlayerViewModelTests: XCTestCase {
    
    func testGetImage() {
        let viewModel = PlayerViewModel()
        viewModel.selectedSoundTrack.artWorkSmall = "https://example.com/image.jpg"
        
        let expectation = expectation(description: "Async image download")
        
        Task {
            let image = await viewModel.getImage()
            XCTAssertNotNil(image, "Image should not be nil")
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testGetImageWithMockData() {
        let viewModel = PlayerViewModel()
        viewModel.selectedSoundTrack.artWorkSmall = "https://example.com/image.jpg"
        viewModel.isMock = true
        
        let expectation = expectation(description: "Async image download with mock data")
        
        Task {
            let image = await viewModel.getImage()
            XCTAssertNotNil(image, "Image should not be nil")
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testGetImageWithIndex2() {
        let viewModel = PlayerViewModel()
        let array: [UIImage] = [UIImage(named: "now_playing_controls_pause")!, UIImage(named: "now_playing_controls_pause")!]
        
        let resultImage = viewModel.getImage(index: 2, array: array)
        
        XCTAssertEqual(resultImage, .pauseLarge, "The result image should be .pauseLarge")
    }
    
    func testGetImageWithOtherIndex() {
        let viewModel = PlayerViewModel()
        let array: [UIImage] = [UIImage(named: "now_playing_controls_pause")!, UIImage(named: "now_playing_controls_pause")!]
        
        let resultImage = viewModel.getImage(index: 0, array: array)
        
        XCTAssertEqual(resultImage, array[0], "The result image should be the same as the one at the given index")
    }
    
}
