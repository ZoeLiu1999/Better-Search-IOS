//
//  SimilarProduct.swift
//  BetterSearch
//
//  Created by 刘艺 on 12/13/23.
//

import Foundation

struct SimilarProduct: Codable,Identifiable,Hashable {
    let id: String
    let title: String
    let days: String
    let img: String
    let price: String
    let shipping: String
    
}


struct SimilarMockData {
    static let dataMock: [SimilarProduct] = [
        SimilarProduct(
        id: "274505797468",
        title: "Apple iPhone 8 64GB Factory Unlocked Verizon AT&T T-Mobile Sprint Good",
        days: "19",
        img: "https://i.ebayimg.com/thumbs/images/g/-6sAAOSw5ThiK~Z2/s-l140.jpg",
        price: "144.40",
        shipping: "0.00"
    ),
     SimilarProduct(
        id: "115969353216",
        title: "Apple iPhone 12 64GB Factory Unlocked T-Mobile Verizon AT&T Good Condition",
        days: "4",
        img: "https://i.ebayimg.com/thumbs/images/g/fcIAAOSwlCZlS59d/s-l140.jpg",
        price: "226.00",
        shipping: "0.00"
     )
    
    ]
}
