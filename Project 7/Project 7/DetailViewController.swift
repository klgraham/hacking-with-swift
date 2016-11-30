//
//  DetailViewController.swift
//  Project 7
//
//  Created by Kenneth L. Graham on 11/30/16.
//  Copyright © 2016 Kenneth Graham. All rights reserved.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {
    
    var webView: WKWebView!
    var petitionDetail: Petition!
    
    override func loadView() {
        webView = WKWebView()
        view = webView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard petitionDetail != nil else { return }
        renderPetitionDetail()
    }
    
    func renderPetitionDetail() {
        let body = petitionDetail.body
        var html = "<html>"
        html += "<head>"
        html += "<meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">"
        html += "<style> body { font-size: 125%; } </style>"
        html += "</head>"
        html += "<body>"
        html += body
        html += "</body>"
        html += "</html>"
        webView.loadHTMLString(html, baseURL: nil)
    }
}
