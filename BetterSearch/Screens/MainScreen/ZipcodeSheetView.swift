//
//  ZipcodeSheetView.swift
//  BetterSearch
//
//  Created by 刘艺 on 12/13/23.
//

import SwiftUI


struct ZipcodeSheetView: View {
    
    @Binding var showZipcodeSheet: Bool
    @Binding var zipcode: String
    var suggestions: [String]
    
    
    var body: some View {
        VStack {
            Text("Zipcode Suggestions")
                .font(.title)
                .bold()
                .padding()
            List(suggestions, id: \.self) { zip in
                Button(action: {
                    zipcode = zip
                    showZipcodeSheet = false
                }) {
                    Text(zip).foregroundColor(.black)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    @State static var showZipcodeSheet: Bool = false
    @State static var zipcode: String = "900"

    static var previews: some View {
        ZipcodeSheetView(showZipcodeSheet: $showZipcodeSheet, zipcode: $zipcode, suggestions: ["90015", "90086"])
    }
}
