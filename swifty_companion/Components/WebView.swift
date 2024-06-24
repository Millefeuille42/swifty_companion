//
//  WebView.swift
//  swify_companion
//
//  Created by Millefeuille on 20/06/2024.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    let url: URL?
    var onCustomLink: ((URL) -> Void)?

    func makeCoordinator() -> Coordinator {
         Coordinator(self, onCustomLink)
     }
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.navigationDelegate = context.coordinator
        return webView
    }

    func updateUIView(_ webView: WKWebView, context: Context) {
        if let url = url {
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }
    
    class Coordinator: NSObject, WKNavigationDelegate {
        var parent: WebView
        var onCustomLink: ((URL) -> Void)?

            init(_ parent: WebView, _ onCustomLink: ((URL) -> Void)?) {
                self.parent = parent
                self.onCustomLink = onCustomLink
            }

            func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
                if let url = navigationAction.request.url, url.scheme == "swiftycompanion" {
                    self.onCustomLink?(url)
                    decisionHandler(.cancel)
                    return
                }
                decisionHandler(.allow)
            }
        }
}

#Preview {
    WebView(url: URL(string: "swiftyCompanion://callback"))
}
