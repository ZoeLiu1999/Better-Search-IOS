//
//  SimilarProductView.swift
//  ProductSearch
//
//  Created by 刘艺 on 12/3/23.
//

import SwiftUI

struct SimilarProductView: View {
    var product:SimilarProduct
    
    var body: some View {
        VStack(spacing:8) {
            
            AsyncImage(url: URL(string: product.img)) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFit()
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                case .failure:
                    Image(systemName: "exclamationmark.icloud")
                        .imageScale(.large)
                        .foregroundColor(.red)
                @unknown default:
                    fatalError("Unknown case in AsyncImage loading.")
                }
            }.frame(height: 180)
            
            Text(product.title)
                .font(.headline)
                .lineLimit(2)
                .truncationMode(.tail)
            
            HStack {
                Text("$"+product.shipping).font(.caption)
                Spacer()
                Text("\(product.days) days left").font(.caption)
                
            }.foregroundColor(.gray)
            
            HStack(content: {
                Spacer()
                Text("$\(product.price)")
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .foregroundColor(.blue)
            })
            
        }
        .padding(10)
        .background(Color("lightgray"))
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color("boarder"), lineWidth: 2)
        )
        .frame(width: 170)
    }
}

struct SimilarProductView_Previews: PreviewProvider {
    static var previews: some View {
        let data = SimilarMockData.dataMock[0]
        return SimilarProductView(product: data)
    }
}
