//
//  ContentView.swift
//  CVSCodingProject
//
//  Created by Marco Gloria on 17/03/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack {
                SearchView()
                FlickrPhotoView()
            }
            .navigationBarTitle(Text("Flickr Pics"))
        }
    }
}

#Preview {
    ContentView()
}
