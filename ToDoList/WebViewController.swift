//
//  WebViewController.swift
//  ToDoList
//
//  Created by Jason Yang on 12/18/23.
//

import UIKit
import WebKit

class WebViewController: UIViewController, WKNavigationDelegate {

    @IBOutlet var txtUrl: UITextField!
    
    @IBOutlet var myActIndicator: UIActivityIndicatorView!
    
    @IBOutlet var myWebView: WKWebView!
    
    func loadWebPage(_ url: String){
        let myUrl = URL(string: url)
        let myRequest = URLRequest(url:myUrl!)
        myWebView.load(myRequest)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        myWebView.navigationDelegate = self
        
        
        loadWebPage("www.google.com")
        
    }
    
    
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        myActIndicator.startAnimating()
        myActIndicator.isHidden = false
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        myActIndicator.stopAnimating()
        myActIndicator.isHidden = true
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        myActIndicator.stopAnimating()
        myActIndicator.isHidden = true
    }
    
    func checkURL(_ url: String) -> String {
        var strUrl = url
        let flag = strUrl.hasPrefix("http://")
        if !flag {
            strUrl = "http://" + strUrl
        }
        return strUrl
    }
    
    
    //MARK: barbutton @IBAction func
    
    @IBAction func btnGoUrl(_ sender: UIButton) {
        let myUrl = checkURL(txtUrl.text!)
        txtUrl.text = ""
        loadWebPage(myUrl)
    }
    
    @IBAction func btnSparta(_ sender: UIButton) {
        loadWebPage("https://www.youtube.com/")
    }
    
    @IBAction func btnTIL(_ sender: UIButton) {
        loadWebPage("https://vesselwheel.tistory.com")
    }
    
    @IBAction func btnGitHub(_ sender: UIButton) {
        loadWebPage("https://github.com/cantabilano")
    }
    
    @IBAction func btnGoogle(_ sender: UIButton) {
        loadWebPage("https://google.com")
    }
    
    
    @IBAction func btnStop(_ sender: UIBarButtonItem) {
        myWebView.stopLoading()
    }
    
    
    @IBAction func btnRefresh(_ sender: UIBarButtonItem) {
        myWebView.reload()
    }
    
    @IBAction func btnReload(_ sender: UIBarButtonItem) {
        myWebView.goBack()
    }
    
    
    @IBAction func btnGoForward(_ sender: UIBarButtonItem) {
        myWebView.goForward()
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
