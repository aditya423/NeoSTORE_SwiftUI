//
//  LoginView.swift
//  Neostore_SwiftUI
//
//  Created by webwerks  on 12/01/24.
//

import SwiftUI

struct LoginView: View {
    
    // VARIABLES
    @State var username = ""
    @State var password = ""
    @FocusState private var focusedField: Bool?
    @ObservedObject var loginViewModel = LoginViewModel()

    // VIEW
    var body: some View {
        VStack {
            Spacer().frame(height: UIScreen.main.bounds.height*0.2)
            VStack {
                Text(Constants.neoStore.rawValue)
                    .foregroundColor(.white)
                    .font(.system(size: 50))
                    .bold()
            }
            VStack {
                CustomTextField(text: $username, isImage: true, image: ImageNames.username.rawValue, placeholder: TextPlaceHolders.username.rawValue)
                    .border(.white)
                    .padding([.leading, .trailing], 30)
                    .padding(.bottom, 10)
                    .onSubmit {
                        focusedField = true
                    }
                
                CustomTextField(text: $password, isImage: true, image: ImageNames.password.rawValue, placeholder: TextPlaceHolders.password.rawValue, isSecureTextField: true)
                    .border(.white)
                    .padding([.leading, .trailing], 30)
                    .focused($focusedField, equals: true)
                
                
                HStack {
                    //Send for Validation and Api Call on Succes Navigate to Home
                    NavigationLink(destination: HomeView(), isActive: $loginViewModel.vmVars.isNavigating) {
                        Button {
                            loginViewModel.loginUserProfile(email: username, password: password)
                        } label: {
                            ButtonTextView(text: Constants.login.rawValue, fgColor: Color.red)
                        }
                    }
                    .background(.white)
                    .cornerRadius(5)
                    .padding(.top, 20)
                    .alert(isPresented: $loginViewModel.vmVars.showAlert) {
                        Alert(title: Text(AlertMessages.noteMsg.rawValue), message: Text(loginViewModel.vmVars.alertMessage))
                    }
                }
                .padding([.leading, .trailing], 30)
                // Navigate to Forgot Password
                NavigationLink(destination: ForgotPasswordView()) {
                    Text(Constants.forgotPassword.rawValue)
                        .font(.system(size: 20))
                        .fontWeight(.medium)
                        .foregroundColor(.white)
                        .padding(.top, 15)
                }
            }
            .padding(.top, 30)
            Spacer()
            VStack {
                HStack {
                    Text(Constants.dontHaveAccount.rawValue)
                        .font(.system(size: 18))
                        .fontWeight(.medium)
                        .foregroundColor(.white)
                    Spacer()
                    //Navigate to RegisterView
                    NavigationLink(destination: RegisterView()) {
                        Image(systemName: ImageNames.plusImage.rawValue)
                            .foregroundColor(.white)
                            .padding(10)
                            .background(Color(red: 0, green: 0, blue: 0, opacity: 0.3))
                            .clipped()
                    }
                }
                .padding([.leading, .trailing], 30)
                .padding(.bottom, 30)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(AppColors.primaryColor)
        .edgesIgnoringSafeArea(.all)
        .ignoresSafeArea(.keyboard)
        .alert(loginViewModel.vmVars.alertMessage, isPresented: $loginViewModel.vmVars.showAlert) {
            Button(ButtonTitles.ok.rawValue, role: .cancel) { }
        }
    }
}

//preview
struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
