//
//  SettingView.swift
//  AudioPlayer
//
//  Created by Amit Kumar on 23/11/2023.
//

import SwiftUI

struct SettingView: View {
    @Binding var isMockDataEnabled: Bool
    @ObservedObject var playerViewModel: PlayerViewModel
    var body: some View {
        VStack {
            Form {
                Toggle(AudioPlayerConstants.mockDataTitle, isOn: $isMockDataEnabled)
                    .onChange(of: isMockDataEnabled) { newValue in
                        playerViewModel.isMock =  isMockDataEnabled
                        playerViewModel.selectedSoundTrack.deviceID = -1
                    }
            }
        }
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        let isMockDataEnabled = State(initialValue: true)
        SettingView(isMockDataEnabled: isMockDataEnabled.projectedValue, playerViewModel: PlayerViewModel())
    }
}
