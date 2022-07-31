//
//  MyPageView.swift
//  Foorun
//
//  Created by Hamlit Jason on 2022/07/10.
//

import SwiftUI

struct MyPageView: View {
    @StateObject private var viewModel = SettingViewModel()
    
    var body: some View {
        Section {
            Text("🧩 인증 하기")
                .font(.caption)
                .onTapGesture {
                    viewModel.shows인증페이지.toggle()
                }

        } header: {
            Text("마이 페이지")
        }
        .sheet(isPresented: $viewModel.shows인증페이지) {
            CertificationView()
        }
    }
}

struct MyPageView_Previews: PreviewProvider {
    static var previews: some View {
        MyPageView()
    }
}
