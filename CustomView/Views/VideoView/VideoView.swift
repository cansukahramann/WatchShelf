//
//  VideoView.swift
//  WatchShelf
//
//  Created by Cansu Kahraman on 8.10.2024.
//

import UIKit
import WebKit

class VideoView: UIView, WKNavigationDelegate {
    
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
        webView.navigationDelegate = self
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func getVideo(model: [MovieVideo]) {
        guard let firstModel = model.first else {
            print("Video not found")
            return
        }
        
        let url = URL(string: "https://www.youtube.com/embed/\(firstModel.key)")!
        webView.load(URLRequest(url: url))
        UIHelper.showHUD()
        
    }
    
    func setupVideoView() {
        addSubview(webView)
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: topAnchor),
            webView.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 12),
            webView.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -12),
            webView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        UIHelper.dismissHUD()
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        UIHelper.showHUDerrorMessage()
    }
    
}
