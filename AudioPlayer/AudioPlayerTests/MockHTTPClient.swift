//
//  MockHTTPClient.swift
//  AudioPlayerTests
//
//  Created by Amit Kumar on 25/11/2023.
//

import XCTest

// Mock Endpoint for testing
struct MockEndpoint: Endpoint {
    var scheme: String = "https"
    var host: String = "example.com"
    var path: String = "/test"
    var method: RequestMethod = .get
    var header: [String : String]? = nil
    var body: [String : String]? = nil
}

class MockHTTPClient: HTTPClient {
    var data: Data?
    var response: URLResponse?
    var error: Error?

    func sendRequest<T: Decodable>(endpoint: Endpoint, responseModel: T.Type) async throws -> Result<T, RequestError> {
        // Simulate an asynchronous request

        if error != nil {
            throw RequestError.unknown
        }

        guard let data = data else {
            throw RequestError.noResponse
        }

        do {
            let decodedResponse = try JSONDecoder().decode(responseModel, from: data)
            return .success(decodedResponse)
        } catch {
            return .failure(RequestError.decode)
        }
    }
}
