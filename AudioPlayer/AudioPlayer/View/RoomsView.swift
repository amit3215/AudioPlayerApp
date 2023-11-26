//
//  RoomsView.swift
//  AudioPlayer
//
//  Created by Amit Kumar on 23/11/2023.
//

import SwiftUI
import Foundation

struct RoomsView: View {
    @Binding var isMockDataEnabled: Bool
    @ObservedObject var playerViewModel: PlayerViewModel
    @StateObject var viewModel: RoomsViewModel = RoomsViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(viewModel.devices, id: \.deviceID) { device in
                        RoomView(device: device, playerViewModel: playerViewModel)
                            .onTapGesture {
                                playerViewModel.selectedSoundTrack = device
                            }
                            .listRowBackground(playerViewModel.selectedSoundTrack.deviceID == device.deviceID ? Color.darkGray : Color.lightGray)
                    }
                }
                .listStyle(GroupedListStyle())
                .padding(.leading, AudioPlayerConstants.defaultPadding)
                .padding(.trailing, AudioPlayerConstants.defaultPadding)
                .navigationBarTitle(AudioPlayerConstants.roomsTitle, displayMode: .large)
                
                Spacer()
                
                if playerViewModel.selectedSoundTrack.deviceID != -1 {
                    NowPlayingView(playerViewModel: playerViewModel)
                        .frame(height: AudioPlayerConstants.roomCellHeight)
                }
                
                Spacer()
            }
        }
        .onReceive(playerViewModel.$isMock) { newName in
            viewModel.fetchDeviceData(isMockDataEnabled: $isMockDataEnabled.wrappedValue)
        }
    }
}

struct RoomsView_Previews: PreviewProvider {
    static var previews: some View {
        let isMockDataEnabled = State(initialValue: true)
        let model = PlayerViewModel()
        model.selectedSoundTrack = PlayingData(deviceID: 0, deviceName: "Living Rooms", artWorkSmall: "https://skyegloup-eula.s3.amazonaws.com/heos_app/code_test/artist2.jpg", artWorkLarge: "https://skyegloup-eula.s3.amazonaws.com/heos_app/code_test/artist2.jpg", trackName: "Down To The Waterline", artistName: "Dire Straights" )
        return RoomsView(isMockDataEnabled: isMockDataEnabled.projectedValue, playerViewModel: model)
    }
}
