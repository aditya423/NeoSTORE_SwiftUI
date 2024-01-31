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
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
            VStack(spacing:0){
                Color.red.edgesIgnoringSafeArea(.all)
                        .frame(maxWidth: .infinity,maxHeight: 1)
                ScrollView {
                    VStack(alignment: .leading){
                        LabelTextFieldView(textFieldString: $address, textFieldPlaceHolder: "ADDRESS", textString: "ADDRESS")
                        
                        LabelTextFieldView(textFieldString: $landmark, textFieldPlaceHolder: "LANDMARK", textString: "LANDMARK")
                    
                        HStack{
                            VStack{
                                LabelTextFieldView(textFieldString: $city, textFieldPlaceHolder: "CITY", textString: "CITY")
                                
                                LabelTextFieldView(textFieldString: $zipCode, textFieldPlaceHolder: "ZIP CODE", textString: "ZIPCODE")
                            }
                            VStack{
                                LabelTextFieldView(textFieldString: $state, textFieldPlaceHolder: "STATE", textString: "STATE")
                                
                                LabelTextFieldView(textFieldString: $country, textFieldPlaceHolder: "COUNTRY", textString: "COUNTRY")
                            }
                        }
                        
                        Button {
                            
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
                        .padding(10)
                        .padding(.top, 30)
                    }
                    .frame(maxWidth: .infinity,maxHeight:.infinity)
                    .padding(.horizontal)
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
                        Image(systemName: "chevron.left")
                            .foregroundColor(.white)
                    }
                    
                }
                ToolbarItem(placement: .principal) {
                    Text("Add Address")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                }
            }
            .toolbarBackground(
                .red,
                for: .navigationBar
            )
    }
}

struct AddAddressView_Previews: PreviewProvider {
    static var previews: some View {
        AddAddressView()
    }
}

