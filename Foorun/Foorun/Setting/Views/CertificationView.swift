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
    /// 유저가 입력한 코드
    @State var code: String = ""
    
    /// 서버에서 내려온 인증 코드
    @State var certificationCode: String = ""
    
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
                        didTap이메일_인증_요청()
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
                     🧑🏻‍💻 해당 이메일로 전송된 인증 코드를 입력해주세요.
                     코드 발송이 조금 지연될 수 있어요.
                     1분 이상 메일이 오지 않는다면, 재인증 혹은 푸런 팀에 알려주세요.
                     
                     
                     """)
                    .foregroundColor(.red)
                    .font(.caption)
                    .frame(alignment: .leading)
                
                Button {
                    // APIRequest
                    self.didTap인증()
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
    
    struct Auth: Codable {
        let code: Int
        let data: Int?
        let message: String
    }
    
    private func didTap이메일_인증_요청() {
        // foorun123@naver.com
        let baseString = "auth"
        let requestString = baseString + "?email=\(email)"
        
        API<Auth>(
            requestString: requestString,
            method: .get,
            parameters: [:]
        ).fetch { apiResponse in
            guard let response = apiResponse.data else { return }
            guard let certificationCode = response.data else { return }
            
            self.certificationCode = String(certificationCode)
        }
    }
    
    private func didTap인증() {
        let baseString = "auth"
        let email = "?email=\(email)"
        let varification = "?varificationCode=\(code)"
        let requestString = baseString + email + varification
        
        API<Auth>(
            requestString: requestString,
            method: .post,
            parameters: [:]
        ).fetch { apiResponse in
            guard let response = apiResponse.data else { return }
            guard let code = response.data else { return }
            
            // NOTE: - 성공해야만 data가 내려옵니다.
            UserDefaults.standard.set("\(code)", forKey: "token")
            self.mode.wrappedValue.dismiss()
        }
    }
}

struct CertificationVIew_Previews: PreviewProvider {
    static var previews: some View {
        CertificationView()
    }
}
