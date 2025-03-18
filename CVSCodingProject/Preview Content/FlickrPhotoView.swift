//
//  FlickrPhotoView.swift
//  CVSCodingProject
//
//  Created by Marco Gloria on 17/03/25.
//

import SwiftUI
struct FlickrPhotoView: View {
    @EnvironmentObject var networkManager: NetworkManager
    @State var selection: String? = nil
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        VStack {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(networkManager.flickrImages, id: \.link) { photoRow in
                        if let media = photoRow.media, let url = media["m"], let mediaURL = URL(string: url) {
                            NavigationLink(destination: DetailView(flickrImage: photoRow)) {
                                AsyncImage(url: mediaURL) { image in
                                    //image.resizable()
                                    image.aspectRatio(contentMode: .fit)
                                } placeholder: {
                                    ProgressView()
                                }
                                .frame(width: 160, height: 160)
                            }
                        }
                    }
                }
                .padding(.horizontal)
            }
        }
    }
}
