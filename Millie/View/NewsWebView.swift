//
//  WKWebViewWrapper.swift
//  Millie
//
//  Created by DK on 5/23/24.
//

import SwiftUI
import WebKit

struct NewsWebView: UIViewRepresentable {
    
    var url: URL

    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        let request = URLRequest(url: url)
        uiView.load(request)
    }
}
