//
//  DetailView.swift
//  CVSCodingProject
//
//  Created by Marco Gloria on 17/03/25.
//

import Combine
import Foundation
import SwiftUI

public struct DetailView: View {
    @State var flickrImage: FlickrImage
    
    public var body: some View {
        VStack (alignment: .center) {
            if let title = flickrImage.title, let desc = flickrImage.description, let author = flickrImage.author, let creationDate = flickrImage.date_taken {
                Text(title)
                Spacer()
                HStack(alignment: .center, spacing: 10) {
                    Spacer()
                    if let media = flickrImage.media, let url = media["m"], let mediaURL = URL(string: url) {
                        AsyncImage(url: mediaURL) { image in
                            //image.resizable()
                            image.aspectRatio(contentMode: .fit)
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(width: 300, height: 300)
                    }
                    Spacer()
                }
                Text("Author: " + author)
                Spacer()
                Text("Description: " + desc.htmlToString(desc))
                Spacer()
                Text("Date: " + creationDate.stringToDate(creationDate))
                Spacer()
            }
        }
    }
}
