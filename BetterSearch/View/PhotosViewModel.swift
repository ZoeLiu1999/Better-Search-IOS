//
//  PhotosViewModel.swift
//  ProductSearch
//
//  Created by 刘艺 on 12/3/23.
//

import Foundation


class PhotosViewModel: ObservableObject {
    @Published var urls: [String] = []
    @Published var isReady: Bool = false

    func fetchPhotos(title: String) {
        if let url = URL(string: "http://localhost:8080/get_item_photo?itemTitle=\(title)") {
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data {
                    // Decode your data and update self.detail
                    DispatchQueue.main.async {
                        // Example assuming detail is Codable
                        do {
                            let decodedDetail = try JSONDecoder().decode([String].self, from: data)
                            self.urls = decodedDetail
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
