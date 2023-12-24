//
//  ProductDetail.swift
//  BetterSearch
//
//  Created by 刘艺 on 12/13/23.
//

import Foundation

struct ProductDetail: Codable,Identifiable,Hashable {
    let id: String
    let pictureURL: [String]
    let feedbackScore: String
    let positiveFeedbackPercent: String
    let nameValueList: [NameValue]
    let storeURL: String
    let storeName: String
    let returnMode: String
    let returnsWithin: String
    let returnsAccepted: String
    let shippingCostPaidBy: String
    let globalShipping: Bool
    let HandlingTime: String
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(pictureURL)
        hasher.combine(feedbackScore)
        hasher.combine(positiveFeedbackPercent)
        hasher.combine(nameValueList)
        hasher.combine(storeURL)
        hasher.combine(storeName)
        hasher.combine(returnMode)
        hasher.combine(returnsWithin)
        hasher.combine(returnsAccepted)
        hasher.combine(shippingCostPaidBy)
        hasher.combine(globalShipping)
    }
}

struct NameValue: Codable,Hashable {
    let Name: String
    let Value: [String]
}


extension NameValue: Equatable {
    static func == (lhs: NameValue, rhs: NameValue) -> Bool {
        return lhs.Name == rhs.Name &&
            lhs.Value == rhs.Value
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(Name)
        hasher.combine(Value)
    }
}

extension ProductDetail: Equatable {
    static func == (lhs: ProductDetail, rhs: ProductDetail) -> Bool {
        return lhs.id == rhs.id &&
            lhs.pictureURL == rhs.pictureURL &&
            lhs.feedbackScore == rhs.feedbackScore &&
            lhs.positiveFeedbackPercent == rhs.positiveFeedbackPercent &&
            lhs.nameValueList == rhs.nameValueList &&
            lhs.storeURL == rhs.storeURL &&
            lhs.storeName == rhs.storeName &&
            lhs.returnsWithin == rhs.returnsWithin &&
            lhs.returnsAccepted == rhs.returnsAccepted &&
            lhs.shippingCostPaidBy == rhs.shippingCostPaidBy &&
            lhs.globalShipping == rhs.globalShipping
    }
}

struct DetailMockData {
    static let detailMock: ProductDetail = ProductDetail(
        id: "225874664321",
        pictureURL: [
            "https://i.ebayimg.com/00/s/MTA4MFgxMDgw/z/WKMAAOSwexVlVn91/$_1.JPG?set_id=880000500F",
            "https://i.ebayimg.com/00/s/MTA4MFgxMDgw/z/w40AAOSwGcZlVn91/$_1.JPG?set_id=880000500F",
            "https://i.ebayimg.com/00/s/MTA4MFgxMDgw/z/CXcAAOSwto5lVn91/$_1.JPG?set_id=880000500F",
            "https://i.ebayimg.com/00/s/MTA4MFgxMDgw/z/DB8AAOSw1FFlVn91/$_1.JPG?set_id=880000500F",
            "https://i.ebayimg.com/00/s/MTA4MFgxMDgw/z/eSAAAOSwdTdlVn91/$_1.JPG?set_id=880000500F",
            "https://i.ebayimg.com/00/s/MTA4MFgxMDgw/z/gIgAAOSwvsplVn95/$_1.JPG?set_id=880000500F",
            "https://i.ebayimg.com/00/s/MTA4MFgxMDgw/z/BEgAAOSw2WZlVn91/$_1.JPG?set_id=880000500F",
            "https://i.ebayimg.com/00/s/MTA4MFgxMDgw/z/w5EAAOSw3ARlVn91/$_1.JPG?set_id=880000500F",
            "https://i.ebayimg.com/00/s/MTA4MFgxMDgw/z/WOQAAOSwK8NlVn91/$_1.JPG?set_id=880000500F",
            "https://i.ebayimg.com/00/s/MTA4MFgxMDgw/z/orYAAOSwFwdlVn91/$_1.JPG?set_id=880000500F",
            "https://i.ebayimg.com/00/s/MTA4MFgxMDgw/z/GfkAAOSw3hllVn91/$_1.JPG?set_id=880000500F",
            "https://i.ebayimg.com/00/s/MTA4MFgxMDgw/z/esUAAOSwYv5lVn91/$_1.JPG?set_id=880000500F"
        ],
        feedbackScore: "129219",
        positiveFeedbackPercent: "99.6",
        nameValueList: [
            NameValue(Name: "Type", Value: ["Wristwatch"]),
            NameValue(Name: "Brand", Value: ["Fossil"]),
            NameValue(Name: "Department", Value: ["Men"])
        ],
        storeURL: "https://www.ebay.com/str/ukcancerresearch",
        storeName: "Cancer Research UK",
        returnMode:"Money Back",
        returnsWithin: "30 days",
        returnsAccepted: "Returns Accepted",
        shippingCostPaidBy: "Buyer",
        globalShipping: true,
        HandlingTime:"1"
    )
}

