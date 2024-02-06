//
//  RegisterView.swift
//  Neostore_SwiftUI
//
//  Created by Neosoft on 15/01/24.
//

import SwiftUI

struct RegisterView: View {
    
    @State var firstName = ""
    @State var lastName = ""
    @State var email = ""
    @State var password = ""
    @State var confirmPassword = ""
    @State var mobileNumber = ""
    @State var genderSelected = ""
    @State var isTermsAccepted = false
    @FocusState private var focusedField: Int?
    
    @ObservedObject var registerViewModel = RegisterViewModel()
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        ScrollView {
            VStack {
                Spacer().frame(height: UIScreen.main.bounds.height*0.2)
                VStack {
                    Text("NeoSTORE")
                        .foregroundColor(.white)
                        .font(.system(size: 50))
                        .bold()
                }
                VStack {
                    CustomTextField(text: $firstName, isImage: true, image: "username_icon", placeholder: "First Name")
                        .border(.white)
                        .padding([.leading, .trailing], 30)
                        .padding(.bottom, 10)
                        .focused($focusedField, equals: 1)
                        .onSubmit{
                            focusedField = 2
                        }
                    
                    CustomTextField(text: $lastName, isImage: true, image: "username_icon", placeholder: "Last Name")
                        .border(.white)
                        .padding([.leading, .trailing], 30)
                        .padding(.bottom, 10)
                        .focused($focusedField, equals: 2)
                        .onSubmit{
                            focusedField = 3
                        }
                    
                    CustomTextField(text: $email, isImage: true, image: "email_icon", placeholder: "Email")
                        .border(.white)
                        .padding([.leading, .trailing], 30)
                        .padding(.bottom, 10)
                        .focused($focusedField, equals: 3)
                        .onSubmit{
                            focusedField = 4
                        }
                    
                    CustomTextField(text: $password, isImage: true, image: "password_icon", placeholder: "Password", isSecureTextField: true)
                        .border(.white)
                        .padding([.leading, .trailing], 30)
                        .padding(.bottom, 10)
                        .focused($focusedField, equals: 4)
                        .onSubmit{
                            focusedField = 5
                        }
                    
                    CustomTextField(text: $confirmPassword, isImage: true, image: "password_icon", placeholder: "Confirm Password", isSecureTextField: true)
                        .border(.white)
                        .padding([.leading, .trailing], 30)
                        .padding(.bottom, 10)
                        .focused($focusedField, equals: 5)
                
                    
                    HStack{
                        Text("Gender")
                            .font(.system(size: 20))
                            .padding(.leading, 10)
                            .padding([.top, .bottom], 10)
                            .fontWeight(.medium)
                            .foregroundColor(.white)
                        Spacer().frame(width: 40)
                        Button {
                            genderSelected = "M"
                        } label: {
                            HStack{
                                if genderSelected == "M"{
                                    Image("chky")
                                } else {
                                    Image("chkn")
                                }
                                Text("Male")
                                    .font(.system(size: 20))
                                    .padding([.top, .bottom], 10)
                                    .fontWeight(.medium)
                                    .foregroundColor(.white)
                            }
                        }
                        Spacer().frame(width: 20)
                        Button {
                            genderSelected = "F"
                        } label: {
                            HStack{
                                if genderSelected == "F"{
                                    Image("chky")
                                } else {
                                    Image("chkn")
                                }
                                Text("Female")
                                    .font(.system(size: 20))
                                    .padding([.top, .bottom], 10)
                                    .fontWeight(.medium)
                                    .foregroundColor(.white)
                            }
                        }
                    }
                    
                    CustomTextField(text: $mobileNumber, isImage: true, image: "cellphone_icon", placeholder: "Phone Number")
                        .keyboardType(.numberPad)
                        .border(.white)
                        .padding([.leading, .trailing], 30)
                        .padding(.bottom, 10)
                        .focused($focusedField, equals: 6)
                    
                    HStack(spacing: 5){
                        Button {
                            isTermsAccepted = !isTermsAccepted
                        } label: {
                            HStack{
                                if isTermsAccepted {
                                    Image("checked_icon")
                                        .resizable()
                                        .frame(width: 15, height: 15)
                                } else {
                                    Image("uncheck_icon")
                                        .resizable()
                                        .frame(width: 12, height: 12)
                                }
                            }
                        }
                        Text(" I agree the")
                            .font(.system(size: 13))
                            .padding([.trailing],0)
                            .padding([.top, .bottom], 10)
                            .fontWeight(.medium)
                            .foregroundColor(.white)
                        Text("Terms and Conditions")
                            .font(.system(size: 13))
                            .padding(.leading,0)
                            .padding([.top, .bottom], 10)
                            .fontWeight(.medium)
                            .foregroundColor(.white)
                            .underline()
                    }
                    
                    HStack{
                        
                        Button {
                            registerViewModel.registerUserProfile(firstName: firstName, lastName: lastName, email: email, password: password, confirmPassword: confirmPassword, mobileNumber: mobileNumber, isTermsAccepted: isTermsAccepted, genderSelected: genderSelected)
                        } label: {
                            Text("REGISTER")
                                .foregroundColor(.red)
                                .font(.system(size: 25))
                                .bold()
                                .padding(10)
                                .frame(maxWidth: .infinity)
                                .onChange(of: registerViewModel.vmVars.isNavigating) { newValue in
                                    if newValue {
                                        self.presentationMode.wrappedValue.dismiss()
                                    }
                                }
                        }
                        .background(.white)
                        .cornerRadius(5)
                        .padding(.top, 30)
                        .padding(.bottom, 50)
                        .alert(isPresented: $registerViewModel.vmVars.showAlert) {
                            Alert(title: Text(AlertMessages.noteMsg.rawValue), message: Text(registerViewModel.vmVars.alertMessage))
                        }
                        
                    }
                    .padding([.leading, .trailing], 30)
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(AppColors.primaryColor)
        .edgesIgnoringSafeArea(.all)
        .navigationBarTitleDisplayMode(.automatic)
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
                Text("Register")
                    .font(.headline)
                    .foregroundColor(.white)
            }
            ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                    focusedField = nil
                }
            }
        }
        .toolbarBackground(
            AppColors.primaryColor,
            for: .navigationBar
        )
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
