//
//  InformationView.swift
//  Foorun
//
//  Created by Hamlit Jason on 2022/07/10.
//

import SwiftUI
import ReferenceKit

struct InformationView: View {
    @Enviro
    
    /// Reference Item
    let items: [ReferenceItem] = [
        ReferenceItem(title: "ReferenceKit", url: "https://github.com/BoilerSwift/ReferenceKit"),
        ReferenceItem(title: "Logger", url: "https://github.com/BoilerSwift/Logger"),
        ReferenceItem(title: "SnapKit", url: "https://github.com/SnapKit/SnapKit"),
        ReferenceItem(title: "Then", url: "https://github.com/devxoul/Then"),
        ReferenceItem(title: "RxSwfit", url: "https://github.com/ReactiveX/RxSwift", deprecated: true),
        ReferenceItem(title: "TTGTagCollectionView", url: "https://github.com/zekunyan/TTGTagCollectionView", deprecated: false),
        ReferenceItem(title: "Alamofire", url: "https://github.com/Alamofire/Alamofire", deprecated: true),
    ]
    
    var body: some View {
        Section {
            HStack {
                Text("🛸 앱 버전")
                    .font(.caption)
                Spacer()
                Text("\(appVersion!)")
                    .font(.caption)
            }
            
            
            HStack {
                Text("📣 공지사항")
                    .font(.caption)
                Spacer()
                Image(systemName: "chevron.right")
                    .foregroundColor(.gray)
            }
            
            // NOTE: Click URL
            HStack {
                Text("👮‍♀️ 신고 / 문의하기")
                    .font(.caption)
                Spacer()
                Image(systemName: "chevron.right")
                    .foregroundColor(.gray)
            }
            
            HStack {
                Text("👨‍👩‍👧‍👧 Foorun Team")
                    .font(.caption)
                Spacer()
                Image(systemName: "chevron.right")
                    .foregroundColor(.gray)
            }
            
            HStack {
                Text("📃 약관 및 정책")
                    .font(.caption)
                Spacer()
                Image(systemName: "chevron.right")
                    .foregroundColor(.gray)
            }
            
            HStack {
                Text("🛡 개인정보 처리방침")
                    .font(.caption)
                Spacer()
                Image(systemName: "chevron.right")
                    .foregroundColor(.gray)
            }
            
            HStack {
                NavigationLink {
                    ReferenceView(items: items)
                } label: {
                    Text("🏛 사용한 오픈소스")
                        .font(.caption)
                }
                 
            }
            
        } header: {
            Text("정보")
        }
    }
    
}

struct InformationView_Previews: PreviewProvider {
    static var previews: some View {
        InformationView()
    }
}
