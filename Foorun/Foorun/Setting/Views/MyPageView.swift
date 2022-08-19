//
//  MyPageView.swift
//  Foorun
//
//  Created by Hamlit Jason on 2022/07/10.
//

import SwiftUI

struct MyPageView: View {
    @StateObject private var viewModel = SettingViewModel()
    @State var isActive: Bool = true
    
    /// 토큰이 존재하면 true
    var isToken: Bool {
        if UserDefaults.standard.string(forKey: "token") == nil { return false }
        else { return true }
    }
    var body: some View {
        Section {
            NavigationLink {
                CertificationView()
            } label: {
                isToken
                ? Text("✅ 인증 완료").font(.caption)
                : Text("🧩 인증 하기").font(.caption)
            }
            .disabled(isToken)
            
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
