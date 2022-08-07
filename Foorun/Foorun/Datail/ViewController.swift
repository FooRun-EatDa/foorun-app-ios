//
//  ViewController.swift
//  Foorun
//
//  Created by 김희진 on 2022/08/07.
//

import Foundation
import UIKit
import FoorunKey
import Logger
import SnapKit

class ViewController: UIViewController {

    private lazy var button: UIButton = {
        let button = UIButton()
        button.setTitle("GO!", for: .normal)
        button.backgroundColor = .black
        button.addTarget(self, action: #selector(openBottomSheet), for: .touchUpInside)
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

    @objc func openBottomSheet() {
        let detailViewController = DetailViewController()

        let nav = UINavigationController(rootViewController: detailViewController)
        nav.modalPresentationStyle = .pageSheet

        if let sheet = nav.sheetPresentationController {
           sheet.detents = [.medium(), .large()]
           present(nav, animated: true, completion: nil)
        }
    }
}
