//
//  Validation.swift
//  Neostore_SwiftUI
//
//  Created by Neosoft on 15/01/24.
//

import Foundation
import SwiftUI

//MARK: - Validation
class Validation{
    
    //MARK: - Register validation
    func registerValidation(firstName: String?, lastName: String?, email: String?, password: String?, confirmPassword: String?, mobileNumber: String?) -> String? {
        
        guard firstName != "" && lastName != "" && password != "" && confirmPassword != "" && email != "" && mobileNumber != "" else {
            return "Please fill the required fields"
        }
        
        guard firstName!.count > 3 && containsOnlyCharacters(firstName!) == true else {
            return "Enter a valid first name"
        }
        
        guard lastName!.count > 3 && containsOnlyCharacters(lastName!) == true else {
            return "Enter a valid last name"
        }
        
        if email != "" {
            guard validateEmail(email ?? "") == true else {
                return "Enter a valid email id"
            }
        }
        
        guard password!.count >= 8 && containsOnlyAllowedCharacters(password!) == true && containsOneNumberAndOneSpecialChar(password!) == true else {
            return "Enter a valid password"
        }
        
        guard password! == confirmPassword! else {
            return "Password does not match Confirm Password"
        }
        
        if mobileNumber != "" {
            guard mobileNumber!.count == 10 && containsOnlyNumbers(mobileNumber!) == true else {
                return "Enter a valid mobile number"
            }
        }
        
        return ""
    }
    
    //MARK: - Login validation
    func loginValidation(email: String?, password: String?) -> String?{
        
        guard email != "" && password != "" else {
            return "Please fill the required fields"
        }
        
        if email != "" {
            guard validateEmail(email ?? "") == true else {
                return "Enter a valid email id"
            }
        }
        
        guard password!.count >= 2 && containsOnlyAllowedCharacters(password!) == true && containsOneNumberAndOneSpecialChar(password!) == true else {
            return "Enter a valid password"
        }
        
        return ""
    }
    
    //MARK: - Reset Password Validation
    func resetPassValidation(oldPass: String, newPass: String, confirmPass: String ) -> String? {
        guard oldPass != "" && newPass != "" && confirmPass != "" else {
            return "Please fill the required fields"
        }
        
        guard newPass.count >= 2 && containsOnlyAllowedCharacters(newPass) == true && containsOneNumberAndOneSpecialChar(newPass) == true else {
            return "Enter a valid password"
        }
        
        guard newPass == confirmPass else {
            return "Password does not match Confirm Password"
        }
        return ""
    }
    
    //MARK: - UpdateUser Validation
    func updateUserValidation(fname: String, lname: String, email: String, dob:String,profilePic:String,phone:String) -> String?{
        guard fname != "" && lname != "" && email != "" && dob != "" && profilePic != "" && phone != "" else {
            return "Please fill the required fields"
        }
        
        guard fname.count > 3 && containsOnlyCharacters(fname) == true else {
            return "Enter a valid first name"
        }
        
        guard lname.count > 3 && containsOnlyCharacters(lname) == true else {
            return "Enter a valid last name"
        }
        
        if email != "" {
            guard validateEmail(email ) == true else {
                return "Enter a valid email id"
            }
        }
        
        if phone != "" {
            guard phone.count == 10 && containsOnlyNumbers(phone) == true else {
                return "Enter a valid mobile number"
            }
        }
        return ""
    }
    
    //MARK: - Functions for validations
    func containsOnlyCharacters(_ input: String) -> Bool {
        let characterSet = CharacterSet.letters
        return input.rangeOfCharacter(from: characterSet.inverted) == nil
    }
    
    func containsOnlyAllowedCharacters(_ input: String) -> Bool {
        let allowedCharacterSet = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890!@#$%^&*()_+")
        let inputCharacterSet = CharacterSet(charactersIn: input)
        return allowedCharacterSet.isSuperset(of: inputCharacterSet)
    }
    
    func containsOneNumberAndOneSpecialChar(_ input: String) -> Bool {
        let numberRegex = ".*\\d.*"
        let specialCharRegex = ".*[^A-Za-z0-9].*"
        
        let numberPredicate = NSPredicate(format: "SELF MATCHES %@", numberRegex)
        let specialCharPredicate = NSPredicate(format: "SELF MATCHES %@", specialCharRegex)
        
        let containsNumber = numberPredicate.evaluate(with: input)
        let containsSpecialChar = specialCharPredicate.evaluate(with: input)
        
        return containsNumber && containsSpecialChar
    }
    
    func containsOnlyNumbers(_ input: String) -> Bool {
        let numericCharacterSet = CharacterSet.decimalDigits
        let inputCharacterSet = CharacterSet(charactersIn: input)
        return numericCharacterSet.isSuperset(of: inputCharacterSet)
    }
    
    func validateEmail(_ input: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: input) // Use 'input' instead of 'self'
    }
}
