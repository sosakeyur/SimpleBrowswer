//
//  EmbededWebView.swift
//  SimpleBrowser-Firefox
//
//  Created by Admin on 10/17/19.
//  Copyright © 2019 Keyur Sosa. All rights reserved.
//

import Foundation
import UIKit
import WebKit

class EmbededWebView: UIViewController {
    @IBOutlet var webView: WKWebView!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    @IBOutlet var toolBar: UIToolbar!

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }

    @IBAction func goBack(_ sender: Any) {
        webView.goBack()
    }

    @IBAction func goForward(_ sender: Any) {
        webView.goForward()
    }

    @IBAction func refreshPage(_ sender: Any) {
        webView.reload()
    }
}

// Do Extra UI Changes here
extension EmbededWebView {
    func configure() {
        toolBar.barTintColor = .white
    }
}

// Loading the Url in Webview Using Notification and showing the activity controller
extension EmbededWebView {
    func loadWebView(url: String) {
        let urlRequest: URLRequest = URLRequest(url: URL(string: url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")!)
        webView.load(urlRequest)
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.isLoading), options: .new, context: nil)
    }

    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey: Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "loading" {
            if webView.isLoading {
                activityIndicator.startAnimating()
                activityIndicator.isHidden = false
            } else {
                activityIndicator.stopAnimating()
                activityIndicator.isHidden = true
            }
        }
    }
}
