//
//  CVSDetailViewTests.swift
//  CVSCodingProject
//
//  Created by Marco Gloria on 17/03/25.
//

import XCTest
import SwiftUI
@testable import CVSCodingProject
import SnapshotTesting

class CVSDetailViewTests: XCTestCase {
    let flickImage = FlickrImage(title: "Star Wars Character in Nome",
                                 link: "https://www.flickr.com/photos/jdory/54392212798/",
                                 media: ["m":"https://live.staticflickr.com/65535/54392212798_c8f4f1c014_m.jpg"],
                                 date_taken: "2025-03-14T14:49:17-08:00",
                                 description: " <p><a href=\"https://www.flickr.com/people/jdory/\">hunky</a> posted a photo:</p> <p><a href=\"https://www.flickr.com/photos/jdory/54392212798/\" title=\"Star Wars Character in Nome\"><img src=\"https://live.staticflickr.com/65535/54392212798_c8f4f1c014_m.jpg\" width=\"240\" height=\"239\" alt=\"Star Wars Character in Nome\" /></a></p> <p>Porcupine</p> ",
                                 published: "2025-03-17T06:42:19Z",
                                 author: "nobody@flickr.com (\"hunky\")",
                                 modified: nil,
                                 author_id: "65651666@N00",
                                 tags: "porcupine")
    func testDetailView() throws {
        let detailView = DetailView(flickrImage: flickImage)
        let view: UIView = UIHostingController(rootView: detailView).view
        assertSnapshot(of: view, as: .image(size: view.intrinsicContentSize))
    }

}
