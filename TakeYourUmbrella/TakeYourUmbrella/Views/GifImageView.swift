//
//  GifImageView.swift
//  TakeYourUmbrella
//
//  Created by Anna on 25.03.2024.
//

import SwiftUI
import WebKit

struct GifImageView: UIViewRepresentable {
    
    private let gifName: String
    
    init(gifName: String) {
        self.gifName = gifName
    }
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        let url = Bundle.main.url(forResource: gifName, withExtension: "gif")!
        let data = try! Data(contentsOf: url)
        
        webView.load(data,
                     mimeType: "image/gif",
                     characterEncodingName: "UTF-8",
                     baseURL: url.deletingLastPathComponent())
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.reload()
    }
}

struct GifImageView_Previews: PreviewProvider {
    static var previews: some View {
        GifImageView(gifName: "water")
    }
}
