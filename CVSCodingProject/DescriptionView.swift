//
//  DescriptionView.swift
//  CVSCodingProject
//
//  Created by Marco Gloria on 17/03/25.
//

import WebKit
import SwiftUI

struct DescriptionView: UIViewRepresentable {
    let htmlContent: String

    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.loadHTMLString(htmlContent, baseURL: nil)
    }
}
