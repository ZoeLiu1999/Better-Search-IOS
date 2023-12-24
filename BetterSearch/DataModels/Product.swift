//
//  Product.swift
//  BetterSearch
//
//  Created by 刘艺 on 12/13/23.
//

import Foundation

struct Product: Codable,Identifiable,Hashable {
    let id: String
    let title: String
    let productURL: String
    let galleryURL: String
    let postalCode: String
    let storeName: String
    let storeURL: String
    let feedbackScore: String
    let positiveFeedbackPercent: String
    let shippingCost: String
    let shipToLocations: String
    let handlingTime: String
    let sellingPrice: String
    let returnsAccepted: String
    let conditionId: String

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case galleryURL
        case postalCode
        case storeName
        case storeURL
        case productURL
        case feedbackScore
        case positiveFeedbackPercent
        case shippingCost
        case shipToLocations
        case handlingTime
        case sellingPrice
        case returnsAccepted
        case conditionId
    }
    var numericSellingPrice: Double? {
            return Double(sellingPrice)
        }
}


struct MockData {
    static let mockData: [Product] = [
        Product(
            id: "225245645838",
            title: "Apple iPhone 8 64GB / 256GB (Factory Unlocked ✅) AT&T T-MOBILE VERIZON",
            productURL: "https://www.ebay.com/itm/Apple-iPhone-7-A1660-Fully-Unlocked-32GB-Silver-Excellent-/285426294099",
            galleryURL: "https://i.ebayimg.com/thumbs/images/g/BoYAAOSwPsNjbUSU/s-l140.jpg",
            postalCode: "900**",
            storeName: "Cell Store USA",
            storeURL: "http://stores.ebay.com/Cell-Store-USA",
            feedbackScore: "36763",
            positiveFeedbackPercent: "99.8",
            shippingCost: "0.0",
            shipToLocations: "Worldwide",
            handlingTime: "1",
            sellingPrice: "212.49",
            returnsAccepted: "true",
            conditionId: "1000"
        ),
        Product(
            id: "225874664721",
            title: "✅ Apple iPhone XR -64GB - Black (Unlocked) A1984 (CDMA + GSM) Smartphone",
            productURL: "https://www.ebay.com/itm/Apple-iPhone-7-A1660-Fully-Unlocked-32GB-Silver-Excellent-/285426294099",
            galleryURL: "https://i.ebayimg.com/thumbs/images/g/64kAAOSwfsZjRNR4/s-l140.jpg",
            postalCode: "900**",
            storeName: "Cell Store USA",
            storeURL: "http://stores.ebay.com/Cell-Store-USA",
            feedbackScore: "36763",
            positiveFeedbackPercent: "99.8",
            shippingCost: "0.0",
            shipToLocations: "Worldwide",
            handlingTime: "1",
            sellingPrice: "279.99",
            returnsAccepted: "true",
            conditionId: "1000"
        )
    ]
}
