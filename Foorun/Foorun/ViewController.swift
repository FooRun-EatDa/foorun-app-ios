//
//  ViewController.swift
//  Foorun
//
//  Created by Hamlit Jason on 2022/07/10.
//

import UIKit
import FoorunKey
import Logger

class ViewController: UIViewController {

    private lazy var button: UIButton = {
        let button = UIButton()
        button.setTitle("GO!", for: .normal)
        button.backgroundColor = .black
        button.addTarget(self, action: #selector(openBookMarkPage), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(button)
        button.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(100)
        }
    }
    
    @objc func openBookMarkPage() {
        let bookMarkViewController = BookMarkViewController()

        let nav = UINavigationController(rootViewController: bookMarkViewController)
        nav.modalPresentationStyle = .overFullScreen
        present(nav, animated: false, completion: nil)
    }
}

