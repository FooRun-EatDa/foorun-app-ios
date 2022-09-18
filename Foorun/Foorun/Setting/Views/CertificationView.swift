//
//  CertificationView.swift
//  Foorun
//
//  Created by Hamlit Jason on 2022/07/31.
//

import SwiftUI
import FoorunKey

enum ErrorMessage: String {
    case none = "인증 성공 !"
    case empty = "이메일을 입력해주세요"
    case incorrectCode = "인증번호가 올바르지 않아요"
    case invalidEmail = "학교 이메일을 입력해주세요"
}

struct CertificationView: View {
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @Environment(\.editMode) private var editMode
    
    @State private var disabledEmailField = false
    @State var email: String = ""
    
    /// 유저가 입력한 코드
    @State var code: String = ""
    /// 서버에서 내려온 인증 코드
    @State var certificationCode: String = ""
    /// 유효하지 않은 이메일 Alert
    @State private var showingAlert = false
    /// AlertMessage
    @State private var errorMessage: ErrorMessage = .empty
    
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
                    if email.isEmpty {
                        errorMessage = .empty
                        showingAlert = true
                    } else {
                        if !email.contains("@khu.ac.kr") {
                            errorMessage = .invalidEmail
                            showingAlert = true
                        } else {
                            disabledEmailField.toggle()
                            didTap이메일_인증_요청()
                        }
                    }
                    
                } label: {
                    Text("이메일 인증")
                        .foregroundColor(.orange)
                } .alert(isPresented: $showingAlert) {
                    Alert(title: Text(errorMessage.rawValue))
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
                    didTap인증 { isSuccess in
                        if isSuccess {
                            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "verificationCompleted") , object: nil)
                            errorMessage = .none
                            showingAlert = true
                        } else {
                            errorMessage = .incorrectCode
                            showingAlert = true
                        }
                    }
                } label: {
                    Text("✌️ 인증하기 ✌️")
                        .foregroundColor(.orange)
                } .alert(errorMessage.rawValue, isPresented: $showingAlert) {
                    Button("OK", role: .cancel) {
                        if errorMessage == .none {
                            mode.wrappedValue.dismiss()
                        }
                    }
                    
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
    private func didTap이메일_인증_요청() {
        // foorun123@naver.com
        
        API<Int>(
            requestString: FoorunRequest.Auth.auth,
            method: .get,
            parameters: ["email": email]
        ).fetch { apiResponse in
            print("apiResponse: \(apiResponse), email: \(email)")
            guard let _ = apiResponse.data else { return }
        }
    }
    
    private func didTap인증(completion: @escaping ((Bool) -> Void)) {
        API<Int>(
            requestString: "\(FoorunRequest.Auth.auth)?email=\(email)&verificationCode=\(code)",
            method: .post,
            parameters: [:]
        ).fetchResult { result in
            print(result)
            switch result {
                
            case .success(let apiResponse):
                guard let code = apiResponse.data else {
                    errorMessage = .incorrectCode
                    print(errorMessage, "asd")
                    showingAlert = true
                    return
                }
                // NOTE: - 성공해야만 data가 내려옵니다.
                UserDefaultManager.shared.token = "\(code)"
                completion(true)
                
            case .failure(let error):
                completion(false)
                print("🚨Error:: \(error.localizedDescription) ~메소드 에러 발생!")
            }
        }
        
        
    }
}

struct CertificationVIew_Previews: PreviewProvider {
    static var previews: some View {
        CertificationView()
    }
}
