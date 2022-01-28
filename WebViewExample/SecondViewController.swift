//
//  SecondViewController.swift
//  WebViewExample
//
//  Created by ShreeshaRao on 25/01/22.
//

import UIKit
import WebKit

class SecondViewController: UIViewController, WKUIDelegate {
    
    var webView: WKWebView!
    
    override func loadView() {
        
        let webConfiguration = WKWebViewConfiguration()
        //detect they of data and convert into links
        webConfiguration.dataDetectorTypes = [.all]
        webView = WKWebView(frame: .init(x: 0, y: 0, width: .max, height: .max),configuration: webConfiguration)
        webView.uiDelegate = self
        view = webView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let myURL = URL(string: "https://www.google.com")
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
        
        
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
