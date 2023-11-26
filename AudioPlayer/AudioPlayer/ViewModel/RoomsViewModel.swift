//
//  RoomsViewModel.swift
//  AudioPlayer
//
//  Created by Amit Kumar on 23/11/2023.
//

import Foundation

class RoomsViewModel: ObservableObject {
    @Published var devices: [PlayingData] = []

    func fetchDeviceData(isMockDataEnabled: Bool) {
        DataProviderFactory.getDataProvider(isMock: isMockDataEnabled).fetchDeviceData { playdata, deviceData, error in
            if let playdata = playdata, let deviceData = deviceData {
                // Process playdata
                DispatchQueue.main.async {
                    let array = playdata.map { model in
                        var newModel = model
                        newModel.deviceName = deviceData.Devices.filter { $0.ID == model.deviceID}.first?.Name
                        return newModel
                    }
                    self.devices =  array
                }
            } else if let error = error {
                // Handle error
                Logger.log(.error, "Error: \(error.localizedDescription)")
            }
        }
    }
}

