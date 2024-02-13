//
//  MyAccountView.swift
//  Neostore_SwiftUI
//
//  Created by Neosoft on 15/01/24.
//

import SwiftUI
import PhotosUI

struct MyAccountView: View {
    
    @State var oldFirstName = ""
    @State var oldLastName = ""
    @State var oldEmail = ""
    @State var oldMobileNumber = ""
    @State var oldDob = ""
    @State var firstName = ""
    @State var lastName = ""
    @State var email = ""
    @State var mobileNumber = ""
    @State var dob = ""
    @State var isEditingProfile = false
    @State var showPicker = false
    @State var birthDate = Date()
    @State var navigateToReset = false
    @State var showImagePicker = false
    @State var selectedItems = [PhotosPickerItem]()
    @State var previousImageData = Data()
    @State var selectedImageData = Data()
    @State var screenFirstTime = 1
    @FocusState var focusedField: Int?
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @ObservedObject var myAccountVM = MyAccountViewModel()
    
    var body: some View {
        
        GeometryReader { geometry in
            VStack(spacing: 0) {
                Color.red.edgesIgnoringSafeArea(.all)
                    .frame(maxWidth: .infinity, maxHeight: 1)
                
                ZStack{
                    if myAccountVM.vmVars.isLoading {
                        LoaderView(bgColor: AppColors.grayColor, tintColor: Color.red)
                    } else {
                        ScrollView {
                            VStack {
                                Spacer().frame(height: UIScreen.main.bounds.height*0.12)
                                
                                if let image = screenFirstTime==1 ? loadImage(imgName: ImageNames.profileImage.rawValue) : Image(uiImage: UIImage(data: selectedImageData) ?? UIImage()) {
                                    if isEditingProfile {
                                        PhotosPicker(selection: $selectedItems,
                                                     maxSelectionCount: 1,
                                                     selectionBehavior: .ordered,
                                                     matching: .images
                                        ) {
                                            image
                                                .resizable()
                                                .frame(width: 120, height: 120)
                                                .aspectRatio(contentMode: .fill)
                                                .clipShape(Circle())
                                                .overlay(Circle().stroke(Color.white, lineWidth: 3))
                                                .padding([.top,.bottom], 20)
                                                .disabled(isEditingProfile ? false : true)
                                        }
                                    } else {
                                        image
                                            .resizable()
                                            .frame(width: 120, height: 120)
                                            .aspectRatio(contentMode: .fill)
                                            .clipShape(Circle())
                                            .overlay(Circle().stroke(Color.white, lineWidth: 3))
                                            .padding([.top,.bottom], 20)
                                            .disabled(isEditingProfile ? false : true)
                                    }
                                } else {
                                    if isEditingProfile {
                                        PhotosPicker(selection: $selectedItems,
                                                     maxSelectionCount: 1,
                                                     selectionBehavior: .ordered,
                                                     matching: .images
                                        ) {
                                            Image("")
                                                .resizable()
                                                .frame(width: 120, height: 120)
                                                .aspectRatio(contentMode: .fill)
                                                .clipShape(Circle())
                                                .overlay(Circle().stroke(Color.white, lineWidth: 3))
                                                .padding([.top,.bottom], 20)
                                                .disabled(isEditingProfile ? false : true)
                                        }
                                    } else {
                                        Image("")
                                            .resizable()
                                            .frame(width: 120, height: 120)
                                            .aspectRatio(contentMode: .fill)
                                            .clipShape(Circle())
                                            .overlay(Circle().stroke(Color.white, lineWidth: 3))
                                            .padding([.top,.bottom], 20)
                                            .disabled(isEditingProfile ? false : true)
                                    }
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
                                            setPreviousData()
                                        } label: {
                                            Text("CANCEL")
                                                .foregroundColor(.red)
                                                .font(.system(size: 25))
                                                .bold()
                                                .padding(10)
                                                .frame(maxWidth: .infinity)
                                        }
                                        .background(.white)
                                        .cornerRadius(5)
                                        .padding(.top, 10)
                                        .padding(.bottom, 50)
                                        
                                        Button {
                                            isEditingProfile = false
                                            saveImage(imageData: selectedImageData, fileName: ImageNames.profileImage.rawValue)
                                            if ifDataChanged() {
                                                myAccountVM.vmVars.isLoading = true
                                                myAccountVM.editAccountDetails(firstName: firstName, lastName: lastName, email: email, dob: dob, profilePic: "", phoneNo: mobileNumber)
                                            }
                                        } label: {
                                            Text("SUBMIT")
                                                .foregroundColor(.red)
                                                .font(.system(size: 25))
                                                .bold()
                                                .padding(10)
                                                .frame(maxWidth: .infinity)
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
                        .alert(myAccountVM.vmVars.alertMessage, isPresented: $myAccountVM.vmVars.showAlert) {
                            Button("OK", role: .cancel) {}
                        }
                        
                        if showPicker {
                            VStack(spacing: 0) {
                                Spacer()
                                HStack {
                                    Spacer()
                                    Button {
                                        showPicker = false
                                        dob = dateToString(date: birthDate).replacingOccurrences(of: "/", with: "-")
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
                                    navigateToReset = true
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
                        
                        NavigationLink(destination: ResetPasswordView(), isActive: $navigateToReset) {}
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
                oldFirstName = CommonViewModel.shared.user_data?.first_name ?? ""
                lastName = CommonViewModel.shared.user_data?.last_name ?? ""
                oldLastName = CommonViewModel.shared.user_data?.last_name ?? ""
                email = CommonViewModel.shared.user_data?.email ?? ""
                oldEmail = CommonViewModel.shared.user_data?.email ?? ""
                mobileNumber = CommonViewModel.shared.user_data?.phone_no ?? ""
                oldMobileNumber = CommonViewModel.shared.user_data?.phone_no ?? ""
                dob = CommonViewModel.shared.user_data?.dob ?? ""
                oldDob = CommonViewModel.shared.user_data?.dob ?? ""
                birthDate = stringToDate(date: CommonViewModel.shared.user_data?.dob ?? "")
                previousImageData = loadImageData(imgName: ImageNames.profileImage.rawValue)
                selectedImageData = loadImageData(imgName: ImageNames.profileImage.rawValue)
            }
            .onChange(of: selectedItems) { newItem in
                Task {
                    screenFirstTime += 1
                    guard let imageData = try? await newItem.first?.loadTransferable(type: Data.self) else { return }
                    selectedImageData = imageData
                    selectedItems.removeAll()
                }
            }
        }
    }
    
    func dateToString(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        return formatter.string(from: date)
    }
    
    func stringToDate(date: String) -> Date {
        let formatter = DateFormatter()
        return formatter.date(from: date) ?? Date()
    }
    
    func ifDataChanged() -> Bool {
        return myAccountVM.isDataChanged(oldFirstName: oldFirstName, oldLastName: oldLastName, oldEmail: oldEmail, oldMobileNo: oldMobileNumber, oldDob: oldDob, firstName: firstName, lastName: lastName, email: email, mobileNo: mobileNumber, dob: dob)
    }
    
    func setPreviousData() {
        selectedImageData = previousImageData
        firstName = oldFirstName
        lastName = oldLastName
        email = oldEmail
        mobileNumber = oldMobileNumber
        dob = oldDob
    }
}
