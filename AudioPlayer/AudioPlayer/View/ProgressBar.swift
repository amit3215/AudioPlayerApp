//
//  ProgressBar.swift
//  AudioPlayer
//
//  Created by Amit Kumar on 24/11/2023.
//

import SwiftUI

struct ProgressBar: View {
    @Binding var progress: CGFloat
    
    init(progress: Binding<CGFloat>) {
        _progress = progress
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle()
                    .frame(width: geometry.size.width, height: 1)
                    .opacity(0.3)
                    .foregroundColor(Color.gray)
                
                Rectangle()
                    .frame(width: min(self.progress * geometry.size.width, geometry.size.width), height: 2)
                    .foregroundColor(Color.black)
            }
        }
        .padding(.top, AudioPlayerConstants.defaultPadding)
    }
}


struct ProgressBar_Previews: PreviewProvider {
    static var previews: some View {
        ProgressBar(progress: .constant(0.5))
    }
}
