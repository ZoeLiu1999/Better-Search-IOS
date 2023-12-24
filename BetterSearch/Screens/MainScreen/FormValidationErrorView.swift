//
//  FormValidationErrorView.swift
//  BetterSearch
//
//  Created by 刘艺 on 12/13/23.
//

import SwiftUI

struct FormValidationErrorView: View {
    var body: some View {
        VStack {
            Text("Keyword is mandatory")
                .foregroundColor(.white)
                .padding()
                .background(Color.black)
                .cornerRadius(10)
        }
        .frame(maxWidth: .infinity, alignment: .center)
    }
}

#Preview {
    FormValidationErrorView()
}
