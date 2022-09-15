//
//  MyPageWebViewController.swift
//  Foorun
//
//  Created by 김지훈 on 2022/09/14.
//

import UIKit
import WebKit
class MyPageWebViewController:UIViewController, WKUIDelegate, WKNavigationDelegate{
    
    // MARK: - IBOutlets
    var webView: WKWebView!
    var emptyLabel: UILabel = UILabel()
    var indicator = UIActivityIndicatorView()
    
    // MARK: - Properties
    var link: String?
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        indicator.stopAnimating()
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        view.backgroundColor = .white

        configureWebView()
        setupIndicator()
        
    }
    func configureWebView() {
        
        guard  let myURL = URL(string: link ?? "") else {
            indicator.isHidden = true
            setupEmptyLabel()
            return
        }
        indicator.startAnimating()
        
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        setupWebView()
        webView.uiDelegate = self
        let myRequest = URLRequest(url: myURL)
        webView.load(myRequest)
        
        
    }
    
    func setupEmptyLabel() {
        view.addSubview(emptyLabel)
        
        emptyLabel.text = "일시적인 오류가 발생했어요...😱"
        emptyLabel.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
        
    }
    
    func setupWebView() {
        
        view.addSubview(webView)
        
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
