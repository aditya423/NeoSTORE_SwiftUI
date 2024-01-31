//
//  MyCartView.swift
//  Neostore_SwiftUI
//
//  Created by Neosoft on 15/01/24.
//

import SwiftUI

struct MyCartView: View {
    
    @State private var showPicker = false
    @State private var selectedQuantity = 1
    @StateObject var viewModel = MyCartViewModel()
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                
                Color.red.edgesIgnoringSafeArea(.all)
                    .frame(maxWidth: .infinity, maxHeight: 1)
                
                ZStack {
                    ScrollView {
                        VStack(alignment: .leading) {
                            // ITEM ROWS
                            ForEach(0..<viewModel.total_items) { index in
                                HStack {
                                    AsyncImage(url: URL(string: viewModel.productList?[0].product?.product_images ?? "")) { phase in
                                        switch phase {
                                        case .success(let image):
                                            image
                                                .resizable()
                                                .scaledToFill()
                                        case .failure(_):
                                            Image(systemName: "person.fill")
                                                .resizable()
                                                .scaledToFill()
                                        @unknown default:
                                            ProgressView()
                                        }
                                    }
                                    .frame(width: 50, height: 30)
                                    .padding(.leading, 20)
                                    
                                    VStack {
                                        HStack {
                                            VStack(alignment: .leading) {
                                                Text(viewModel.productList?[0].product?.name ?? "")
                                                Text("(\(viewModel.productList?[0].product?.product_category ?? ""))")
                                                    .foregroundColor(.gray)
                                            }
                                            Spacer()
                                        }
                                        HStack {
                                            Button {
                                                // open pickerview
                                                showPicker.toggle()
                                            } label: {
                                                HStack {
                                                    Text("\(viewModel.productList?[0].quantity ?? 0)")
                                                    Image(systemName: ImageNames.downArrow.rawValue)
                                                }
                                            }
                                            .padding(10)
                                            .background(AppColors.grayColor)
                                            .foregroundColor(.black)
                                            .cornerRadius(5)
                                            Spacer()
                                            Text("₹45.00")
                                                .padding(.trailing, 20)
                                        }
                                    }
                                    .padding(.leading, 20)
                                }
                                .padding([.top, .bottom], 15)
                                .background(.white)
                                //}
                                
                                // TOTAL ROW
                                HStack {
                                    Text("TOTAL")
                                        .padding(.leading, 20)
                                    Spacer()
                                    Text("₹180.00")
                                        .padding(.trailing, 20)
                                }
                                .padding(.top, 20)
                                .padding(.bottom, 10)
                                
                                // BUTTON
                                NavigationLink(destination: HomeView()) {
                                    Button {
                                        // navigate to add address
                                    } label: {
                                        Text("ORDER NOW")
                                            .foregroundColor(.white)
                                            .font(.system(size: 25))
                                            .bold()
                                            .padding(10)
                                            .frame(maxWidth: .infinity)
                                    }
                                }
                                .background(.red)
                                .cornerRadius(5)
                                .padding(.top, 30)
                                .padding([.leading, .trailing], 20)
                                .alert(isPresented: $viewModel.vmVars.showAlert) {
                                    Alert(title: Text(AlertMessages.noteMsg.rawValue), message: Text(viewModel.vmVars.alertMessage))
                                }
                            }
                        }
                    }
                    .frame(maxWidth: .infinity)
                    
                    if showPicker {
                        VStack(spacing: 0) {
                            Spacer()
                            HStack {
                                Spacer()
                                Button(action: {
                                    showPicker = false
                                }) {
                                    Text("Done")
                                        .foregroundColor(.blue)
                                        .padding(.horizontal)
                                }
                            }
                            .frame(height: 30)
                            .background(Color.yellow)
                            
                            Picker(selection: $selectedQuantity, label: Text("Select Quantity")) {
                                ForEach(1..<11) { number in
                                    Text("\(number)")
                                }
                            }
                            .pickerStyle(WheelPickerStyle())
                            .background(Color.white)
                            .frame(width: geometry.size.width, height: 200, alignment: .bottom)
                        }
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden()
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Image(systemName: ImageNames.backArrow.rawValue)
                        .font(.title3)
                        .foregroundColor(.white)
                        .bold()
                        .onTapGesture {
                            presentationMode.wrappedValue.dismiss()
                        }
                }
                ToolbarItem(placement: .principal) {
                    Text("My Cart")
                        .font(.title2)
                        .foregroundColor(.white)
                        .bold()
                }
            }
            .toolbarBackground(
                Color.red,
                for: .navigationBar
            )
        }
        .onAppear {
            viewModel.vmVars.isLoading = true
            viewModel.getCartItemsList()
        }
    }
}

struct MyCartView_Previews: PreviewProvider {
    static var previews: some View {
        MyCartView()
    }
}
