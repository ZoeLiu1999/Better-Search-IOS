//
//  MainScreenViewModel.swift
//  BetterSearch
//
//  Created by 刘艺 on 12/13/23.
//

import SwiftUI

@MainActor final class MainScreenViewModel: ObservableObject{
    @Published var keyword: String = ""
    @Published var selectedCategory: String = "All"
    @Published var isNew: Bool = false
    @Published var isUsed: Bool = false
    @Published var isUnspecified: Bool = false
    @Published var isPickup: Bool = false
    @Published var isFreeShipping: Bool = false
    @Published var distance: String = ""
    @Published var useCustomLocation: Bool = false
    @Published var zipcode: String = ""
    @Published var showZipcodeSheet: Bool = false
    @Published var suggestions: [String] = []
    @Published var showError: Bool = false
    @Published var showSearchResult = false
    @Published var searchResults: [Product] = []
    @Published var isLoading: Bool = false;
    @Published var favorite: [Product] = MockData.mockData
    
    
    @Published var debouncedZipcode = ""
    
    init() {
        setupZipcodeDebounce()
    }
    
    func setupZipcodeDebounce() {
        debouncedZipcode = self.zipcode
        $zipcode
            .debounce(for: .seconds(0.4), scheduler: RunLoop.main)
            .assign(to: &$debouncedZipcode)
    }
    
    
    func clear() {
        keyword = ""
        selectedCategory = "All"
        isNew = false
        isUsed = false
        isUnspecified = false
        isPickup = false
        isFreeShipping = false
        distance = ""
        useCustomLocation = false
        zipcode = ""
        showSearchResult = false
        searchResults = []
    }
    
    func onFormSubmit(){
        if(keyword.count==0){
            self.showError = true
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                self.showError = false
            }
        } else {
            self.showSearchResult = true
            self.isLoading = true
            guard let finalURL = generateSearchURL() else {
                print("Error generating URL")
                return
            }
            self.showSearchResult = true
            
            Task{
                do {
                    let (data, _) = try await URLSession.shared.data(from: finalURL)
                    let decoder = JSONDecoder()
                    let results = try decoder.decode([Product].self, from: data)
                    DispatchQueue.main.async {
                        self.searchResults = results
                        self.isLoading = false
                    }
                } catch {
                    DispatchQueue.main.async {
                        print("Error fetching suggestions:", error)
                    }
                }
            }
            
        }
    }
    

    func getSuggestions(){
        
        if(self.debouncedZipcode.count<5){
            guard let url = URL(string: "http://localhost:8080/autocomplete-location?query=\(debouncedZipcode)") else {
                print("http://localhost:8080/autocomplete-location?query=\(debouncedZipcode)")
                return
            }
            
            Task{
                do {
                    let (data, _) = try await URLSession.shared.data(from: url)
                    let decoder = JSONDecoder()
                    let suggestionsArray = try decoder.decode([String].self, from: data)
                    DispatchQueue.main.async {
                        self.suggestions = suggestionsArray
                        self.showZipcodeSheet = true
                    }
                } catch {
                    print("Error fetching suggestions:", error)
                }
            }
        }
        
    }
    
    func generateSearchURL() -> URL? {
        var urlString = "http://localhost:8080/search?keyword=\(self.keyword)"
        
        // Append category if selected
        if selectedCategory != "All" {
            let categories = [
                "Art": "550",
                "Baby": "2984",
                "Books": "267",
                "Clothing, Shoes & Accessories": "11450",
                "Computers/Tablets & Networking": "58058",
                "Health & Beauty": "26395",
                "Music": "11233",
                "Video Games & Consoles": "1249"
            ]
            if let categoryId = categories[selectedCategory] {
                urlString.append("&categoryId=\(categoryId)")
            }
        }
        
        // Append conditions based on isNew and isUsed
        if isNew {
            urlString.append("&New=true")
        }
        if isUsed {
            urlString.append("&Used=true")
        }
        
        // Append local_pickup and free_shipping conditions
        if isPickup {
            urlString.append("&local_pickup=true")
        }
        if isFreeShipping {
            urlString.append("&free_shipping=true")
        }
        
        // Append distance if available, else default to 10
        let distanceValue = self.distance.isEmpty ? "10" : self.distance
        urlString.append("&distance=\(distanceValue)")
        
        // Append custom location or zipcode
        if useCustomLocation {
            urlString.append("&zipcode=\(self.zipcode)")
        } else {
            urlString.append("&zipcode=90015")
        }
        
        // Convert the string URL to URL type
        return URL(string: urlString)
    }
    
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
    
    func retrieveFavorite(){
        guard let finalURL = URL(string: "http://localhost:8080/getWishList") else {
            print("url error")
            return
        }
        
        Task{
            do {
                let (data, _) = try await URLSession.shared.data(from: finalURL)
                let decoder = JSONDecoder()
                let results = try decoder.decode([Product].self, from: data)
                DispatchQueue.main.async {
                    self.favorite = results
                }
            } catch {
                DispatchQueue.main.async {
                    print("Error fetching suggestions:", error)
                }
            }
        }
    }
    

}
