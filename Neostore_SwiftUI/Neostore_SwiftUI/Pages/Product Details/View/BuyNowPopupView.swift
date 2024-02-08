//
//  BuyNowPopupView.swift
//  Neostore_SwiftUI
//
//  Created by Neosoft on 08/02/24.
//

import SwiftUI
//MARK: - BuyNowPopupView
struct BuyNowPopupView: View {
    
    var productDetails: ProductDetails?
    //State Objects
    @State var quantity:String = ""
    @ObservedObject var viewModel: ProductDetailsViewModel
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    //body
    var body: some View {
        VStack{
            VStack{
                Text("\(viewModel.productDetails?.name ?? "")")
                    .padding()
                AsyncImage(url: URL(string: viewModel.productDetails?.product_images?[0].image ?? ""))
                { phase in
                    switch phase {
                    case .success(let image):
                        image
                            .resizable()
                    case .failure(_):
                        Image("")
                            .resizable()
                            .scaledToFit()
                    default:
                        ProgressView()
                    }
                }
                .frame(maxWidth: 200,maxHeight: 160)
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(AppColors.grayColor, lineWidth: 1)
                )
                .cornerRadius(5)
                .padding()
                
                Text(Constants.enterQty.rawValue)
                    .padding([.top,.horizontal])
                TextField("", text: $quantity)
                    .frame(maxWidth: 80,maxHeight: 40)
                    .border(AppColors.grayColor,width: 1)
                    .keyboardType(.numberPad)
                Button {
                    
                } label: {
                    Text(ButtonTitles.submit.rawValue)
                        .foregroundColor(.white)
                        .font(.custom(Fonts.bold.rawValue, size: 25))
                        .bold()
                        .padding(10)
                        .frame(maxWidth: .infinity)
                        .background(AppColors.primaryColor)
                        .cornerRadius(5)
                        .padding()
                        .padding(.horizontal,40)
                        .alert(isPresented: $viewModel.vmVars.showAlert) {
                            Alert(title: Text(AlertMessages.noteMsg.rawValue), message: Text(viewModel.vmVars.alertMessage))
                        }
                }
            }
            .background(.white)
            .cornerRadius(10)
            .padding()
            .padding(.vertical,50)
        }
        .frame(maxWidth: .infinity,maxHeight: .infinity)
        .background(.black.opacity(0.2))
    }
}

//preview
struct BuyNowPopupView_Previews: PreviewProvider {
    static var previews: some View {
        BuyNowPopupView(viewModel: ProductDetailsViewModel())
    }
}
