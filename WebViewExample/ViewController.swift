//
//  ViewController.swift
//  WebViewExample
//
//  Created by ShreeshaRao on 25/01/22.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKUIDelegate, WKNavigationDelegate {
    
    
    @IBOutlet weak var webView: WKWebView!
    
    @IBOutlet weak var progressView: UIProgressView!
    
    let config = WKWebViewConfiguration()

    override func viewDidLoad() {
        super.viewDidLoad()
       
        webView.uiDelegate = self
        webView.navigationDelegate = self
    
        webView.load("https://www.google.com")
        webView.allowsBackForwardNavigationGestures = true
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.title), options: .new, context: nil)
        print(webView.debugDescription)
        // Evaluvate javaScript
        webView.evaluateJavaScript("document.getElementByID('title').innerText") { (result , error) in
            
            if let result = result {
                print(result)
            }
        }
        
        // Reading and Deleting Cookies
        
        webView.configuration.websiteDataStore.httpCookieStore.getAllCookies { cookies in
            for cookie in cookies {
                print("\(cookie.name) is set to \(cookie.value)")
                debugPrint("\(cookie.name) is set to \(cookie.value)")
            }
        }
        
    }
    
    
    // progress View (Monitioring Page Loads)
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        // progrss View (Monitoring Page Loads)
        if keyPath == "estimatedProgress" {
            progressView.progress = Float(webView.estimatedProgress)
        }
        // print title while changing webPage
        if keyPath == "title"
        {   if let title = webView.title {
            print(title)
            
        }
        }
        
    }
    
    // shows a AlertController when there is alert in webpage (Custom WebPage UI)
    func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
        
        let ac = UIAlertController(title: "Hey Listen", message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        print("UIAlertViewController")
        present(ac,animated: true)
        completionHandler()
       
    }
    
    
    
    // Reading WebPage Title as it chnages
    
    // WKNavigationDelegte method to control which sites can be visited
//
//    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
//
//        if let host = navigationAction.request.url?.host {
//            if host == "www.apple.com" {
//                decisionHandler(.allow)
//                return
//            }
//        }
//        decisionHandler(.cancel)
//    }
    
    //Opening A Link in external Browser ( Load other link in webPageView and the mentioned Link in webBrowser)
    
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if let url = navigationAction.request.url {
            if url.host == "www.apple.com" {
                UIApplication.shared.open(url)
                decisionHandler(.cancel)
                return
            }
        }
        decisionHandler(.allow)
    }
    
    
    @IBAction func forwardButton(_ sender: UIButton) {
        if webView.canGoForward {
            webView.goForward()
            
        }
        else {
            print("Can't Go Forward")
        }
    }
    
    
    @IBAction func backwardButton(_ sender: UIButton) {
        if webView.canGoBack {
            webView.goBack()
        }
        else {
            print("Cant Go Back")
        }
       
    }
    
    @IBAction func stopButton(_ sender: UIButton) {
        
        webView.stopLoading()
        
    }
    
    @IBAction func refreshButton(_ sender: UIButton) {
        
        webView.reload()
    }
    
    
    
    
    

}
extension WKWebView {
    func load(_ urlString: String) {
        if let url = URL(string: urlString) {
            let request = URLRequest(url: url)
            load(request)
        }
    }
}

