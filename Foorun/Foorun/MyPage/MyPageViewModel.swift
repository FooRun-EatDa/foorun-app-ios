//
//  MyPageMainViewModel.swift
//  Foorun
//
//  Created by 김지훈 on 2022/09/14.
//

import UIKit

struct MyPageViewModel: Hashable {
    var title = "마이페이지"
    let userImgUrl = AssetSet.MyPage.userdefault
    let logoImgUrl = AssetSet.MyPage.mainlogo
    var name = UserDefaultManager.shared.token
    
    var menus: [String] = [
        "공지사항",
        "서비스 소개",
        "개인정보 처리방침",
        "약관 및 정책",
        "신고 / 문의하기"
    ]
    
    let links: [String: String]  = [
        "공지사항": "https://synonymous-reading-054.notion.site/d11e2a4381704e72a03eca81a3a406f8",
        "개인정보 처리방침": "https://synonymous-reading-054.notion.site/ebf982ca25cb4f5397cadf3fceedd353",
        "약관 및 정책": "https://synonymous-reading-054.notion.site/063a327e74ad4f8b8c1a38847639e75c",
        "업데이트 소식": "https://synonymous-reading-054.notion.site/iOS-22f42812235140698bac0478ae987b83",
        "푸런팀": "https://synonymous-reading-054.notion.site/5e938cf823c040a193c566591fe5bfef",
        "카카오톡 채널" : "https://pf.kakao.com/_xaxbJIxj",
        "인스타그램": "https://www.instagram.com/uni__eat/",
        "👩🏻‍💻 김나희": "https://github.com/k-nh",
        "👩🏻‍💻 김희진": "https://github.com/heejin342",
        "🧑🏻‍💻 김지훈": "https://github.com/gnjs224",
        "🧑🏻‍💻 이건우": "https://github.com/lgvv",
        "🧑🏻‍💻 윤세영": "https://github.com/ssyoun4092",
        "Alamofire": "https://github.com/Alamofire/Alamofire",
        "Logger": "https://github.com/BoilerSwift/Logger",
        "ReferenceKit": "https://github.com/BoilerSwift/ReferenceKit",
        "RxSwift": "https://github.com/ReactiveX/RxSwift",
        "SnapKit": "https://github.com/SnapKit/SnapKit",
        "Then": "https://github.com/devxoul/Then",
        "Kingfisher": "https://github.com/onevcat/Kingfisher"
    ]
    
    let nextMenus: [String:[String]] = [
        "서비스 소개": [
            "업데이트 소식",
            "푸런팀",
            "사용한 오픈소스",
            "iOS 개발자들"
        ],
        "신고 / 문의하기": [
            "인스타그램",
            "카카오톡 채널"
        ],
        "iOS 개발자들": [
            "👩🏻‍💻 김나희",
            "👩🏻‍💻 김희진",
            "🧑🏻‍💻 김지훈",
            "🧑🏻‍💻 이건우",
            "🧑🏻‍💻 윤세영"
        ],
        "사용한 오픈소스": [
            "Alamofire",
            "Logger",
            "ReferenceKit",
            "RxSwift",
            "SnapKit",
            "Then",
            "Kingfisher"
        ]
    ]
    init() { }
    init(title: String, menus: [String]) {
        self.title = title
        self.menus = menus
    }
    
    func getWebViewController(index: Int) -> MyPageWebViewController {
        let nextVC = MyPageWebViewController()
        nextVC.link = links[menus[index]]
        return nextVC
    }
    
    func getDetailViewController(index: Int) -> MyPageDetailViewController? {
        let nextVC = MyPageDetailViewController()
        let keyTitle = menus[index]
        guard let nextMenus = nextMenus[keyTitle] else { return nil}
        nextVC.viewModel = MyPageViewModel(title: keyTitle, menus: nextMenus)
        return nextVC
    }
    
    mutating func updateName() {
        name = UserDefaultManager.shared.token
    }
}
