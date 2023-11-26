//
//  FooterMusicPlayer.swift
//  AudioPlayer
//
//  Created by Amit Kumar on 24/11/2023.
//

import SwiftUI

struct NowPlayingView: View {
    @ObservedObject var playerViewModel: PlayerViewModel
    @State private var imageData: UIImage?
    private let imageDownloader: ImageDownloading
    @State private var currentProgress: CGFloat = 0.5
    
//    inject the dependency through the initializer and  used a protocol to represent the dependency.
    init(playerViewModel: PlayerViewModel,
         imageDownloader: ImageDownloading = ImageDownloader.shared) {
          self.playerViewModel = playerViewModel
          self.imageDownloader = imageDownloader
    }

    var body: some View {
        VStack{
            HStack(alignment: .top) {
                Image(uiImage: imageData ?? .placeholder)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 50, height: 50)
                    .cornerRadius(AudioPlayerConstants.defaultCornerRadius)
                    .overlay(
                        RoundedRectangle(cornerRadius: AudioPlayerConstants.defaultCornerRadius)
                            .stroke(Color.black, lineWidth: 1)
                    )
                    
                VStack(alignment: .leading, spacing: 5.0) {
                    Text(playerViewModel.selectedSoundTrack.trackName)
                        .fontWeight(.bold)
                        .font(.subheadline)
                    HStack {
                        Text(playerViewModel.selectedSoundTrack.deviceName ?? "")
                            .font(.footnote)
                            .foregroundColor(.black)
                    }
                }
                Spacer()
                HStack {
                    Image(uiImage: playerViewModel.isPlaying ? .pauseSmall : .playSmall)
                        .onTapGesture {
                            playerViewModel.isPlaying = !playerViewModel.isPlaying
                        }
                    Image(uiImage: .next)
                }

            }
            ProgressBar(progress: $currentProgress)
            Spacer(minLength: 5)
        }
        .padding()
        .background(Color.lightGray)
        .onReceive(playerViewModel.$selectedSoundTrack) { _ in
            Task {
                self.imageData = await playerViewModel.getImage()
            }
        }
    }
}

 struct FooterMusicPlayer_Previews: PreviewProvider {
    static var previews: some View {
        let model = PlayerViewModel()
        model.selectedSoundTrack = PlayingData(deviceID: 0, deviceName: "Living Rooms", artWorkSmall: "https://skyegloup-eula.s3.amazonaws.com/heos_app/code_test/artist2.jpg", artWorkLarge: "https://skyegloup-eula.s3.amazonaws.com/heos_app/code_test/artist2.jpg", trackName: "Down To The Waterline", artistName: "Dire Straights" )
       return NowPlayingView(playerViewModel: model)
    }
 }
