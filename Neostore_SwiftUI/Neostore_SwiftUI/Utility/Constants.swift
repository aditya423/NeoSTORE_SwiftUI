//
//  Constants.swift
//  Neostore_SwiftUI
//
//  Created by Neosoft on 16/01/24.
//

import Foundation
import SwiftUI

enum Constants{
    
}

class AppColors{
    static var primaryColor = Color(red: 225/255, green: 28/255, blue: 36/255)
    static var grayColor = Color(red: 230/255, green: 230/255, blue: 230/255)
}

enum FileNames: String {
    case loginVC = "InitialViewController"
    case registerVC = "RegisterViewController"
    case homeVC = "HomeViewController"
    case prodCollectionCell = "ProductsCollectionViewCell"
    case prodCategoryCollectionCell = "ProductCategoriesCollectionViewCell"
    case sideBarVC = "SideBarViewController"
    case sideBarCell = "SlideOutTableViewCell"
    case productListVC = "ProductListViewController"
    case productListCell = "ProductListTableViewCell"
    case productDetailsVC = "ProductDetailsViewController"
    case prodImagesCollectionCell = "ProductImagesCollectionViewCell"
    case rateNowVC = "RateNowViewController"
    case buyNowVC = "BuyNowViewController"
    case myCartVC = "MyCartViewController"
    case itemsCell = "ItemsTableViewCell"
    case totalPriceCell = "TotalPriceTableViewCell"
    case addAddressVC = "AddAddressViewController"
    case addressListVC = "AddressListViewController"
    case addressCell = "AddressTableViewCell"
    case resetPasswordVC = "ResetPasswordViewController"
    case myAccountVC = "MyAccountViewController"
    case myOrdersVC = "MyOrdersViewController"
    case orderListCell = "OrderListTableViewCell"
    case orderDetailsVC = "OrderDetailsViewController"
    case orderDetailsCell = "OrderDetailsTableViewCell"
    case ordersTotalPriceCell = "OrdersTotalPriceTableViewCell"
    case storeLocatorVC = "StoreLocatorViewController"
    case locationsVC = "LocationsViewController"
    case locationsCell = "LocationsTableViewCell"
}

enum AlertMessages: String {
    case errorMsg = "Error"
    case successMsg = "Success"
    case alertMsg = "Alert"
    case noteMsg = "Note"
    case cancelMsg = "Cancel"
    case deleteMsg = "Delete"
    case okMsg = "Ok"
    case doneMsg = "Done"
    case chooseImageMsg = "Choose Image"
    case openCameraMsg = "Open Camera"
    case galleryMsg = "Gallery"
    case confirmDeleteMsg = "Confirm Delete"
    case somethingWrong = "Someting went wrong"
    case invalidEmail = "Please enter valid email!"
    case invalidUsername = "Please enter valid username!"
    case invalidPassword = "Please enter valid password!"
    case emailRegistered = "This email is already registered!"
    case passwordDidntMatched = "Password didn't matching!"
    case invalidFirstName = "First name should contain more than 3 letters!"
    case invalidLastName = "Last name should contain more than 3 letters!"
    case invalidPhoneNumber = "Phone number should contain exactly 10 numbers!"
    case gotResponse = "Response aagaya"
    case invalidToken = "Invalid Token"
    case invalidDataOrToken = "Invalid data or token"
    case wrongMethod = "Wrong Method"
    case invalidCategory = "Invalid category selected"
    case dataMissing = "Data missing please check"
    case invalidId = "Invalid product id"
    case invalidQuantity = "Invalid quantity"
    case ratingSuccessMsg = "Thank you for the ratings"
    case emptyCartMsg = "Cart is empty"
    case doYouWantDelete = "Do you want to delete this item?"
    case addressSavedMsg = "Address saved successfully"
    case addAddressMsg = "Please add the address"
    case selectAddressMsg = "Please select the address"
    case orderPlacedMsg = "Order placed"
    case incorrectOldPassword = "Old password is incorrect"
    case oldNewPasswordShouldDifferent = "Old password and new password should be different"
    case noNeedToUpdatePassword = "This is your old password, no need to update"
    case fillAllFieldsMsg = "Please fill all the fields"
    case updateFailedMsg = "Update Failed"
    case detailsEditedMsg = "Details edited successfully!"
    case orderListEmptyMsg = "Order list is empty"
    case tCMsg = "I agree the Terms & Conditions"
    case userAlreadyExists = "User already exists with this Email Id"
}

enum TextPlaceHolders: String {
    case username = "Username"
    case password = "Password"
    case firstName = "First Name"
    case lastName = "Last Name"
    case email = "Email"
    case confirmPassword = "Confirm Password"
    case phoneNumber = "Phone Number"
    case currentPassword = "Current Password"
    case newPassword = "New Password"
    case dob = "DOB"
    case male = "M"
    case female = "F"
}

enum ImageNames: String {
    case username = "username_icon"
    case password = "password_icon"
    case email = "email_icon"
    case phoneNumber = "cellphone_icon"
    case checked = "checked_icon"
    case unchecked = "uncheck_icon"
    case checkYes = "chky"
    case checkNo = "chkn"
    case backArrow = "chevron.backward"
    case downArrow = "chevron.down"
    case threeLines = "line.3.horizontal"
    case profileImage = "profile_picture.jpg"
    case emptyStar = "star_check"
    case filledStar = "star.fill"
    case plusImage = "plus"
    case dob = "dob_icon"
    case search = "search_icon"
    case delete = "delete"
    case systemCart = "cart.fill"
}

enum PageHeadings: String {
    case register = "Register"
    case tables = "Tables"
    case chairs = "Chairs"
    case sofas = "Sofas"
    case cupboards = "Cupboards"
    case myCart = "My Cart"
    case addAddress = "Add Address"
    case addressList = "Address List"
    case myOrders = "My Orders"
    case myAccount = "My Account"
    case storeLocator = "Store Locator"
}

enum NotificationNames: String {
    case updateCartItems = "updateCartItems"
    case updateCartData = "updateCartDataInSideBar"
    case updateData = "updateDataInSideBar"
}

enum Fonts: String {
    case medium = "Gotham-Medium"
    case bold = "Gotham-bold"
}

enum ButtonTitles: String {
    case login = "LOGIN"
    case submit = "SUBMIT"
    case editProfile = "EDIT PROFILE"
}

enum Keys: String {
    case fullAddress = "fullAddress"
    case googlePlacesApi = "AIzaSyDu8Jcaz3rWu-e9I8xP2y2hSWnXYnW6IfY"
}
