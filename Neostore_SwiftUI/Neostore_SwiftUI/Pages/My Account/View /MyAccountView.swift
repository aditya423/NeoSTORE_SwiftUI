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
    @State var isEditingProfile = false
    @State var showPicker = false
    @State var birthDate = Date()
    @FocusState var focusedField: Int?
    
    func dateToString(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        return formatter.string(from: date)
    }
    
    func stringToDate(date: String) -> Date {
        let formatter = DateFormatter()
        return formatter.date(from: date) ?? Date()
    }
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @ObservedObject var myAccountVM = MyAccountViewModel()
    
    var body: some View {
        
        GeometryReader { geometry in
            ZStack{
                ScrollView {
                    VStack {
                        Spacer().frame(height: UIScreen.main.bounds.height*0.12)
                        
                        if let image = loadImage(imgName: ImageNames.profileImage.rawValue) {
                            image
                                .resizable()
                                .frame(width: 100, height: 100)
                                .aspectRatio(contentMode: .fill)
                                .clipShape(Circle())
                                .overlay(Circle().stroke(Color.white, lineWidth: 3))
                                .padding([.top,.bottom], 20)
                                .disabled(isEditingProfile ? false : true)
                        } else {
                            Image("")
                                .resizable()
                                .frame(width: 100, height: 100)
                                .aspectRatio(contentMode: .fill)
                                .clipShape(Circle())
                                .overlay(Circle().stroke(Color.white, lineWidth: 3))
                                .padding([.top,.bottom], 20)
                                .disabled(isEditingProfile ? false : true)
                        }
                        
                        CustomTextField(text: $firstName, isImage: true, image: ImageNames.username.rawValue, placeholder: "First Name")
                            .border(.white)
                            .padding([.leading, .trailing], 30)
                            .padding(.bottom, 10)
                            .disabled(isEditingProfile ? false : true)
                            .onSubmit {
                                focusedField = 1
                            }
                        
                        CustomTextField(text: $lastName, isImage: true, image: ImageNames.username.rawValue, placeholder: "Last Name")
                            .border(.white)
                            .padding([.leading, .trailing], 30)
                            .padding(.bottom, 10)
                            .disabled(isEditingProfile ? false : true)
                            .focused($focusedField, equals: 1)
                            .onSubmit {
                                focusedField = 2
                            }
                        
                        CustomTextField(text: $email, isImage: true, image: ImageNames.email.rawValue, placeholder: "Email")
                            .border(.white)
                            .padding([.leading, .trailing], 30)
                            .padding(.bottom, 10)
                            .disabled(isEditingProfile ? false : true)
                            .focused($focusedField, equals: 2)
                            .onSubmit {
                                focusedField = 3
                            }
                        
                        CustomTextField(text: $mobileNumber, isImage: true, image: ImageNames.phoneNumber.rawValue, placeholder: "Phone Number")
                            .border(.white)
                            .padding([.leading, .trailing], 30)
                            .padding(.bottom, 10)
                            .disabled(isEditingProfile ? false : true)
                            .focused($focusedField, equals: 3)
                            .keyboardType(.numberPad)
                        
                        CustomTextField(text: $dob, isImage: true, image: ImageNames.dob.rawValue, placeholder: "DOB")
                            .border(.white)
                            .padding([.leading, .trailing], 30)
                            .padding(.bottom, 10)
                            .disabled(isEditingProfile ? false : true)
                            .allowsHitTesting(!showPicker)
                            .onTapGesture {
                                showPicker = isEditingProfile ? true : false
                            }
                        
                        HStack{
                            
                            if isEditingProfile {
                                Button {
                                    isEditingProfile = false
                                    // UPDATE USER DETAILS API
                                } label: {
                                    Text("SUBMIT")
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
                            } else {
                                Button {
                                    isEditingProfile = true
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
                            }
                        }
                        .padding([.leading, .trailing], 30)
                    }
                }
                
                if showPicker {
                    VStack(spacing: 0) {
                        Spacer()
                        HStack {
                            Spacer()
                            Button {
                                showPicker = false
                                dob = dateToString(date: birthDate)
                            } label: {
                                Text("Done")
                                    .foregroundColor(.blue)
                                    .padding(.horizontal)
                            }
                        }
                        .frame(height: 50)
                        .background(AppColors.grayColor)
                        
                        GeometryReader { _ in
                            DatePicker("DOB >", selection: $birthDate, displayedComponents: .date)
                                .datePickerStyle(WheelDatePickerStyle())
                                .background(Color.white)
                        }
                        .frame(height: 250)
                    }
                } else {
                    VStack {
                        Spacer()
                        Button {
                            // NAVIGATE TO RESET PASSWORD SCREEN
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
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(AppColors.primaryColor)
            .edgesIgnoringSafeArea(.all)
            .ignoresSafeArea(.keyboard)
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
                    Text(isEditingProfile ? PageHeadings.editProfile.rawValue : PageHeadings.myAccount.rawValue)
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
                AppColors.primaryColor,
                for: .navigationBar
            )
            .onAppear {
                firstName = CommonViewModel.shared.user_data?.first_name ?? ""
                lastName = CommonViewModel.shared.user_data?.last_name ?? ""
                email = CommonViewModel.shared.user_data?.email ?? ""
                mobileNumber = CommonViewModel.shared.user_data?.phone_no ?? ""
                dob = CommonViewModel.shared.user_data?.dob ?? ""
                birthDate = stringToDate(date: CommonViewModel.shared.user_data?.dob ?? "")
            }
        }
    }
}

struct MyAccountView_Previews: PreviewProvider {
    static var previews: some View {
        MyAccountView()
    }
}
