//
//  SettingView.swift
//  Foorun
//
//  Created by Hamlit Jason on 2022/07/10.
//

import SwiftUI

struct SettingView: View {
    var body: some View {
        
        List {
            MyPageView()
            
            InformationView()
            
            SNSView()
        }
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SettingView()
                .navigationBarTitleDisplayMode(.inline)
        }
        
    }
}
