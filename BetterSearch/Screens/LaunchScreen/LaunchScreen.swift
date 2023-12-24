//
//  ContentView.swift
//  BetterSearch
//
//  Created by 刘艺 on 12/13/23.
//

import SwiftUI

struct LaunchScreen: View {
    @State private var isActive = false
    
    var body: some View {
        
        if(!isActive){
            HStack{
                Text("Powered by")
                Image("ebay")
                    .resizable()
                    .frame(width: 65, height: 30)
                    .aspectRatio(contentMode: .fit)
            }
            
            .onAppear{
                DispatchQueue.main.asyncAfter(deadline: .now()+1.0) {
                    self.isActive = true
                }
            }
            
        } else {
            MainScreenView()
        }
    }
}

#Preview {
    LaunchScreen()
}
