import SwiftUI

struct FavoriteItemView: View {
    
    
    var data: Product
    
    
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
                        HStack{                if(data.conditionId=="1000") {Text("NEW")}
                            else if(data.conditionId=="2000" || data.conditionId=="2500") {Text("REFURBISHED")}
                            else if(data.conditionId=="3000" || data.conditionId=="4000" || data.conditionId=="5000" || data.conditionId=="6000") {Text("USED")}
                            else {Text("NA")}
                            Spacer()
                            Text(data.postalCode)
                                .font(.footnote)
                        }.foregroundColor(.gray)
                            .font(.footnote)
                    }
                }
                
            }
        }
    }
    
}

struct FavoriteItemView_Previews: PreviewProvider {
    static var previews: some View {
        
        FavoriteItemView(data: MockData.mockData[0])
    }
}

