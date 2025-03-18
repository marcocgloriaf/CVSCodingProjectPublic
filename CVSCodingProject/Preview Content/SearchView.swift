//
//  SearchView.swift
//  CVSCodingProject
//
//  Created by Marco Gloria on 17/03/25.
//

import Combine
import Foundation
import SwiftUI

public struct SearchView: View {
    @EnvironmentObject var searchState: SearchViewState
    public var body: some View {
        SearchBar(text: self.$searchState.searchText, placeholder: "Enter a category...")
            .onAppear(perform: {
            
        })
    }
}
