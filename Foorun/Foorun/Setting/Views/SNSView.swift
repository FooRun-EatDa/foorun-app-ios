//
//  SNSView.swift
//  Foorun
//
//  Created by Hamlit Jason on 2022/07/10.
//

import SwiftUI

struct SNSView: View {
    var body: some View {
        Section {
            Text("👉 카카오톡 채널")
                .font(.caption)
            Text("👉 인스타그램")
                .font(.caption)
        } header: {
            Text("SNS")
        }
    }
}

struct SNSView_Previews: PreviewProvider {
    static var previews: some View {
        SNSView()
    }
}
