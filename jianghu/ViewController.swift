//
//  ViewController.swift
//  jianghu
//
//  Created by fanmingfei on 04/11/2017.
//  Copyright © 2017 fanmingfei. All rights reserved.
//

import UIKit
import WebKit


class ViewController: UIViewController, WKScriptMessageHandler, WKNavigationDelegate {
    var webView: WKWebView!
    var popView: WKWebView!


    override func viewDidLoad() {
        super.viewDidLoad()
        let cgrect = CGRect(x: 0, y: Int(UIApplication.shared.statusBarFrame.height), width: Int(view.frame.width), height: Int(view.frame.height));
        let conifg = WKWebViewConfiguration()
        conifg.userContentController.add(self as WKScriptMessageHandler, name: "Test")
        webView = WKWebView(frame: cgrect, configuration: conifg)
        
    
        

        webView.backgroundColor = UIColor(colorLiteralRed: 0, green: 0, blue: 0, alpha: 1)
        
        
        
        let myURL = URL(string: "http://jianghu.ldustu.com")
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
        

        webView.navigationDelegate = self
        
        
        view.addSubview(webView)
        
        popView = WKWebView(frame: cgrect, configuration: conifg)
        
        popView.isHidden = true
        popView.navigationDelegate = self
        
        view.addSubview(popView)
        

        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        print("got message: \(message.body)")
        if message.name == "Test" {
            let obj = message.body as! NSObject
            let event = obj.value(forKey: "event") as! String
            switch(event){
                case "layer":
                    popView.isHidden = false;
                    popView.load(URLRequest(url: URL(string: obj.value(forKey: "url") as! String)!))
                    break;
                case "close":
                    popView.isHidden = true;
                    popView.loadHTMLString("", baseURL: nil)
                    break;
            default:
                break;
            }
        }
    }
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        print(123)
    }

}
