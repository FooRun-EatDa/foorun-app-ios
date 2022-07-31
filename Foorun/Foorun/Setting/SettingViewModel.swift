//
//  SettingViewModel.swift
//  Foorun
//
//  Created by Hamlit Jason on 2022/07/31.
//

import UIKit
import ReferenceKit

enum URLLink: String {
    // 공지사항
    case notice = "https://synonymous-reading-054.notion.site/d11e2a4381704e72a03eca81a3a406f8"
    // 푸런 팀
    case team = "https://synonymous-reading-054.notion.site/5e938cf823c040a193c566591fe5bfef"
    // 서비스 이용약관
    case terms = "https://synonymous-reading-054.notion.site/063a327e74ad4f8b8c1a38847639e75c"
    // 개인정보 처리 방침
    case privacy = "https://synonymous-reading-054.notion.site/ebf982ca25cb4f5397cadf3fceedd353"
    // 업데이트 소식
    case whatsNew = "https://synonymous-reading-054.notion.site/iOS-22f42812235140698bac0478ae987b83"
    // 인스타그램
    case instagram = "https://www.instagram.com/uni__eat/"
    // 카카오톡 채널
    case kakaotalk = "https://pf.kakao.com/_xaxbJIxj"
    
    func openURL() {
        if let url = URL(string: self.rawValue) {
            UIApplication.shared.open(url, options: [:])
        }
    }
}

class SettingViewModel: ObservableObject {
    /// 앱 버전
    let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
    
    /// 레퍼런스 아이템
    let referenceItems: [ReferenceItem] = [
        ReferenceItem(title: "ReferenceKit", url: "https://github.com/BoilerSwift/ReferenceKit"),
        ReferenceItem(title: "Logger", url: "https://github.com/BoilerSwift/Logger"),
        ReferenceItem(title: "SnapKit", url: "https://github.com/SnapKit/SnapKit"),
        ReferenceItem(title: "Then", url: "https://github.com/devxoul/Then"),
        ReferenceItem(title: "RxSwfit", url: "https://github.com/ReactiveX/RxSwift", deprecated: true),
        ReferenceItem(title: "TTGTagCollectionView", url: "https://github.com/zekunyan/TTGTagCollectionView", deprecated: false),
        ReferenceItem(title: "Alamofire", url: "https://github.com/Alamofire/Alamofire", deprecated: true),
    ]
    
    @Published var shows인증페이지: Bool = false
}
