//
//  MyPageView.swift
//  Foorun
//
//  Created by Hamlit Jason on 2022/07/10.
//

import SwiftUI

struct MyPageView: View {
    @EnvironmentObject private var viewModel: SettingViewModel
    
    @State private var tokenString = "🧩 인증 하기"
    var body: some View {
        Section {
            NavigationLink {
                CertificationView()
                    .environmentObject(viewModel)
            } label: {
                Text(tokenString).font(.caption)
            }
            .disabled(viewModel.isToken)
            
        } header: {
            Text("마이 페이지")
        }
        .onAppear {
            tokenString = viewModel.isToken
            ? "✅ 인증 완료"
            : "🧩 인증 하기"
        }
    }
}

struct MyPageView_Previews: PreviewProvider {
    static var previews: some View {
        MyPageView()
    }
}
