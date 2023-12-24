//
//  DetailTabView.swift
//  ProductSearch
//
//  Created by 刘艺 on 12/3/23.
//

import SwiftUI

struct DetailTabView: View {
    var product: Product
    @StateObject private var viewModel = DetailViewModel()
    
    var body: some View {
        
        TabView {
            // Info Tab
            VStack(alignment: .leading, spacing:5){
                if(!viewModel.isReady){
                    LoadingView()
                } else
                {
                    ImageSliderView(images:viewModel.detail.pictureURL)
                    Text(product.title).padding(.horizontal)
                    Text("$"+product.sellingPrice).foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/).bold().padding(.horizontal)
                    HStack{
                        Image(systemName: "magnifyingglass")
                        Text(" Description")
                    }.padding(.horizontal)
                    NameValueListView(currList:viewModel.detail.nameValueList)
                }
            }
            .tabItem {
                Label("Info", systemImage: "info.circle")
            }
            
            // Shipping Tab
            ShippingView(name: viewModel.detail.storeName, score: viewModel.detail.feedbackScore, popularity: viewModel.detail.positiveFeedbackPercent, cost: product.shippingCost, global: viewModel.detail.globalShipping, time: viewModel.detail.HandlingTime, policy:viewModel.detail.returnsAccepted, mode: viewModel.detail.returnMode, within: viewModel.detail.returnsWithin, paidby: viewModel.detail.returnsWithin,url:viewModel.detail.storeURL)
                .tabItem {
                    Label("Shipping", systemImage: "shippingbox")
                }
            
            // Photos Tab
            PhotosView(title:product.title)
                .tabItem {
                    Label("Photos", systemImage: "photo.on.rectangle")
                }
            
            // Similar Tab
            SimilarProductGridView(itemId: product.id)
                .tabItem {
                    Label("Similar", systemImage: "list.bullet.indent")
                }
        }
        .task {
            viewModel.fetchItemDetails(itemId: product.id)
        }
    }
}

struct DetailTabView_Previews: PreviewProvider {
    static var previews: some View {
        let data = MockData.mockData[0]
        return DetailTabView(product: data)
    }
}
