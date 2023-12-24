//
//  DetailScreenModel.swift
//  ProductSearch
//
//  Created by 刘艺 on 12/3/23.
//

import SwiftUI

class DetailViewModel: ObservableObject {
    @Published var detail: ProductDetail = DetailMockData.detailMock
    @Published var isReady: Bool = false

    func fetchItemDetails(itemId: String) {
        if let url = URL(string: "http://localhost:8080/get_item_info?itemId=\(itemId)") {
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data {
                    // Decode your data and update self.detail
                    DispatchQueue.main.async {
                        // Example assuming detail is Codable
                        do {
                            let decodedDetail = try JSONDecoder().decode(ProductDetail.self, from: data)
                            self.detail = decodedDetail
                        } catch {
                            print("Error decoding data: \(error)")
                        }
                        self.isReady = true
                    }
                }
            }.resume()
        }
    }
}

