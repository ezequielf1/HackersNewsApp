//
//  WebViewController.swift
//  HackerNewsApp
//
//  Created by Brian Ezequiel Fritz on 19/11/2020.
//

import UIKit
import WebKit

final class WebViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet private weak var webView: WKWebView! {
        didSet {
            webView.navigationDelegate = self
            webView.allowsBackForwardNavigationGestures = true
        }
    }
    
    @IBOutlet private weak var errorView: UIView!
    
    // MARK: - Public Properties
    var stringURL: String?
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        loadUrl()
    }
}

// MARK: - Private Methods
private extension WebViewController {
    func loadUrl() {
        if let stringURL = stringURL, let url = URL(string: stringURL) {
            let request = URLRequest(url: url)
            webView.load(request)
        } else {
            showErrorView()
        }
    }
    
    func showErrorView() {
        errorView.isHidden = false
        webView.isHidden = true
    }
}

// MARK: - WKNavigationDelegate
extension WebViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        showErrorView()
    }
}
