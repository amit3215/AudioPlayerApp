//
//  PlayerView.swift
//  AudioPlayer
//
//  Created by Amit Kumar on 23/11/2023.
//

import SwiftUI

struct PlayerView: View {
    @State private var imageData: UIImage?
    @State private var  imageArray = [UIImage.repeatIcon , UIImage.previous, UIImage.playSmall , UIImage.next, UIImage.shuffle]
    @ObservedObject var playerViewModel: PlayerViewModel
    @State private var currentProgress: CGFloat = 0.5
    var body: some View {
        VStack {
            thisPhoneTitle
            artworkIcon
            ProgressBar(progress: $currentProgress)
            trackNameTitle
            artistNameTitle
            musicPlayerIcons
            volumeIcons
            Spacer(minLength: 30)
            deviceNameTitle
            Spacer(minLength: 30)
        }
        .padding(EdgeInsets(top: 30, leading: 20, bottom: 0, trailing: 25))
        .task {
            Task {
                self.imageData = await playerViewModel.getImage()
            }
        }
    }
}

extension PlayerView {
    private var thisPhoneTitle: some View {
        Text(AudioPlayerConstants.thisPhoneTitle)
            .font(.system(size: 25, weight: .bold))
    }

    private var artworkIcon: some View {
        Image(uiImage: imageData ?? .placeholder)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: AudioPlayerConstants.largeIconWidth, height: AudioPlayerConstants.largeIconHeight)
            .cornerRadius(AudioPlayerConstants.defaultCornerRadius)
            .overlay(
                RoundedRectangle(cornerRadius: AudioPlayerConstants.defaultCornerRadius)
                    .stroke(Color.black, lineWidth: 1)
            )
    }

    private var trackNameTitle: some View {
        Text(playerViewModel.selectedSoundTrack.trackName)
            .font(.system(size: 16, weight: .bold))
    }

    private var artistNameTitle: some View {
        Text(playerViewModel.selectedSoundTrack.artistName)
            .font(.caption)
            .padding(.bottom, 50)
    }
    
    private var musicPlayerIcons: some View {
        HStack(alignment: .top, spacing: 30) {
            ForEach(0..<imageArray.count, id: \.self) { index in
                Image(uiImage: playerViewModel.getImage(index: index, array: self.imageArray)) // Replace with your image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: AudioPlayerConstants.musicPlayerIconWidth, height: AudioPlayerConstants.musicPlayerIconHeight)
                    .padding(.horizontal, 5)
                    .onTapGesture {
                        if index == 2 {
                            playerViewModel.isPlaying = !playerViewModel.isPlaying
                        }
                    }
            }
        }
        .padding(.bottom, 25)
    }
    
    private var volumeIcons: some View {
        HStack(alignment: .center, spacing: 10) {
            Image(uiImage: .volume)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: AudioPlayerConstants.musicPlayerIconWidth, height: AudioPlayerConstants.musicPlayerIconHeight)
                .padding(.horizontal, 5)
            ProgressBar(progress: $currentProgress)
        }
        .frame(height: 20)
    }
    
    private var deviceNameTitle: some View {
        Text(playerViewModel.selectedSoundTrack.deviceName ?? "")
            .font(.system(size: 15, weight: .bold))
            .foregroundColor(.gray)
    }
}

struct PlayerView_Previews: PreviewProvider {
    static var previews: some View {
        let model = PlayerViewModel()
        model.selectedSoundTrack = PlayingData(deviceID: 0, deviceName: "Living Rooms", artWorkSmall: "https://skyegloup-eula.s3.amazonaws.com/heos_app/code_test/artist2.jpg", artWorkLarge: "https://skyegloup-eula.s3.amazonaws.com/heos_app/code_test/artist2.jpg", trackName: "Down To The Waterline", artistName: "Dire Straights" )
        return PlayerView(playerViewModel: model)
    }
}
