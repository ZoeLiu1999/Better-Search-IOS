//
//  ImageSliderView.swift
//  ProductSearch
//
//  Created by 刘艺 on 12/3/23.
//

import SwiftUI

struct ImageSliderView: View {
    var images: [String]
    @State private var currentPage = 0

    var body: some View {
        VStack {
            TabView(selection: $currentPage) {
                ForEach(images.indices, id: \.self) { index in
                    AsyncImage(url: URL(string: images[index])) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                        case .success(let image):
                            image
                                .resizable()
                                .scaledToFit()
                        case .failure:
                            Image(systemName: "exclamationmark.icloud")
                                .imageScale(.large)
                                .foregroundColor(.red)
                        @unknown default:
                            fatalError("Unknown case in AsyncImage loading.")
                        }
                    }
                    .tag(index)
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
            .frame(height: 300) // Adjust the height as needed
        }
    }
}


struct ImageSliderView_Previews: PreviewProvider {
    static var previews: some View {
        let mockImages = DetailMockData.detailMock.pictureURL
        return ImageSliderView(images: mockImages)
    }
}

