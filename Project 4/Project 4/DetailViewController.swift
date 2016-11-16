//
//  ViewController.swift
//  Project 4
//
//  Created by Kenneth L. Graham on 11/14/16.
//  Copyright © 2016 Kenneth Graham. All rights reserved.
//

import UIKit
import WebKit

// Also works if WKNavigationDelegate -> WKUIDelegate
class DetailViewController: UIViewController, WKNavigationDelegate {

    var webView: WKWebView!
    var siteToLoad: Int!
    var websites: [String]!
    var progressView: UIProgressView!
    
    
//    Update this to load the webpages from a table view. The open button can open a UITableView
    
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        // along with WKNavigationDelegate -> WKUIDelegate, navigationDelegate -> uiDelegate
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
//        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Open", style: .plain, target: self, action: #selector(openTapped))
//        
//        progressView = UIProgressView(progressViewStyle: .default)
//        progressView.sizeToFit()
//        let progressButton = UIBarButtonItem(customView: progressView)
//        
//        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
//        let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: webView, action: #selector(webView.reload))
//        
//        toolbarItems = [progressButton, spacer, refresh]
//        navigationController?.isToolbarHidden = false
//        
//        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
        
        let url = URL(string: "https://" + websites[siteToLoad])!
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
    }
    
//    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
//        if keyPath == "estimatedProgress" {
//            progressView.progress = Float(webView.estimatedProgress)
//        }
//    }
    
//    func openTapped() {
//        let alert = UIAlertController(title: "Open page...", message: nil, preferredStyle: .actionSheet)
//        
//        for website in websites {
//            alert.addAction(UIAlertAction(title: website, style: .default, handler: openPage))
//        }
//
//        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
//        alert.popoverPresentationController?.barButtonItem = self.navigationItem.rightBarButtonItem
//        self.present(alert, animated: true)
//    }
//    
//    func openPage(action: UIAlertAction!) {
//        let url = URL(string: "https://" + action.title!)!
//        webView.load(URLRequest(url: url))
//    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        title = webView.title
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        let url = navigationAction.request.url
        
        if let host = url!.host {
            for website in websites {
                if host.range(of: website) != nil {
                    decisionHandler(.allow)
                    return
                }
            }
        }
        
        decisionHandler(.cancel)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

//    override func viewWillDisappear(_ animated: Bool) {
//        webView.removeObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress))
//    }
}

