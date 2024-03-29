//
//  SettingView.swift
//  Foorun
//
//  Created by Hamlit Jason on 2022/07/10.
//

import SwiftUI

struct SettingView: View {
    @EnvironmentObject private var viewModel: SettingViewModel
    
    var body: some View {
        
        List {
            MyPageView()
                .environmentObject(SettingViewModel())
            
            InformationView()
                .environmentObject(SettingViewModel())
            
            SNSView()
                .environmentObject(SettingViewModel())
        }
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SettingView().environmentObject(SettingViewModel())
                .navigationBarTitleDisplayMode(.inline)
        }
        
    }
}
