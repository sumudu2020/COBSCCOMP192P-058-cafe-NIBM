//
//  sessionManager.swift
//  cafeNIBM
//
//  Created by Janani on 2021-04-13.
//

import Foundation

class sessionManager{
    
   
    
    func getLoggedState() -> Bool {
       return UserDefaults.standard.bool(forKey: "LOGGED_IN")
        
    }
    
    
    
    func saveUserLogin (user: User){
        UserDefaults.standard.setValue(true, forKey: "LOGGED_IN")
        UserDefaults.standard.setValue(user.userName ,forKey: "USER_NAME")
        UserDefaults.standard.setValue(user.userEmail ,forKey: "USER_Email")
        UserDefaults.standard.setValue(user.userPhone ,forKey: "USER_PHONE")
        
        }
    
    func getUserData() -> User {
      let user = User(
                      userName:UserDefaults.standard.string(forKey: "USER_NAME") ?? "",
                      userEmail: UserDefaults.standard.string(forKey: "USER_Email") ?? "",
                      userPassword: "",
                      userPhone: UserDefaults.standard.string(forKey: "USER_PHONE") ?? "")
        return user
    }
    
    func clearUserLoggedState (){
        UserDefaults.standard.setValue(false, forKey: "LOGGED_IN")
        
        
    }
    
}
