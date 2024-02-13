//
//  ForgotPasswordView.swift
//  Neostore_SwiftUI
//
//  Created by Neosoft on 30/01/24.
//

import SwiftUI

struct ForgotPasswordView: View {
    
    // VARIABLES
    @State var email = ""
    @ObservedObject var forgotPasswordVM = ForgotPasswordViewModel()
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    // VIEW
    var body: some View {
        VStack {
            Spacer().frame(height: UIScreen.main.bounds.height*0.3)
            VStack {
                Text(Constants.neoStore.rawValue)
                    .foregroundColor(.white)
                    .font(.system(size: 50))
                    .bold()
            }
            VStack {
                CustomTextField(text: $email, isImage: true, image:ImageNames.email.rawValue, placeholder: TextPlaceHolders.email.rawValue)
                    .border(.white)
                    .padding([.leading, .trailing], 30)
                    .padding(.bottom, 10)
                
                HStack {
                    //Forgot password Validation and APi Call
                        Button {
                            forgotPasswordVM.forgotPassword(email: email)
                        } label: {
                            ButtonTextView(text: Constants.submit.rawValue, fgColor: Color.red)
                                .onChange(of: forgotPasswordVM.vmVars.isNavigating) { newValue in
                                    if newValue {
                                        self.presentationMode.wrappedValue.dismiss()
                                    }
                                }
                        }
                    .background(.white)
                    .cornerRadius(5)
                    .padding(.top, 20)
                    .alert(isPresented: $forgotPasswordVM.vmVars.showAlert) {
                        Alert(title: Text(AlertMessages.noteMsg.rawValue), message: Text(forgotPasswordVM.vmVars.alertMessage))
                    }
                }
                .padding([.leading, .trailing], 30)
            }
            .padding(.top, 30)
            Spacer()
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
                        .font(.title3)
                        .foregroundColor(.white)
                        .bold()
                }
            }
            ToolbarItem(placement: .principal) {
                Text(PageHeadings.forgotPassword.rawValue)
                    .font(.title2)
                    .foregroundColor(.white)
                    .bold()
            }
        }
        .toolbarBackground(
            AppColors.primaryColor,
            for: .navigationBar
        )
        .alert(forgotPasswordVM.vmVars.alertMessage, isPresented: $forgotPasswordVM.vmVars.showAlert) {
            Button(ButtonTitles.ok.rawValue, role: .cancel) { }
        }
    }
}

//preview
struct ForgotPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ForgotPasswordView()
    }
}
