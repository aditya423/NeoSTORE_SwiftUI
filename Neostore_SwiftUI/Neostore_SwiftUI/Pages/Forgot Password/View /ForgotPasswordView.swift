//
//  ForgotPasswordView.swift
//  Neostore_SwiftUI
//
//  Created by Neosoft on 30/01/24.
//

import SwiftUI
//MARK: - ForgotPasswordView
struct ForgotPasswordView: View {
    //State Objects
    @State var email = ""
    @ObservedObject var forgotPasswordVM = ForgotPasswordViewModel()
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
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
                            Text(Constants.submit.rawValue)
                                .foregroundColor(.red)
                                .font(.system(size: 25))
                                .bold()
                                .padding(10)
                                .frame(maxWidth: .infinity)
                                .onChange(of: forgotPasswordVM.vmVars.isNavigating) { newValue in
                                    if newValue {
                                        self.presentationMode.wrappedValue.dismiss()
                                    }
                                }
                        }
                    .background(.white)
                    .cornerRadius(5)
                    .padding(.top, 30)
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
                        .foregroundColor(.white)
                }
            }
            ToolbarItem(placement: .principal) {
                Text(PageHeadings.forgotPassword.rawValue)
                    .font(.headline)
                    .foregroundColor(.white)
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
