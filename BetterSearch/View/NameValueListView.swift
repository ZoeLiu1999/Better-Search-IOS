//
//  NameValueListView.swift
//  ProductSearch
//
//  Created by 刘艺 on 12/3/23.
//

import SwiftUI

struct NameValueListView: View {
    var currList: [NameValue]
    
    var body: some View {
        ScrollView {
                    VStack(alignment: .leading) {
                        Divider().frame(height:1).background(Color.gray)
                        ForEach(currList, id: \.self) { nameValue in
                            HStack {
                                Text(nameValue.Name)
                                    .frame(width: 200, height:5,alignment: .leading)

                                Text(nameValue.Value[0])
                                    .frame(height:5,alignment: .leading)
                            }
                            Divider().frame(height:1).background(Color.gray)
                        }
                    }
                    .padding()
                }
    
    }
}

struct NameValueListView_Previews: PreviewProvider {
    static var previews: some View {
        let data = DetailMockData.detailMock.nameValueList
        return NameValueListView(currList: data)
    }
}
