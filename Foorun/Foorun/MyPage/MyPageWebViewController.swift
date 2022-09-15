//
//  MyPageWebViewController.swift
//  Foorun
//
//  Created by 김지훈 on 2022/09/14.
//

import UIKit
import WebKit

class MyPageWebViewController:UIViewController, WKUIDelegate{
    
    // MARK: - IBOutlets
    var webView: WKWebView = WKWebView(frame: .zero)
    var indicator = UIActivityIndicatorView()
    
    // MARK: - Properties
    var linkString: String?

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        view.backgroundColor = .white

        configureWebView()
        setupIndicator()
    }
    
    // MARK: - Methods
    func loadWebView() {
        
        guard  let url = URL(string: linkString ?? "") else {
            self.navigationController?.popViewController(animated: true)
            return
        }
        let request = URLRequest(url: url)
        webView.load(request)
    }
    
    func configureWebView() {
        setupWebView()
        loadWebView()
    }
    
    func setupWebView() {
        view.addSubview(webView)
        
        webView.uiDelegate = self
        webView.navigationDelegate = self
        
        webView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func setupIndicator() {
        view.addSubview(indicator)
        
        indicator.snp.makeConstraints {
            $0.centerY.centerX.equalToSuperview()
        }
    }
}

extension MyPageWebViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        indicator.startAnimating()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        indicator.stopAnimating()
    }
}
