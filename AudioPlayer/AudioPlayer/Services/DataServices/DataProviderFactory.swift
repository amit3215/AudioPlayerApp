//
//  DataProviderFactory.swift
//  AudioPlayer
//
//  Created by Amit Kumar on 25/11/2023.
//

import Foundation

class DataProviderFactory {
    static func getDataProvider(isMock: Bool) -> DataProvider {
        return isMock ? MockDataProvider() : CloudDataProvider()
    }
}
