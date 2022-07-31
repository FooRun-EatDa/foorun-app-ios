//
//  MyPageView.swift
//  Foorun
//
//  Created by Hamlit Jason on 2022/07/10.
//

import SwiftUI

struct MyPageView: View {
    var body: some View {
        Section {
            Text("🧩 인증 하기")
                .font(.caption)
            
            // TODO: - Slider
            HStack {
                Text("🍭 알림 구독")
                    .font(.caption)
            }
        } header: {
            Text("마이 페이지")
        }
    }
}

struct MyPageView_Previews: PreviewProvider {
    static var previews: some View {
        MyPageView()
    }
}
