//
//  SettingViewModel.swift
//  Foorun
//
//  Created by Hamlit Jason on 2022/07/31.
//

import UIKit

enum URLLink: String {
    // 공지사항
    case notice = "https://great-rover-489.notion.site/b077cdcffacd4336b7785f44ba0e6794"
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
    case kakaotalk = ""
    
    func openURL() {
        if let url = URL(string: self.rawValue) {
            UIApplication.shared.open(url, options: [:])
        }
    }
}

class SettingListModel: ObservableObject {
    let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
    
    
}
