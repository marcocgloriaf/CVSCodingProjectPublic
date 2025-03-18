//
//  SearchViewState.swift
//  CVSCodingProject
//
//  Created by Marco Gloria on 17/03/25.
//

import Combine
import Foundation
import SwiftUI

class SearchViewState: ObservableObject {
    @Published var searchText: String = "porcupine"
    @Published var tag: String = ""
    
    private var dispoables = Set<AnyCancellable>()
    
    init() {
        self.$searchText
            .debounce(for: .milliseconds(50), scheduler: DispatchQueue.main)
            .removeDuplicates()
            .sink { searchText in
                self.tag = searchText
            }
            .store(in: &dispoables)
    }
}
