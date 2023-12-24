//
//  SimilarProductGridView.swift
//  ProductSearch
//
//  Created by 刘艺 on 12/3/23.
//

import SwiftUI

struct SimilarProductGridView: View {
    
    let itemId:String
    
    let columns: [GridItem] = [GridItem(.flexible()),
                               GridItem(.flexible())]
    @State var defaultList:[SimilarProduct] = []
    @State var similarProduct:[SimilarProduct] = []
    
    @State private var sortby = 0
    @State private var order = 0
    @State private var isReady = false
    
    
    var body: some View {
        
        VStack {
            
            if(!isReady){
                LoadingView().padding(.top,350)
            } else {
                VStack(spacing:15){
                    HStack{
                        Text("Sort By").font(.title2).bold()
                        
                        Spacer()
                    }
                    VStack {
                        Picker("SortBy?", selection: $sortby) {
                            Text("Default").tag(0)
                            Text("Name").tag(1)
                            Text("Price").tag(2)
                            Text("Days Left").tag(3)
                            Text("Shipping").tag(4)
                        }
                        .pickerStyle(.segmented)
                        .onChange(of: sortby) { _ in
                            if(sortby==1){
                                similarProduct.sort { (lhs: SimilarProduct, rhs: SimilarProduct) -> Bool in
                                    if(order==0){
                                        return lhs.title < rhs.title
                                    } else {
                                        return lhs.title > rhs.title
                                    }
                                }
                            } else if(sortby==2){
                                similarProduct.sort { (lhs: SimilarProduct, rhs: SimilarProduct) -> Bool in
                                    let lp = Double(lhs.price.trimmingCharacters(in: .init(charactersIn: "$"))) ?? 0.0
                                    let rp = Double(rhs.price.trimmingCharacters(in: .init(charactersIn: "$"))) ?? 0.0
                                    
                                    if(order==0){
                                        return lp < rp
                                    } else {
                                        return lp > rp
                                    }
                                }
                            } else if(sortby==3){
                                similarProduct.sort { (lhs: SimilarProduct, rhs: SimilarProduct) -> Bool in
                                    let lhsDays = lhs.days.components(separatedBy: CharacterSet.decimalDigits.inverted)
                                        .compactMap { Int($0) }
                                        .first ?? 0
                                    let rhsDays = rhs.days.components(separatedBy: CharacterSet.decimalDigits.inverted)
                                        .compactMap { Int($0) }
                                        .first ?? 0
                                    if(order==0){
                                        return lhsDays < rhsDays
                                    } else {
                                        return lhsDays > rhsDays
                                    }
                                }
                            }else if(sortby==4){
                                similarProduct.sort { (lhs: SimilarProduct, rhs: SimilarProduct) -> Bool in
                                    if(order==0){
                                        return lhs.shipping < rhs.shipping
                                    } else {
                                        return lhs.shipping > rhs.shipping
                                    }
                                }
                            } else {
                                similarProduct = defaultList
                            }
                        }
                        
                    }
                    
                    if(sortby != 0){
                        HStack{
                            Text("Order").font(.title2).bold()
                            
                            Spacer()
                        }
                        VStack {
                            Picker("SortBy?", selection: $order) {
                                Text("Ascending").tag(0)
                                Text("Descending").tag(1)
                            }
                            .pickerStyle(.segmented)
                            .onChange(of: order) { _ in
                                if(sortby==1){
                                    similarProduct.sort { (lhs: SimilarProduct, rhs: SimilarProduct) -> Bool in
                                        if(order==0){
                                            return lhs.title < rhs.title
                                        } else {
                                            return lhs.title > rhs.title
                                        }
                                    }
                                } else if(sortby==2){
                                    similarProduct.sort { (lhs: SimilarProduct, rhs: SimilarProduct) -> Bool in
                                        let lp = Double(lhs.price.trimmingCharacters(in: .init(charactersIn: "$"))) ?? 0.0
                                        let rp = Double(rhs.price.trimmingCharacters(in: .init(charactersIn: "$"))) ?? 0.0
                                        
                                        if(order==0){
                                            return lp < rp
                                        } else {
                                            return lp > rp
                                        }
                                    }
                                } else if(sortby==3){
                                    similarProduct.sort { (lhs: SimilarProduct, rhs: SimilarProduct) -> Bool in
                                        let lhsDays = lhs.days.components(separatedBy: CharacterSet.decimalDigits.inverted)
                                            .compactMap { Int($0) }
                                            .first ?? 0
                                        let rhsDays = rhs.days.components(separatedBy: CharacterSet.decimalDigits.inverted)
                                            .compactMap { Int($0) }
                                            .first ?? 0
                                        if(order==0){
                                            return lhsDays < rhsDays
                                        } else {
                                            return lhsDays > rhsDays
                                        }
                                    }
                                }else if(sortby==4){
                                    similarProduct.sort { (lhs: SimilarProduct, rhs: SimilarProduct) -> Bool in
                                        if(order==0){
                                            return lhs.shipping < rhs.shipping
                                        } else {
                                            return lhs.shipping > rhs.shipping
                                        }
                                    }
                                } else {
                                    similarProduct = defaultList
                                }
                            }
                            
                        }
                    }
                    ScrollView{
                        LazyVGrid(columns: columns, spacing: 10) {
                            ForEach(similarProduct, id: \.id) { product in
                                SimilarProductView(product: product)
                            }
                        }
                    }
                    
                }}
    }
        .padding(.top,-40)
        .padding(.horizontal)
 .task {
            if let url = URL(string: "http://localhost:8080/get_similar?itemId=\(itemId)") {
                URLSession.shared.dataTask(with: url) { data, response, error in
                    if let data = data {
                        // Decode your data and update self.detail
                        DispatchQueue.main.async {
                            // Example assuming detail is Codable
                            do {
                                let decodedDetail = try JSONDecoder().decode([SimilarProduct].self, from: data)
                                self.defaultList = decodedDetail
                                self.similarProduct = decodedDetail
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
    
}

struct SimilarProductGridView_Previews: PreviewProvider {
    static var previews: some View {
        let data = "225245645838"
        return SimilarProductGridView(itemId: data)
    }
}

