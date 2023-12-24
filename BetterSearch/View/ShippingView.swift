//
//  ShippingView.swift
//  ProductSearch
//
//  Created by 刘艺 on 12/3/23.
//

import SwiftUI

struct ShippingView: View {
    var name:String
    var score:String
    var popularity:String
    var cost:String
    var global:Bool
    var time:String
    var policy:String
    var mode:String
    var within:String
    var paidby:String
    var url:String
    
    
    var body: some View {
        VStack(){
            
            
            
            
            if name != "null" || score != "null" || popularity != "null" {
                
                Divider().frame(height:0.7).background(Color.gray)
                HStack{
                    Image(systemName: "storefront")
                    Text(" Seller")
                    Spacer()
                }
                Divider().frame(height:0.7).background(Color.gray).padding(.bottom,10)
                VStack(alignment:.leading,spacing:10){
                    
                    if name != "null" && url != "null"
                    {
                        HStack{
                            Text("Store Name")
                                .frame(width: 190)
                            Link(destination: URL(string: url)!){
                                Text(name)
                                    .frame(width: 190)
                            }
                        }.padding(.horizontal)
                    }
                    if score != "null"
                    {
                        HStack{
                            Text("Feedback Score")
                                .frame(width: 190)
                            Text(score)
                                .frame(width: 190)
                        }.padding(.horizontal)
                    }
                    if popularity != "null"
                    {
                        HStack{
                            Text("Popularity")
                                .frame(width: 190)
                            
                            Text(popularity)
                                .frame(width: 190)
                        }.padding(.horizontal)
                    }
                }
            }
            
            
            
            if cost != "null" ||  time != "null"
                
            {
                Divider().frame(height:0.7).background(Color.gray).padding(.top,10)
                HStack{
                    Image(systemName: "sailboat")
                    Text(" Shipping Info")
                    Spacer()
                }
                Divider().frame(height:0.7).background(Color.gray).padding(.bottom,10)
                
                
                VStack(alignment:.leading,spacing:10){
                    if cost != "null"
                    {
                        HStack{
                            Text("Shipping Cost")
                                .frame(width: 190)
                            if (cost=="0.0"){
                                Text("FREE")
                                    .frame(width: 190)
                            } else {
                                Text(cost)
                                    .frame(width: 190)
                            }
                        }.padding(.horizontal)
                    }
                   
                        HStack{
                            Text("Global Shipping")
                                .frame(width: 190)
                            
                            if(global){
                                Text("Yes")
                                    .frame(width: 190)
                                 
                            } else {
                                Text("No")
                                    .frame(width: 190)
                                
                            }
                        }.padding(.horizontal)
                   
                    if time != "null"
                        
                    {
                        HStack{
                            Text("Handling Time")
                                .frame(width: 190)
                            
                            Text(time)
                                .frame(width: 190)
                        }.padding(.horizontal)
                    }
                }
            }
            
            if paidby != "null" || policy != "null" || within != "null" || mode != "null" {
                Divider().frame(height:0.7).background(Color.gray).padding(.top,10)
                HStack{
                    Image(systemName: "return")
                    Text(" Return Policy")
                    Spacer()
                }
                Divider().frame(height:0.7).background(Color.gray).padding(.bottom,10)
                VStack(alignment:.leading,spacing:10){
                    if policy != "null" {
                        
                        HStack{
                            Text("Policy")
                                .frame(width: 190)
                            
                            Text(policy)
                                .frame(width: 190)
                        }.padding(.horizontal)
                    }
                    if mode != "null" {
                        HStack{
                            Text("Return Mode")
                                .frame(width: 190)
                            Text(mode)
                                .frame(width: 190).lineLimit(1)
                        }.padding(.horizontal)
                    }
                    if within != "null" {
                        HStack{
                            Text("Return Within")
                                .frame(width: 190)
                            Text(within)
                                .frame(width: 190)
                        }.padding(.horizontal)
                    }
                    if paidby != "null" {
                        HStack{
                            Text("Shipping Cost Paid By")
                                .frame(width: 190)
                            Text(paidby)
                                .frame(width: 190)
                        }.padding(.horizontal)
                    }
                }
            }
        }.padding(.top,-60)
    }
}

#Preview {
    ShippingView(name: "Name", score: "914", popularity: "914", cost: "null", global: false, time: "null", policy: "914", mode: "914", within: "914", paidby: "914",url:"www.apple.com")
}
