//
//  ResetPasswordView.swift
//  Neostore_SwiftUI
//
//  Created by Neosoft on 29/01/24.
//

import SwiftUI

struct ResetPasswordView: View {
    
    // VARIABLES
    @State var oldPassword = ""
    @State var newPassword = ""
    @State var confirmPassword = ""
    @ObservedObject var resetPasswordVM = ResetPasswordViewModel()
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    // VIEW
    var body: some View {
        VStack {
            Spacer().frame(height: UIScreen.main.bounds.height*0.2)
            VStack {
                Text("NeoSTORE")
                    .foregroundColor(.white)
                    .font(.system(size: 50))
                    .bold()
            }
            VStack {
                
                CustomTextField(text: $oldPassword, isImage: true, image: "password_icon", placeholder: "Current Password")
                    .border(.white)
                    .padding([.leading, .trailing], 30)
                    .padding(.bottom, 10)
                
                CustomTextField(text: $newPassword, isImage: true, image: "password_icon", placeholder: "New Password")
                    .border(.white)
                    .padding([.leading, .trailing], 30)
                    .padding(.bottom, 10)
                
                CustomTextField(text: $confirmPassword, isImage: true, image: "password_icon", placeholder: "Confirm Password")
                    .border(.white)
                    .padding([.leading, .trailing], 30)
                
                HStack {
                        Button {
                            resetPasswordVM.resetUserPassword(oldPassword: oldPassword, newPassword: newPassword, confirmPassword: confirmPassword)
                        } label: {
                            ButtonTextView(text: "RESET PASSWORD", fgColor: Color.red)
                                .onChange(of: resetPasswordVM.vmVars.isNavigating) { newValue in
                                    if newValue {
                                        NotificationCenter.default.post(name: Notification.Name(NotificationNames.popToLogin.rawValue), object: nil)
                                    }
                                }
                        }
                        .background(.white)
                        .cornerRadius(5)
                        .padding(.top, 20)
                        .alert(isPresented: $resetPasswordVM.vmVars.showAlert) {
                            Alert(title: Text(AlertMessages.noteMsg.rawValue), message: Text(resetPasswordVM.vmVars.alertMessage))
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
                    Image(systemName: ImageNames.backArrow.rawValue)
                        .font(.title3)
                        .foregroundColor(.white)
                        .bold()
                }
            }
            ToolbarItem(placement: .principal) {
                Text("Reset Password")
                    .font(.title2)
                    .foregroundColor(.white)
                    .bold()
            }
        }
        .toolbarBackground(
            AppColors.primaryColor,
            for: .navigationBar
        )
        .alert(resetPasswordVM.vmVars.alertMessage, isPresented: $resetPasswordVM.vmVars.showAlert) {
            Button("OK", role: .cancel) { }
        }
    }
}

struct ResetPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ResetPasswordView()
    }
}
