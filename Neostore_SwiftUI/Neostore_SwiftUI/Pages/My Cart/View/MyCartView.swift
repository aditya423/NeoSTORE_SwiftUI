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
    @State private var isLoading = true
    @State private var isPresentingAlert = false
    @State private var deleteIndex = 0
    @State private var editIndex = 0
    @StateObject var viewModel = MyCartViewModel()
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        
        GeometryReader { geometry in
            VStack(spacing: 0) {
                
                Color.red.edgesIgnoringSafeArea(.all)
                    .frame(maxWidth: .infinity, maxHeight: 1)
                
                ZStack {
                    if viewModel.vmVars.isLoading {
                        LoaderView(bgColor: AppColors.grayColor, tintColor: Color.red)
                    } else {
                        List {
                            // ITEM ROWS
                            ForEach(0..<(viewModel.vmVars.productList?.count ?? 0), id: \.self) { indexRow in
                                VStack(alignment: .leading) {
                                    HStack {
                                        AsyncImage(url: URL(string: viewModel.vmVars.productList?[indexRow].product?.product_images ?? "")) { phase in
                                            switch phase {
                                            case .success(let image):
                                                image
                                                    .resizable()
                                                    .scaledToFill()
                                            case .failure(_):
                                                Image("")
                                                    .resizable()
                                                    .scaledToFill()
                                            default:
                                                ProgressView()
                                            }
                                        }
                                        .frame(width: 130, height: 85)
                                        .background(AppColors.grayColor)
                                        .padding(.leading, 20)
                                        
                                        VStack {
                                            HStack {
                                                VStack(alignment: .leading) {
                                                    Text(viewModel.vmVars.productList?[indexRow].product?.name ?? "")
                                                    Text("(\(viewModel.vmVars.productList?[indexRow].product?.product_category ?? ""))")
                                                        .foregroundColor(.gray)
                                                }
                                                Spacer()
                                            }
                                            VStack {
                                                HStack {
                                                    HStack {
                                                        Text("\(viewModel.vmVars.productList?[indexRow].quantity ?? 0)")
                                                        Image(systemName: ImageNames.downArrow.rawValue)
                                                    }
                                                    .padding(10)
                                                    .background(AppColors.grayColor)
                                                    .foregroundColor(.black)
                                                    .cornerRadius(5)
                                                    .onTapGesture(perform: {
                                                        selectedQuantity = (viewModel.vmVars.productList?[indexRow].quantity ?? 0) - 1
                                                        showPicker = true
                                                        editIndex = indexRow
                                                    })
                                                    Spacer()
                                                    Text("₹\(viewModel.vmVars.productList?[indexRow].product?.sub_total ?? 0)")
                                                        .padding(.trailing, 20)
                                                        .fontWeight(.light)
                                                }
                                            }
                                        }
                                        .padding(.leading, 20)
                                    }
                                    .padding([.top, .bottom], 15)
                                    .background(.white)
                                    
                                    Spacer()
                                        .frame(maxWidth: .infinity, maxHeight: 1)
                                        .background(AppColors.grayColor)
                                }
                                .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                                .listRowSeparator(.hidden)
                                .listRowBackground(Color.white)
                                .swipeActions {
                                    Button {
                                        isPresentingAlert = true
                                        deleteIndex = indexRow
                                    } label: {
                                        Label("Delete", image: ImageNames.delete.rawValue)
                                    }
                                    .tint(.white)
                                }
                            }
                            
                            if viewModel.vmVars.productList?.count != 0 {
                                // TOTAL ROW
                                VStack {
                                    HStack {
                                        Text("TOTAL")
                                            .padding(.leading, 20)
                                            .bold()
                                        Spacer()
                                        Text("₹\(viewModel.vmVars.total_price)")
                                            .padding(.trailing, 20)
                                            .bold()
                                    }
                                    .padding([.top, .bottom], 20)
                                    
                                    Spacer()
                                        .frame(maxWidth: .infinity, maxHeight: 1)
                                        .background(AppColors.grayColor)
                                }
                                .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                                .listRowSeparator(.hidden)
                                .listRowBackground(Color.white)
                                    
                                // BUTTON
                                VStack {
                                    ZStack {
                                        Text("ORDER NOW")
                                            .foregroundColor(.white)
                                            .font(.system(size: 25))
                                            .bold()
                                            .padding(10)
                                            .frame(maxWidth: .infinity)
                                            .background(.red)
                                            .cornerRadius(5)
                                            .padding(20)
                                            .alert(isPresented: $viewModel.vmVars.showAlert) {
                                                Alert(title: Text(AlertMessages.noteMsg.rawValue), message: Text(viewModel.vmVars.alertMessage))
                                            }
                                        NavigationLink(destination: EmptyView()) {
                                            EmptyView()
                                        }
                                        .opacity(0)
                                        .padding(10)
                                        .frame(maxWidth: .infinity)
                                        .cornerRadius(5)
                                        .padding(20)
                                    }
                                }
                                .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                            }
                        }
                        .frame(maxWidth: .infinity)
                        .alert(AlertMessages.doYouWantDelete.rawValue, isPresented: $isPresentingAlert) {
                            Button("OK", role: .destructive) {
                                isPresentingAlert = false
                                viewModel.vmVars.isLoading = true
                                viewModel.deleteCartItem(id: viewModel.vmVars.productList?[deleteIndex].product_id ?? 1)
                                viewModel.vmVars.productList?.remove(at: deleteIndex)
                            }
                            Button("Cancel", role: .cancel) {
                                isPresentingAlert = false
                            }
                        }

                        if showPicker {
                            VStack(spacing: 0) {
                                Spacer()
                                HStack {
                                    Spacer()
                                    Button(action: {
                                        showPicker = false
                                        viewModel.vmVars.isLoading = true
                                        viewModel.editItemQuantity(id: viewModel.vmVars.productList?[editIndex].product_id ?? 1, qty: selectedQuantity+1)
                                        viewModel.vmVars.productList?[editIndex].quantity = selectedQuantity+1
                                    }) {
                                        Text("Done")
                                            .foregroundColor(.blue)
                                            .padding(.horizontal)
                                    }
                                }
                                .frame(height: 50)
                                .background(AppColors.grayColor)
                                
                                Picker(selection: $selectedQuantity, label: Text("Select Quantity")) {
                                    ForEach(0..<viewModel.pickerData.count, id: \.self) { indexRow in
                                        Text("\(viewModel.pickerData[indexRow])")
                                    }
                                }
                                .pickerStyle(WheelPickerStyle())
                                .background(Color.white)
                                .frame(width: geometry.size.width, height: 200, alignment: .bottom)
                            }
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
            .onAppear {
                viewModel.vmVars.isLoading = true
                viewModel.getCartItemsList()
            }
        }
    }
}

struct MyCartView_Previews: PreviewProvider {
    static var previews: some View {
        MyCartView()
    }
}
