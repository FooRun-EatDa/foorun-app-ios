//
//  InformationView.swift
//  Foorun
//
//  Created by Hamlit Jason on 2022/07/10.
//

import SwiftUI
import ReferenceKit

struct InformationView: View {
    @EnvironmentObject private var viewModel: SettingViewModel
    
    var body: some View {
        Section {
            HStack {
                Text("🛸 앱 버전")
                    .font(.caption)
                Spacer()
                Text("\(viewModel.version!)")
                    .font(.caption)
            }
            
            infomationItemView(text: "📣 공지사항")
                .onTapGesture {
                    URLLink.notice.openURL()
                }
            
            infomationItemView(text: "🤩 업데이트 소식")
                .onTapGesture {
                    URLLink.whatsNew.openURL()
                }
            
            infomationItemView(text: "👨‍👩‍👧‍👧 푸런 팀")
                .onTapGesture {
                    URLLink.team.openURL()
                }
            
            infomationItemView(text: "📃 약관 및 정책")
                .onTapGesture {
                    URLLink.terms.openURL()
                }
            
            infomationItemView(text: "🛡 개인정보 처리방침")
                .onTapGesture {
                    URLLink.privacy.openURL()
                }
            
            HStack {
                NavigationLink {
                    ReferenceView(items: viewModel.referenceItems)
                } label: {
                    Text("🏛 사용한 오픈소스")
                        .font(.caption)
                }
            }
            
        } header: {
            Text("정보")
        }
    }
    
    /// 인포 정보에 대한 뷰에 대한 부분 입니다.
    private func infomationItemView(
        text: String,
        systemName: String = "chevron.right"
    ) -> some View {
        HStack {
            HStack {
                Text(text)
                    .font(.caption)
                Spacer()
                Image(systemName: systemName)
                    .foregroundColor(.gray)
            }
        }
    }
    
}

struct InformationView_Previews: PreviewProvider {
    static var previews: some View {
        InformationView()
    }
}
