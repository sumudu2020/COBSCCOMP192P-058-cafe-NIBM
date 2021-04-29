//
//  SignUpViewController.swift
//  cafeNIBM
//
//  Created by Janani on 2021-04-12.
//

import UIKit
import Firebase
import Loaf

class SignUpViewController: UIViewController {
    
    
    @IBOutlet weak var txtname: UITextField!
    
    @IBOutlet weak var txtemail: UITextField!
    
    @IBOutlet weak var txtphone: UITextField!
    
    @IBOutlet weak var txtpassword: UITextField!
    
    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()

        
    }
    

    @IBAction func onSignUppressed(_ sender: UIButton) {
        
        if !InputValidator.isValidName(name: txtname.text ?? ""){
            Loaf ("Invalid name", state: .error, sender: self).show()
            return
        }
        if !InputValidator.isValidEmail(email: txtemail.text ?? ""){
            Loaf ("Invalid Email", state: .error, sender: self).show()
            return
        }
        if !InputValidator.isValidMobileNo(txtphone.text ?? ""){
            Loaf ("Invalid phoneNumber", state: .error, sender: self).show()
            return
        }
        
        
        if !InputValidator.isValidPassword(pass: txtpassword.text ?? "", minLength: 6, maxLength: 50){
            Loaf ("Invalid Password", state: .error, sender: self).show()
            return
        }
        
        let user = User(userName: txtname.text ?? "", userEmail: txtemail.text ?? "", userPassword: txtpassword.text ?? "", userPhone: txtphone.text ?? "")
        
        registerUser(user: user)
        
    }
    @IBAction func SignInPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    func registerUser (user: User) {
        Auth.auth().createUser(withEmail: user.userEmail, password: user.userPassword) { authResult, error in
            if let err  = error {
                print(err.localizedDescription)
                Loaf ("User Sign Up Failed", state: .error, sender: self).show()
                 return
            }
            self.saveUserData(user: user)
            
            
            
            
        }
        
    }
    
    func saveUserData(user: User){
        
        let userData = [
            "UserName" : user.userName,
            "UserEmail" : user.userEmail,
            "Userphone" : user.userPhone,
            "Userpassword" : user.userPassword
        ]
       
        
        
        self.ref.child("users").child(user.userEmail.replacingOccurrences(of: "@", with: "_")
                                        .replacingOccurrences(of: ".", with: "_")).setValue(userData){
            
            (error, ref) in
            
            if let err  = error {
                print(err.localizedDescription)
                Loaf ("User data not Saved on database", state: .error, sender: self).show()
                 return
                
            }
            
            Loaf ("User data Saved on database", state: .success, sender: self).show(){
                                                
                    type in
                    self.dismiss(animated: true, completion: nil)
            }
                                            
        }
        
    }
}
