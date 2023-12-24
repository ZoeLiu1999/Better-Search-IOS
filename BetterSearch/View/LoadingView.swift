//
//  LoadingView.swift
//  BetterSearch
//
//  Created by 刘艺 on 12/13/23.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        HStack{
            Spacer()
            VStack(spacing:5){
                ProgressView()
                Text("Please Wait...").foregroundColor(.gray).font(.footnote)
            }
            Spacer()
        }
    }
}

#Preview {
    LoadingView()
}
