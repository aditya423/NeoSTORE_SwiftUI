//
//  RateNowPopupView.swift
//  Neostore_SwiftUI
//
//  Created by Neosoft on 08/02/24.
//

import SwiftUI
//MARK: - RateNowPopupView
struct RateNowPopupView: View {
    
    var productDetails: ProductDetails?
    //State Object
    @State var rating: Int = 0
    @ObservedObject var viewModel: ProductDetailsViewModel
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    //Body
    var body: some View {
        VStack{
            VStack{
                Text("\(productDetails?.name ?? "")")
                    .padding()
                AsyncImage(url: URL(string: productDetails?.product_images?[0].image ?? ""))
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
                
                HStack{
                    HStack(spacing: 2) {
                        ForEach(1...5, id: \.self) { i in
                                Image( i <= rating ? ImageNames.filledStar.rawValue : ImageNames.emptyStar.rawValue)
                                    .resizable()
                                    .frame(width: 40, height: 40)
                                    .onTapGesture {
                                        if i == 1 && rating == 1{
                                            rating = 0
                                        } else {
                                            rating = i
                                        }
                                    }
                            }
                        }
                        .frame(maxWidth: .infinity,maxHeight: 15)
                        .padding()
                }
                Button {
                    
                } label: {
                    Text(ButtonTitles.rateNow.rawValue)
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

struct RateNowPopupView_Previews: PreviewProvider {
    static var previews: some View {
        RateNowPopupView(viewModel: ProductDetailsViewModel())
    }
}
