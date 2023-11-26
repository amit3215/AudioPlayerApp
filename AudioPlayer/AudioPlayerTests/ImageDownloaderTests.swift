//
//  ImageDownloaderTests.swift
//  AudioPlayerTests
//
//  Created by Amit Kumar on 26/11/2023.
//

import XCTest

final class ImageDownloaderTests: XCTestCase {

    let mockImageData = Data() // Your mock image data
      let mockImageURL = URL(string: "https://example.com/mockImage.jpg")!

      // Test downloading mock image data
      func testDownloadImageWithMockData() async {
          do {
              let imageDownloader = ImageDownloader.shared
              let image = try await imageDownloader.downloadImage(from: mockImageURL, isMockData: true)
              XCTAssertNotNil(image, "Downloaded image should not be nil")
          } catch {
              XCTFail("Error downloading image: \(error)")
          }
      }
    
    // Test downloading image data
     func testDownloadImageData() async {
         do {
             let imageDownloader = ImageDownloader.shared
             let imageData = try await imageDownloader.downloadImageData(from: mockImageURL)
             XCTAssertNotNil(imageData, "Downloaded image data should not be nil")
         } catch {
             XCTFail("Error downloading image data: \(error)")
         }
     }
}
