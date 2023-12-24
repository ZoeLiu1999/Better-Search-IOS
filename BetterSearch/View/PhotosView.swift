//
//  PhotosView.swift
//  ProductSearch
//
//  Created by 刘艺 on 12/3/23.
//

import SwiftUI

struct PhotosView: View {
    
    var title:String
    @StateObject private var viewModel = PhotosViewModel()
    
    var body: some View {
        VStack{
            if(!viewModel.isReady){
                LoadingView().padding(.top,300)
            } else {
                                    HStack {
                        Text("Powered by")
                        Image("google")
                            .resizable()
                            .frame(width: 90, height: 30)
                            .aspectRatio(contentMode: .fit)
                    }
                    
                    // Vertically stack images
                    ScrollView {
                        ForEach(viewModel.urls, id: \.self) { url in
                            // Load your image using AsyncImage or another method
                            AsyncImage(url: URL(string: url)) { phase in
                                switch phase {
                                case .empty:
                                    ProgressView()
                                case .success(let image):
                                    image
                                        .resizable()
                                        .scaledToFit()
                                        .padding(.horizontal,75)
                                case .failure:
                                    Text("")
                                @unknown default:
                                    fatalError("Unknown case in AsyncImage loading.")
                                }
                            
                        }
                    }
                } .padding(.top,-10)
            }
        
        }
        .task {
            viewModel.fetchPhotos(title: title)
        }
    }
}

struct PhotosView_Previews: PreviewProvider {
    static var previews: some View {
        let data = "mamamia"
        return PhotosView(title: data)
    }
}
