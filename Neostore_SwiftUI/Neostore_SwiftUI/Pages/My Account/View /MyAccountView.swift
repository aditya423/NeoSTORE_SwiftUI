//
//  MyAccountView.swift
//  Neostore_SwiftUI
//
//  Created by Neosoft on 15/01/24.
//

import SwiftUI
struct MyAccountView: View {
    
    @State var firstName = ""
    @State var lastName = ""
    @State var email = ""
    @State var mobileNumber = ""
    @State var dob = ""
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @ObservedObject var myAccountVM = MyAccountViewModel()
    
    var body: some View {
            ZStack{
                ScrollView {
                    VStack {
                        Spacer().frame(height: UIScreen.main.bounds.height*0.12)
                        
                        Image(uiImage: UIImage(systemName: "person") ?? UIImage())
                            .resizable()
                            .frame(width: 150,height: 150)
                            .cornerRadius(150)
                            .padding(.bottom, 10)
                        
                        CustomTextField(text: $firstName, isImage: true, image: "username_icon", placeholder: "First Name")
                            .border(.white)
                            .padding([.leading, .trailing], 30)
                            .padding(.bottom, 10)
                        
                        CustomTextField(text: $firstName, isImage: true, image: "username_icon", placeholder: "Last Name")
                            .border(.white)
                            .padding([.leading, .trailing], 30)
                            .padding(.bottom, 10)
                        
                        CustomTextField(text: $firstName, isImage: true, image: "email_icon", placeholder: "Email")
                            .border(.white)
                            .padding([.leading, .trailing], 30)
                            .padding(.bottom, 10)
                        
                        CustomTextField(text: $firstName, isImage: true, image: "cellphone_icon", placeholder: "Phone Number")
                            .border(.white)
                            .padding([.leading, .trailing], 30)
                            .padding(.bottom, 10)
                        
                        CustomTextField(text: $firstName, isImage: true, image: "dob_icon", placeholder: "DOB")
                            .border(.white)
                            .padding([.leading, .trailing], 30)
                            .padding(.bottom, 10)
                        
                        HStack{
                            
                            Button {
                                
                            } label: {
                                Text("EDIT PROFILE")
                                    .foregroundColor(.red)
                                    .font(.system(size: 25))
                                    .bold()
                                    .padding(10)
                                    .frame(maxWidth: .infinity)
                                    .onChange(of: myAccountVM.vmVars.isNavigating) { newValue in
                                        if newValue {
                                            self.presentationMode.wrappedValue.dismiss()
                                        }
                                    }
                            }
                            .background(.white)
                            .cornerRadius(5)
                            .padding(.top, 10)
                            .padding(.bottom, 50)
                            //                    .alert(isPresented: $registerViewModel.vmVars.showAlert) {
                            //                        Alert(title: Text(AlertMessages.noteMsg.rawValue), message: Text(registerViewModel.vmVars.alertMessage))
                            //                    }
                        }
                        .padding([.leading, .trailing], 30)
                    }
                }
                VStack{
                    Spacer()
                    Button {
                        
                    } label: {
                        Text("RESET PASSWORD")
                            .foregroundColor(.gray)
                            .font(.system(size: 25))
                            .bold()
                            .padding(10)
                            .frame(maxWidth: .infinity)
                            .onChange(of: myAccountVM.vmVars.isNavigating) { newValue in
                                if newValue {
                                    self.presentationMode.wrappedValue.dismiss()
                                }
                            }
                    }
                    .background(.white)
                    .padding(.top, 10)
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
                    Text("Edit Profile")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                }
            }
            .toolbarBackground(
                AppColors.primaryColor,
                for: .navigationBar
            )
        }
}

struct MyAccountView_Previews: PreviewProvider {
    static var previews: some View {
        MyAccountView()
    }
}
