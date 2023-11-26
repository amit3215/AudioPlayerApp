//
//  JSONLoader.swift
//  AudioPlayer
//
//  Created by Amit Kumar on 25/11/2023.
//

import Foundation

class JSONLoader {
    static func loadJSON<T: Decodable>(fileName: String, fileType: String, modelType: T.Type) -> T? {
        if let path = Bundle.main.path(forResource: fileName, ofType: fileType) {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let decoder = JSONDecoder()
                return try decoder.decode(T.self, from: data)
            } catch {
                // Handle error
                Logger.log(.error, "Error loading JSON: \(error)")
                return nil
            }
        }
        return nil
    }
}
