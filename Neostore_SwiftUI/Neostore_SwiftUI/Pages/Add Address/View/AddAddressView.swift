//
//  AddAddressView.swift
//  Neostore_SwiftUI
//
//  Created by Neosoft on 15/01/24.
//

import SwiftUI

struct AddAddressView: View {
    
    // VARIABLES
    @State var address: String = ""
    @State var landmark: String = ""
    @State var city: String = ""
    @State var state: String = ""
    @State var zipCode: String = ""
    @State var country: String = ""
    @State var validated: Bool = false
    @StateObject var viewModel = AddAddressViewModel()
    @ObservedObject var addressListVM: AddressListViewModel
    @FocusState var focusedField: Int?
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    // VIEW
    var body: some View {
            VStack(spacing:0){
                Color.red.edgesIgnoringSafeArea(.all)
                        .frame(maxWidth: .infinity,maxHeight: 1)
                ScrollView {
                    ScrollViewReader { proxy in
                        VStack(alignment: .leading) {
                            LabelTextFieldView(textFieldPlaceHolder: "NeoSOFT Technologies, 6th Floor, The Business Arcade, Prabhadevi (West)", textString: "ADDRESS", textFieldString: $address)
                                .onSubmit {
                                    focusedField = 2
                                }
                            LabelTextFieldView(textFieldPlaceHolder: "OPPOSITE TO MOTILAL OSWAL", textString: "LANDMARK", textFieldString: $landmark)
                                .focused($focusedField, equals: 2)
                                .onSubmit {
                                    focusedField = 3
                                }
                            
                            HStack{
                                VStack{
                                    LabelTextFieldView(textFieldPlaceHolder: "MUMBAI", textString: "CITY", textFieldString: $city)
                                        .focused($focusedField, equals: 3)
                                        .onSubmit {
                                            focusedField = 4
                                        }
                                    LabelTextFieldView(textFieldPlaceHolder: "400012", textString: "ZIPCODE", textFieldString: $zipCode)
                                        .id("zipcode")
                                        .focused($focusedField, equals: 5)
                                        .keyboardType(.numberPad)
                                        .onChange(of: zipCode) { newValue in
                                            if newValue.count > 6 {
                                                zipCode = String(newValue.prefix(6))
                                            }
                                        }
                                }
                                VStack{
                                    LabelTextFieldView(textFieldPlaceHolder: "MAHARASHTRA", textString: "STATE", textFieldString: $state)
                                        .focused($focusedField, equals: 4)
                                        .onSubmit {
                                            focusedField = 5
                                        }
                                    LabelTextFieldView(textFieldPlaceHolder: "INDIA", textString: "COUNTRY", textFieldString: $country)
                                        .id("country")
                                }
                            }
                            
                            Button {
                                validated = viewModel.validateTextFields(address: address, landmark: landmark, city: city, state: state, zipcode: zipCode, country: country)
                                if validated {
                                    let fullAddress = "\(address), \(landmark), \(city), \(state), \(zipCode), \(country)"
                                    UserDefaults.standard.set(fullAddress, forKey: Keys.fullAddress.rawValue)
                                    addressListVM.setAddress()
                                    self.presentationMode.wrappedValue.dismiss()
                                }
                            } label: {
                                ButtonTextView(text: "SAVE ADDRESS", fgColor: Color.white)
                            }
                            .background(.red)
                            .cornerRadius(5)
                            .padding(.top, 25)
                            .padding(.horizontal, 15)
                        }
                        .frame(maxWidth: .infinity, maxHeight:.infinity)
                        .padding([.horizontal, .top], 20)
                        .onChange(of: zipCode) { _ in
                            withAnimation {
                                proxy.scrollTo("zipcode", anchor: .bottom)
                            }
                        }
                        .onChange(of: country) { _ in
                            withAnimation {
                                proxy.scrollTo("country", anchor: .bottom)
                            }
                        }
                    }
                }
                .background(Color(red: 230.0/255.0, green: 230.0/255.0, blue: 230.0/255.0))
            }
            .frame(maxWidth: .infinity,maxHeight:.infinity)
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden()
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        self.presentationMode.wrappedValue.dismiss()
                    } label: {
                        Image(systemName: ImageNames.backArrow.rawValue)
                            .font(.title3)
                            .foregroundColor(.white)
                            .bold()
                    }
                    
                }
                ToolbarItem(placement: .principal) {
                    Text("Add Address")
                        .font(.title2)
                        .foregroundColor(.white)
                        .bold()
                }
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                    }
                }
            }
            .toolbarBackground(
                .red,
                for: .navigationBar
            )
            .alert(viewModel.vmVars.alertMessage, isPresented: $viewModel.vmVars.showAlert) {
                Button("OK", role: .cancel) {}
            }
    }
}
