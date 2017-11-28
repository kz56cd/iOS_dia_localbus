//
//  ToStationViewController.swift
//  DiaSeibubus
//
//  Created by 佐野正和 on 2017/11/27.
//  Copyright © 2017年 佐野正和. All rights reserved.
//

import UIKit
import WebKit

class ToStationViewController: UIViewController, WKUIDelegate, WKNavigationDelegate {
    
    @IBOutlet weak var webView: WKWebView!
    
    var startBusstopInfo: BusstopInfo? {
        guard let parent = parent as? PageViewController,
        let infos = parent.infos else {
            return nil
        }
        return infos.filter { $0.isStationBusTarminal == false }.first
    }
    
    var endBusstopInfo: BusstopInfo? {
        guard let parent = parent as? PageViewController,
            let infos = parent.infos else {
                return nil
        }
        return infos.filter { $0.isStationBusTarminal == true }.first
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureWebView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: private
    
    private func configureWebView() {
        webView.uiDelegate = self
        webView.navigationDelegate = self
        loadWebView()
    }
    
    private func loadWebView() {
        
        func configureUrlString() -> String {
            guard let startBusstopInfo = startBusstopInfo,
                let endBusstopInfo = endBusstopInfo else {
                    return ""
            }
            var str = "http://transfer.navitime.biz/seibubus-dia/smart/transfer/TransferSearch"
            str += "?minute=56"
            str += "&startName=%E5%A4%A7%E5%AE%AE%E9%A7%85%E8%A5%BF%E5%8F%A3"
            str += "&sort=2"
            str += "&wspeed=standard"
            str += "&basis=1"
            str += "&start=\(startBusstopInfo.identifier)"
            str += "&method=2"
            str += "&hour=11"
            str += "&day=20171127"
            str += "&goalName=%E5%A4%A7%E5%B9%B3%E5%85%AC%E5%9C%92%E5%85%A5%E5%8F%A3"
            str += "&goal=\(endBusstopInfo.identifier)"
            return str
        }
        
        let urlString = configureUrlString()
        if let url = URL(string: urlString) {
            webView.load(URLRequest(url: url))
        }
    }
    
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("😎 loaded: ToStation dia.")
    }
}