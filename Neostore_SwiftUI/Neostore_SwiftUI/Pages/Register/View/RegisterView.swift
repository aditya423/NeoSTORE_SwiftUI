//
//  RegisterView.swift
//  Neostore_SwiftUI
//
//  Created by Neosoft on 15/01/24.
//

import SwiftUI
//MARK: - RegisterView
struct RegisterView: View {
    //State Variables
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
                    Text(Constants.neoStore.rawValue)
                        .foregroundColor(.white)
                        .font(.system(size: 50))
                        .bold()
                }
                VStack {
                    CustomTextField(text: $firstName, isImage: true, image: ImageNames.username.rawValue, placeholder: TextPlaceHolders.firstName.rawValue)
                        .border(.white)
                        .padding([.leading, .trailing], 30)
                        .padding(.bottom, 10)
                        .focused($focusedField, equals: 1)
                        .onSubmit{
                            focusedField = 2
                        }
                    
                    CustomTextField(text: $lastName, isImage: true, image: ImageNames.username.rawValue, placeholder: TextPlaceHolders.lastName.rawValue)
                        .border(.white)
                        .padding([.leading, .trailing], 30)
                        .padding(.bottom, 10)
                        .focused($focusedField, equals: 2)
                        .onSubmit{
                            focusedField = 3
                        }
                    
                    CustomTextField(text: $email, isImage: true, image: ImageNames.email.rawValue, placeholder: TextPlaceHolders.email.rawValue)
                        .border(.white)
                        .padding([.leading, .trailing], 30)
                        .padding(.bottom, 10)
                        .focused($focusedField, equals: 3)
                        .onSubmit{
                            focusedField = 4
                        }
                    
                    CustomTextField(text: $password, isImage: true, image: ImageNames.password.rawValue, placeholder: TextPlaceHolders.password.rawValue, isSecureTextField: true)
                        .border(.white)
                        .padding([.leading, .trailing], 30)
                        .padding(.bottom, 10)
                        .focused($focusedField, equals: 4)
                        .onSubmit{
                            focusedField = 5
                        }
                    
                    CustomTextField(text: $confirmPassword, isImage: true, image: ImageNames.password.rawValue, placeholder: TextPlaceHolders.confirmPassword.rawValue, isSecureTextField: true)
                        .border(.white)
                        .padding([.leading, .trailing], 30)
                        .padding(.bottom, 10)
                        .focused($focusedField, equals: 5)
                    
                    HStack{
                        Text(Constants.gender.rawValue)
                            .font(.system(size: 20))
                            .padding(.leading, 10)
                            .padding([.top, .bottom], 10)
                            .fontWeight(.medium)
                            .foregroundColor(.white)
                        Spacer().frame(width: 40)
                        Button {
                            genderSelected = TextPlaceHolders.male.rawValue
                        } label: {
                            HStack{
                                if genderSelected == TextPlaceHolders.male.rawValue{
                                    Image(ImageNames.checkYes.rawValue)
                                } else {
                                    Image(ImageNames.checkNo.rawValue)
                                }
                                Text(Constants.male.rawValue)
                                    .font(.system(size: 20))
                                    .padding([.top, .bottom], 10)
                                    .fontWeight(.medium)
                                    .foregroundColor(.white)
                            }
                        }
                        Spacer().frame(width: 20)
                        Button {
                            genderSelected = TextPlaceHolders.female.rawValue
                        } label: {
                            HStack{
                                if genderSelected == TextPlaceHolders.female.rawValue{
                                    Image(ImageNames.checkYes.rawValue)
                                } else {
                                    Image(ImageNames.checkNo.rawValue)
                                }
                                Text(Constants.female.rawValue)
                                    .font(.system(size: 20))
                                    .padding([.top, .bottom], 10)
                                    .fontWeight(.medium)
                                    .foregroundColor(.white)
                            }
                        }
                    }
                    
                    CustomTextField(text: $mobileNumber, isImage: true, image: ImageNames.phoneNumber.rawValue, placeholder: TextPlaceHolders.phoneNumber.rawValue)
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
                                    Image(ImageNames.checked.rawValue)
                                        .resizable()
                                        .frame(width: 15, height: 15)
                                } else {
                                    Image(ImageNames.unchecked.rawValue)
                                        .resizable()
                                        .frame(width: 12, height: 12)
                                }
                            }
                        }
                        Text(Constants.iAgreeThe.rawValue)
                            .font(.system(size: 13))
                            .padding([.trailing],0)
                            .padding([.top, .bottom], 10)
                            .fontWeight(.medium)
                            .foregroundColor(.white)
                        Text(Constants.termsAndConditions.rawValue)
                            .font(.system(size: 13))
                            .padding(.leading,0)
                            .padding([.top, .bottom], 10)
                            .fontWeight(.medium)
                            .foregroundColor(.white)
                            .underline()
                    }
                    
                    HStack{
                        // Register Validation and Api Call
                        Button {
                            registerViewModel.registerUserProfile(firstName: firstName, lastName: lastName, email: email, password: password, confirmPassword: confirmPassword, mobileNumber: mobileNumber, isTermsAccepted: isTermsAccepted, genderSelected: genderSelected)
                        } label: {
                            Text(Constants.register.rawValue)
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
                    Image(systemName: ImageNames.systemImgLeft.rawValue)
                        .foregroundColor(.white)
                }
            }
            ToolbarItem(placement: .principal) {
                Text(PageHeadings.register.rawValue)
                    .font(.headline)
                    .foregroundColor(.white)
            }
            ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                Button(ButtonTitles.done.rawValue) {
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
//preview
struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
