//
//  LoginView.swift
//  Neostore_SwiftUI
//
//  Created by webwerks  on 12/01/24.
//

import SwiftUI

struct LoginView: View {
    
    @State var username = ""
    @State var password = ""
    @State var isNavigating = false
    @State var showAlert = false
    @State var alertMessage = ""
    
    var loginViewModel: LoginViewModel {
        LoginViewModel(isNavigating: $isNavigating, showAlert: $showAlert, alertMessage: $alertMessage)
    }

    var body: some View {
        NavigationView {
            VStack {
                Spacer().frame(height: UIScreen.main.bounds.height*0.2)
                VStack {
                    Text("NeoSTORE")
                        .foregroundColor(.white)
                        .font(.system(size: 50))
                        .bold()
                }
                VStack {
                    HStack {
                        Image("username_icon")
                            .padding(.leading, 15)
                            .padding([.top, .bottom], 10)
                            .foregroundColor(.white)
                        CustomTextField(text: $username, placeholder: "Username")
                            .font(.system(size: 20))
                            .padding(.leading, 10)
                            .padding([.top, .bottom], 10)
                            .fontWeight(.medium)
                            .foregroundColor(.white)
                    }
                    .border(.white)
                    .padding([.leading, .trailing], 30)
                    .padding(.bottom, 10)
                    HStack {
                        Image("password_icon")
                            .padding(.leading, 15)
                            .padding([.top, .bottom], 10)
                            .foregroundColor(.white)
                        CustomTextField(text: $password, placeholder: "Password")
                            .font(.system(size: 20))
                            .padding(.leading, 10)
                            .padding([.top, .bottom], 10)
                            .fontWeight(.medium)
                            .foregroundColor(.white)
                    }
                    .border(.white)
                    .padding([.leading, .trailing], 30)
                    HStack {
                        NavigationLink(destination: HomeView(),isActive: $isNavigating) {
                            Button {
                                loginViewModel.validateLoginDetails(userName: username, password: password)
                            } label: {
                                Text("LOGIN")
                                    .foregroundColor(.red)
                                    .font(.system(size: 25))
                                    .bold()
                                    .padding(10)
                                    .frame(maxWidth: .infinity)
                            }
                        }
                        .background(.white)
                        .cornerRadius(5)
                        .padding(.top, 30)
                        
                    }
                    .padding([.leading, .trailing], 30)
                    Text("Forgot Password?")
                        .font(.system(size: 20))
                        .fontWeight(.medium)
                        .foregroundColor(.white)
                        .padding(.top, 15)
                }
                .padding(.top, 30)
                Spacer()
                VStack {
                    HStack {
                        Text("DON'T HAVE AN ACCOUNT?")
                            .font(.system(size: 18))
                            .fontWeight(.medium)
                            .foregroundColor(.white)
                        Spacer()
                        Image(systemName: "plus")
                            .foregroundColor(.white)
                            .padding(10)
                            .background(Color(red: 0, green: 0, blue: 0, opacity: 0.3))
                            .clipped()
                    }
                    .padding([.leading, .trailing], 30)
                    .padding(.bottom, 50)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(red: 225/255, green: 28/255, blue: 36/255))
            .edgesIgnoringSafeArea(.all)
        }
        .alert(alertMessage, isPresented: $showAlert) {
                    Button("OK", role: .cancel) { }
                }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
