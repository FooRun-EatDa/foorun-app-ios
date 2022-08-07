//
//  CertificationView.swift
//  Foorun
//
//  Created by Hamlit Jason on 2022/07/31.
//

import SwiftUI

struct CertificationView: View {
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @Environment(\.editMode) private var editMode
    
    
    @State private var disableTextField = false
    @State var email: String = ""
    @State var code: String = ""
    
    var body: some View {
        VStack {
            
            Spacer()
            
            TextField("이메일을 입력해주세요.", text: $email)
                .padding()
                .textFieldStyle(.roundedBorder)
                .disabled(disableTextField)
            
            if !disableTextField {
                Button {
                    disableTextField.toggle()
                    // 액션
                } label: {
                    Text("이메일 인증")
                }
            }
            
            if disableTextField {
                TextField("인증코드를 입력해주세요.", text: $code)
                    .padding()
                    .textFieldStyle(.roundedBorder)
                
                Button {
                    // APIRequest
                    self.mode.wrappedValue.dismiss()
                } label: {
                    Text("인증코드 입력")
                }
            }
            
            Spacer()
            
            
        }
        .background(Color(uiColor: .secondarySystemBackground))
        
    }
}

struct CertificationVIew_Previews: PreviewProvider {
    static var previews: some View {
        CertificationView()
    }
}
