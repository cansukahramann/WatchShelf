//
//  VideoView.swift
//  WatchShelf
//
//  Created by Cansu Kahraman on 8.10.2024.
//

import UIKit
import WebKit

class VideoView: UIView {
    
    let webView: WKWebView = {
        let prefs = WKWebpagePreferences()
        prefs.allowsContentJavaScript = true
        let configuration = WKWebViewConfiguration()
        configuration.defaultWebpagePreferences = prefs
        let webView = WKWebView(frame: .zero,configuration: configuration)
        webView.translatesAutoresizingMaskIntoConstraints = false
        return webView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupVideoView()
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //
    //    func getVideo(videoCode: String) {
    //        let url = URL(string: "https://www.youtube.com/watch?v=\(videoCode)")
    //        webView.load(URLRequest(url: url!))
    //    }
    
    func getVideo(videoCode: String) {
        let embedHTML = """
                <html>
                <body style="margin:0px;padding:0px;overflow:hidden;">
                <iframe width="100%" height="100%" src="https://www.youtube.com/embed/\(videoCode)?playsinline=1" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
                </body>
                </html>
                """
        webView.loadHTMLString(embedHTML, baseURL: nil)}
    
    func setupVideoView() {
        addSubview(webView)
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: topAnchor),
            webView.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 12),
            webView.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -12),
            webView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
