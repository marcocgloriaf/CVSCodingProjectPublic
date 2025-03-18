//
//  CVSCodingProjectApp.swift
//  CVSCodingProject
//
//  Created by Marco Gloria on 17/03/25.
//

import SwiftUI

@main
struct CVSCodingProjectApp: App {
    var networkManager = NetworkManager(SearchViewState())
    
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(networkManager).environmentObject(networkManager.seearchState)
        }
    }
}
