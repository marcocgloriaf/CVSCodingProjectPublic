//
//  NetworkManager.swift
//  CVSCodingProject
//
//  Created by Marco Gloria on 17/03/25.
//

import Combine
import Foundation
import SwiftUICore

/// This extension is copyright of Hacking with swift website
extension URLSession {
    func decode<T: Decodable>(
        _ type: T.Type = T.self,
        from url: URL,
        keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy = .useDefaultKeys,
        dataDecodingStrategy: JSONDecoder.DataDecodingStrategy = .deferredToData,
        dateDecodingStrategy: JSONDecoder.DateDecodingStrategy = .deferredToDate
    ) async throws  -> T {
        let (data, _) = try await data(from: url)

        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = keyDecodingStrategy
        decoder.dataDecodingStrategy = dataDecodingStrategy
        decoder.dateDecodingStrategy = dateDecodingStrategy

        let decoded = try decoder.decode(T.self, from: data)
        return decoded
    }
}

struct FlickrImage : Codable, Hashable {
    let title: String?
    let link: String?
    let media: [String: String]?
    let date_taken: String?
    let description: String?
    let published: String?
    let author: String?
    let modified: String?
    let author_id: String?
    let tags: String?

    
    func hash(into hasher: inout Hasher) {
        hasher.combine(link)
    } 
}

struct FickrImages: Codable, Hashable {
    static func == (lhs: FickrImages, rhs: FickrImages) -> Bool {
        lhs.link == rhs.link
    }
    
    //let id: Int
    let title: String?
    let link: String?
    let description: String?
    let modified: String?
    let items: [FlickrImage]?
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(link)
    }
}

class NetworkManager: ObservableObject {
    @Published var netManagerError: Error?
    @Published var flickrImages: [FlickrImage] = []
    var seearchState: SearchViewState
    let baseURL = "https://api.flickr.com/services/feeds/photos_public.gne?format=json&nojsoncallback=1&tags="
    private var cancellables = Set<AnyCancellable>()
    
    init (_ searchState: SearchViewState) {
        self.seearchState = searchState
        self.seearchState.$tag
            .debounce(for: .milliseconds(200), scheduler: DispatchQueue.main)
            .removeDuplicates()
            .sink { searchText in
                self.loadData(searchText)
            }
            .store(in: &cancellables)
    }
    
    func loadData(_ tags: String) {
        Task {
            let flickrImages = await getImages(seearchState.tag) ?? []
            updateImages(flickrImages)
        }
    }
    
    func updateImages(_ newImages: [FlickrImage]) {
        
        Task {
            await MainActor.run {
                self.flickrImages.removeAll()
                self.flickrImages = newImages
            }
        }
    }
    
    func getImages(_ tags: String) async -> [FlickrImage]? {
        do {
            let urlString = baseURL + tags
            guard let url = URL(string: urlString) else {
                fatalError("Invalid URL: \(urlString)")
            }
            
            // Create a custom URLSession and decode a Double array from that
            let config = URLSessionConfiguration.default
            config.requestCachePolicy = .reloadIgnoringLocalAndRemoteCacheData
            let session = URLSession(configuration: config)
            
            let flickrImages = try await session.decode(FickrImages.self, from: url)
            return flickrImages.items
            
        } catch {
            //handle error
            print("error in reading countries ")
            print("Download error: \(error.localizedDescription)")
            netManagerError = error
        }
        return nil
    }
}
