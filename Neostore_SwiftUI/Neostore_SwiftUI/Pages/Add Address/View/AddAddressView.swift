//
//  AddAddressView.swift
//  Neostore_SwiftUI
//
//  Created by Neosoft on 15/01/24.
//

import SwiftUI

struct AddAddressView: View {
    
    @State var address: String = ""
    @State var landmark: String = ""
    @State var city: String = ""
    @State var state: String = ""
    @State var zipCode: String = ""
    @State var country: String = ""
    @State var validated: Bool = false
    @StateObject var viewModel = AddAddressViewModel()
    @ObservedObject var addressListVM: AddressListViewModel
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
            VStack(spacing:0){
                Color.red.edgesIgnoringSafeArea(.all)
                        .frame(maxWidth: .infinity,maxHeight: 1)
                ScrollView {
                    ScrollViewReader { proxy in
                        VStack(alignment: .leading) {
                            LabelTextFieldView(textFieldString: $address, textFieldPlaceHolder: "NeoSOFT Technologies, 6th Floor, The Business Arcade, Prabhadevi (West)", textString: "ADDRESS")
                            LabelTextFieldView(textFieldString: $landmark, textFieldPlaceHolder: "OPPOSITE TO MOTILAL OSWAL", textString: "LANDMARK")
                            
                            HStack{
                                VStack{
                                    LabelTextFieldView(textFieldString: $city, textFieldPlaceHolder: "MUMBAI", textString: "CITY")
                                    LabelTextFieldView(textFieldString: $zipCode, textFieldPlaceHolder: "400012", textString: "ZIPCODE")
                                        .id("zipcode")
                                        .keyboardType(.numberPad)
                                        .onChange(of: zipCode) { newValue in
                                            if newValue.count > 6 {
                                                zipCode = String(newValue.prefix(6))
                                            }
                                        }
                                }
                                VStack{
                                    LabelTextFieldView(textFieldString: $state, textFieldPlaceHolder: "MAHARASHTRA", textString: "STATE")
                                    LabelTextFieldView(textFieldString: $country, textFieldPlaceHolder: "INDIA", textString: "COUNTRY")
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
                                Text("SAVE ADDRESS")
                                    .foregroundColor(.white)
                                    .font(.system(size: 25))
                                    .bold()
                                    .padding(10)
                                    .frame(maxWidth: .infinity)
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

//struct AddAddressView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddAddressView()
//    }
//}
