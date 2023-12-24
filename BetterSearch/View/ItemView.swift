//
//  ItemView.swift
//  ProductSearch
//
//  Created by 刘艺 on 12/2/23.
//

import SwiftUI

struct ItemView: View {
    
    
    var data: Product
    @Binding var list: [Product]
    
    func addProduct(product: Product) {
        var urlString = "http://localhost:8080/addProduct?"
        
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
        
        HStack{
            AsyncImage(url : URL(string: data.galleryURL)) { image in
                image.resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width:120,height:90)
            } placeholder: {
                Image("placeholder")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width:120,height:90)
            }
            
            VStack(alignment: .leading){
                Text(data.title)
                    .font(.footnote)
                    .lineLimit(1)
                    .truncationMode(.tail).padding(.trailing,20)
                HStack{
                    VStack(alignment: .leading){
                        Text("$"+data.sellingPrice)
                            .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                            .bold()
                        
                        Text(data.shippingCost=="0.0" ? "FREE SHIPPING": "$"+data.shippingCost)
                            .foregroundColor(.gray)
                            .font(.footnote)

                        
                    }
                    Spacer()
                    VStack(alignment: .center, content: {
                        
                        if(list.contains{ product in
                            return product.id == data.id
                        }){
                            Image(systemName: "heart.fill")
                                .foregroundColor(.red)
                                .onTapGesture {
                                    removeProduct(product: data)
                                    list.removeAll{$0.id == data.id }
                                }

                            
                        } else {
                            Image(systemName: "heart")
                                .foregroundColor(.red)
                                .onTapGesture {
                                    addProduct(product: data)
                                    list.append(data)
                                }

                        
                        }
                        
                        
                    })
        
                    
                }
                
                HStack{
                    Text(data.postalCode)
                        .font(.footnote)
                    Spacer()
                    if(data.conditionId=="1000") {Text("NEW")}
                    else if(data.conditionId=="2000" || data.conditionId=="2500") {Text("REFURBISHED")}
                    else if(data.conditionId=="3000" || data.conditionId=="4000" || data.conditionId=="5000" || data.conditionId=="6000") {Text("USED")}
                    else {Text("NA")}
                    
                }.foregroundColor(.gray)
                    .font(.footnote)
            }
        }
    }
}

struct ItemView_Previews: PreviewProvider {
    static var previews: some View {
        
        ItemView(data: MockData.mockData[0],list:.constant(MockData.mockData))
    }
}

