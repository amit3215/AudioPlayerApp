//
//  ContentView.swift
//  AudioPlayer
//
//  Created by Amit Kumar on 23/11/2023.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedTab = 0
    @State private var isMockDataEnabled = false
    @State private var isAudioPlaying = false
    @ObservedObject private var playerViewModel = PlayerViewModel()
    
    var body: some View {
        TabView(selection: $selectedTab) {
            roomsTabView
            playerTabView
            settingsTabView            
        }
        .accentColor(.red)
    }
}

extension ContentView {
    private var roomsTabView: some View {
        RoomsView(isMockDataEnabled: $isMockDataEnabled, playerViewModel: playerViewModel)
            .tabItem {
                Label(AudioPlayerConstants.roomsTitle, image: AudioPlayerConstants.roomsTabImage)
            }
            .onTapGesture {
                selectedTab = 0
            }
            .tag(0)
    }
    
    private var playerTabView: some View {
        PlayerView(playerViewModel: playerViewModel)
            .tabItem {
                Label(AudioPlayerConstants.playerTitle, image: AudioPlayerConstants.playingTabImage)
            } .onTapGesture {
                selectedTab = 1
            }
            .tag(1)
    }
    
    private var settingsTabView: some View {
        SettingView(isMockDataEnabled: $isMockDataEnabled, playerViewModel: playerViewModel)
            .tabItem {
                Label(AudioPlayerConstants.settingTitle, image: AudioPlayerConstants.settingsTabImage)
            }
            .onTapGesture {
                selectedTab = 2
            }
            .tag(2)
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
