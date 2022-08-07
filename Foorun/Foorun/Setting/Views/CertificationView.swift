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
    
    
    @State private var disabledEmailField = false
    @State var email: String = ""
    @State var code: String = ""
    
    var body: some View {
        VStack {
            
            Spacer()
            
            TextField("인증 가능한 학교 이메일을 입력해주세요.", text: $email)
                .foregroundColor(.gray)
                .padding()
                .textFieldStyle(.roundedBorder)
                .disabled(disabledEmailField)
                
            if !disabledEmailField {
                Button {
                    if !email.isEmpty {
                        disabledEmailField.toggle()
                    }
                    
                } label: {
                    Text("이메일 인증")
                        .foregroundColor(.orange)
                }
                
            }
            
            if disabledEmailField {
                Text("🧑🏻‍💻 이메일을 수정할 수 없어요!")
                    .foregroundColor(.red)
                    .font(.caption)
                    .frame(alignment: .leading)
                
                TextField("인증코드를 입력해주세요.", text: $code)
                    .padding()
                    .textFieldStyle(.roundedBorder)
                
                Text("""
                     🧑🏻‍💻 해당 이메일의 인증 코드를 입력해주세요.
                     코드 발송이 조금 지연될 수 있어요.
                     1분 이상 메일이 오지 않는다면, 재인증 혹은 푸런 팀에 알려주세요.
                     
                     
                     """)
                    .foregroundColor(.red)
                    .font(.caption)
                    .frame(alignment: .leading)
                
                Button {
                    // APIRequest
                    self.mode.wrappedValue.dismiss()
                } label: {
                    Text("✌️ 인증하기 ✌️")
                        .foregroundColor(.orange)
                }   
            }
            
            Spacer()
            
            Text("""
                이메일을 잘못 입력하신 경우, 페이지를 나갔다 들어와주세요:)
                

                """)
            .font(.caption)
            
        }
        .background(Color(uiColor: .secondarySystemBackground))
        
    }
}

struct CertificationVIew_Previews: PreviewProvider {
    static var previews: some View {
        CertificationView()
    }
}
