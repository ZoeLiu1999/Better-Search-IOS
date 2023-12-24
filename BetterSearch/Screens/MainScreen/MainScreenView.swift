//
//  MainScreenView.swift
//  BetterSearch
//
//  Created by 刘艺 on 12/13/23.
//

import SwiftUI

struct MainScreenView: View { //view
    
    
    
    @StateObject var viewModel = MainScreenViewModel()
    
    
    
    let categories = ["All", "Art", "Baby", "Books", "Clothing, Shoes & Accessories", "Computers/Tablets & Networking", "Health & Beauty", "Music", "Video Games & Consoles"]
    
    
    var body: some View { //body
        
        NavigationStack {
            ZStack{
                Form {
                    //Form
                    Section{
                        //Keyword
                        HStack() {
                            Text("Keyword:")
                                .foregroundColor(.black)
                            
                            TextField("Required", text: $viewModel.keyword)
                        }
                        
                        //Category
                        Picker("Category", selection: $viewModel.selectedCategory) {
                            ForEach(categories, id: \.self) { category in
                                Text(category)
                            }
                        }
                        
                        //Condition
                        VStack(alignment: .leading){
                            Text("Condition")
                            HStack(spacing: 20.0){
                                Toggle(isOn: $viewModel.isNew) { Text("New") }.toggleStyle(CheckboxToggleStyle())
                                Toggle(isOn: $viewModel.isUsed) { Text("Used") }.toggleStyle(CheckboxToggleStyle())
                                Toggle(isOn: $viewModel.isUnspecified) { Text("Unspecified") }.toggleStyle(CheckboxToggleStyle())
                            }.padding(.horizontal, 18.0)
                        }
                        
                        //Shipping
                        VStack(alignment: .leading){
                            Text("Shipping")
                            HStack(spacing: 20.0){
                                Toggle(isOn: $viewModel.isPickup) { Text("Pickup") }.toggleStyle(CheckboxToggleStyle())
                                Toggle(isOn: $viewModel.isFreeShipping) { Text("Free Shipping") }.toggleStyle(CheckboxToggleStyle())
                            }.padding(.horizontal, 38.0)
                        }
                        
                        //Distance
                        HStack() {
                            Text("Distance:")
                                .foregroundColor(.black)
                            
                            TextField("10", text: $viewModel.distance)
                        }
                        
                        //Custom location
                        Toggle("Custom location",isOn: $viewModel.useCustomLocation)
                        
                        if viewModel.useCustomLocation {
                            HStack{
                                Text("Zipcode: ")
                                    .foregroundColor(.black)
                                TextField("", text: $viewModel.zipcode)
                            }
                            .sheet(isPresented: $viewModel.showZipcodeSheet) {
                                ZipcodeSheetView(showZipcodeSheet: $viewModel.showZipcodeSheet,zipcode: $viewModel.zipcode, suggestions : viewModel.suggestions)
                            }
                        }
                        
                        
                        // Buttons Section
                        
                        HStack(spacing: 25.0) {
                            Button("Submit"){
                                viewModel.onFormSubmit()
                            }.buttonStyle(FormButtonStyle())
                            Button("Clear"){
                                viewModel.clear()
                            }.buttonStyle(FormButtonStyle())
                        }.padding(.horizontal, 45.0)
                    }
                    
                    if(viewModel.showSearchResult){
                        Section{
                            Text("Results").font(.largeTitle).bold()
                            if(viewModel.isLoading){
                                LoadingView()
                            } else{
                                if(viewModel.searchResults.isEmpty){
                                    Text("No results found.").foregroundStyle(Color.red)
                                }else{
                                    ForEach(viewModel.searchResults){ product in
                                        NavigationLink(value:product){
                                            ItemView(data:product,list:$viewModel.favorite)
                                        }
                                    }
                                }

                            }
                            
                        }
                    }
                    
                    
                    
                } //Form
                
                .onChange(of: viewModel.debouncedZipcode){zipcode in
                    print(zipcode)
                    viewModel.getSuggestions()
                    
                }
                .navigationTitle(Text("Product search"))
                .navigationBarItems(
                    trailing:
                            NavigationLink(destination: FavoriteView(list:$viewModel.favorite).ignoresSafeArea()){
                                                Image(systemName: "heart.circle")
                                                    .foregroundColor(.blue)
                                                    .padding()
                                            }
                        
                )
                .navigationDestination(for: Product.self){ item in
                    DetailTabView(product: item)
                        .navigationBarItems(trailing:
                                 HStack{
                            
                            Link(destination: URL(string: "https://www.facebook.com/sharer/sharer.php?u=\(item.productURL)")!){
                                Image("fb")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 28, height: 28)
                                    .padding(.horizontal, 5)
                            }
                                             
                            if(viewModel.favorite.contains{ product in
                                return product.id == item.id
                            }){
                                Button(action:{
                                    viewModel.removeProduct(product: item)
                                    viewModel.favorite.removeAll{$0.id == item.id}
                                }){
                                    Image(systemName: "heart.fill")
                                        .foregroundColor(.red)
                                }
                                
                            } else {
                                Button(action:{
                                    viewModel.addProduct(product: item)
                                    viewModel.favorite.append(item)
                                }){
                                    Image(systemName: "heart")
                                        .foregroundColor(.red)
                                }
                            }
                                 }
                             
                         )
                }
                
                
                if(viewModel.showError){
                    VStack{
                        Spacer()
                        FormValidationErrorView()
                    }
                }
            }
            
        } //NevigationView
        .task {
            viewModel.retrieveFavorite()
        }
    } //Body
    
} //View


#Preview {
    MainScreenView()
}


struct FormButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(width: 70, height: 20)
            .padding()
            .foregroundColor(.white)
            .background(Color.blue)
            .cornerRadius(8)
    }
}


struct CheckboxToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            RoundedRectangle(cornerRadius: 2.0)
                .stroke(Color.gray, lineWidth: 1)
                .frame(width: 15, height: 15)
                .background(
                    RoundedRectangle(cornerRadius: 2.0)
                        .fill(configuration.isOn ? Color.blue : Color.clear)
                )
                .overlay {
                    Image(systemName: configuration.isOn ? "checkmark" : "")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 10, height: 10)
                        .foregroundColor(.white)
                }
                .onTapGesture {
                    configuration.isOn.toggle()
                }

            configuration.label
        }
    }
}
