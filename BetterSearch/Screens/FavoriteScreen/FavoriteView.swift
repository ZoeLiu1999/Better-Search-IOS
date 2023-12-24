//
//  FavoriteView.swift
//  ProductSearch
//
//  Created by 刘艺 on 12/4/23.
//

import SwiftUI

struct FavoriteView: View {
    
    @Binding var list:[Product]
    

    
    func removeProduct(product: Product) {
        var urlString = "http://localhost:8080/removeProduct?"
        
        urlString += "id=\(product.id)&"
        urlString += "title=\(product.title.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")&"
        urlString += "productURL=\(product.productURL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")&"
        urlString += "galleryURL=\(product.galleryURL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")&"
        urlString += "postalCode=\(product.postalCode.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")&"
        urlString += "storeName=\(product.storeName.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")&"
        urlString += "storeURL=\(product.storeURL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")&"
        urlString += "feedbackScore=\(product.feedbackScore.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")&"
        urlString += "positiveFeedbackPercent=\(product.positiveFeedbackPercent.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")&"
        urlString += "shippingCost=\(product.shippingCost.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")&"
        urlString += "shipToLocations=\(product.shipToLocations.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")&"
        urlString += "handlingTime=\(product.handlingTime.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")&"
        urlString += "sellingPrice=\(product.sellingPrice.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")&"
        urlString += "returnsAccepted=\(product.returnsAccepted.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")&"
        urlString += "conditionId=\(product.conditionId.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")"
        
        print(urlString)
        
        guard let finalURL = URL(string: urlString) else {
            print(urlString)
            return
        }
        
        Task{
            do {
                let (data, _) = try await URLSession.shared.data(from: finalURL)
                let decoder = JSONDecoder()
                let results = try decoder.decode(String.self, from: data)
                DispatchQueue.main.async {
                    print(results)
                }
            } catch {
                DispatchQueue.main.async {
                    print("Error fetching suggestions:", error)
                }
            }
        }
    }
    
    var body: some View {
        NavigationView {
            VStack{
                if(list.isEmpty){
                    Text("No items in whishlist")
                }else{
                    
                    List{
                        HStack{
                            Text("Wishlist total(\(list.count)) items:")
                            Spacer()
                            Text("$\(String(format: "%.2f", list.reduce(0) { $0 + ($1.numericSellingPrice ?? 0.0) }))")
                            
                        }
                        
                        ForEach(list.indices, id: \.self) { index in
                            FavoriteItemView(data: list[index])
                        }
                        .onDelete(perform: { indexSet in
                            let indexesToRemove = Array(indexSet)
                            indexesToRemove.forEach { index in
                                if index < list.count {
                                    removeProduct(product: list[index])
                                    list.remove(at: index)
                                }
                            }
                        })
                    }
                }
            }
                .navigationTitle("Favorites")
        }.padding(.top,-90)
    }
}

struct FavoriteView_Previews: PreviewProvider {
    static var previews: some View {
        return FavoriteView(list: .constant(MockData.mockData))
    }
}

