//
//  RoomView.swift
//  AudioPlayer
//
//  Created by Amit Kumar on 23/11/2023.
//

import SwiftUI

struct RoomView: View {
    var device: PlayingData
    @State private var imageData: UIImage?
    @ObservedObject var playerViewModel: PlayerViewModel
    // NSCache for image caching
    private static let imageCache = NSCache<NSString, NSData>()
    
    var body: some View {
        HStack(alignment: .top) {
            artworkIcon
            VStack(alignment: .leading) {
                deviceNameTitle
                HStack {
                    devicePlayPauseIcon
                    deviceDetails
                }
            }
        }
        .frame(minHeight: AudioPlayerConstants.roomCellHeight)
        .task {
            do {
                if let url = URL(string: device.artWorkSmall) {
                    let data = try await ImageDownloader.shared.downloadImage(from:url, isMockData: playerViewModel.isMock)
                    self.imageData =  data
                }
            } catch {
                Logger.log(.error,"Error: \(error.localizedDescription)")
            }
        }
    }
}

extension RoomView {
    private var artworkIcon: some View {
        Image(uiImage: imageData ?? .placeholder)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: AudioPlayerConstants.smallIconWidth, height: AudioPlayerConstants.smallIconHeight)
            .cornerRadius(AudioPlayerConstants.defaultCornerRadius)
            .overlay(
                RoundedRectangle(cornerRadius: AudioPlayerConstants.defaultCornerRadius)
                    .stroke(Color.black, lineWidth: 1)
            )
    }

    private var deviceNameTitle: some View {
        Text(device.deviceName ?? "")
            .fontWeight(.bold)
            .font(.subheadline)
            .foregroundColor((device.deviceID == $playerViewModel.selectedSoundTrack.deviceID.wrappedValue ) ? .white : .black)
    }

    private var devicePlayPauseIcon: some View {
        Image(uiImage: (device.deviceID == $playerViewModel.selectedSoundTrack.deviceID.wrappedValue) && $playerViewModel.isPlaying.wrappedValue ? .musicPlay : .playSmall)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 14, height: 14)
    }

    private var deviceDetails: some View {
        Text("\(device.trackName), \(device.artistName)")
            .font(.footnote)
            .foregroundColor((device.deviceID == $playerViewModel.selectedSoundTrack.deviceID.wrappedValue ) ? .white : .black)
    }
}

struct RoomView_Previews: PreviewProvider {
    static var previews: some View {
        let playerViewModel = PlayerViewModel()
        RoomView(device: playerViewModel.selectedSoundTrack, playerViewModel: playerViewModel)
    }
}

