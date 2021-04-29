//
//  SignInViewController.swift
//  cafeNIBM
//
//  Created by Janani on 2021-04-11.
//

import UIKit
import Firebase
import Loaf

class SignInViewController: UIViewController {

    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        ref = Database.database().reference()
       
    }
    

    @IBAction func onSignInPressed(_ sender: UIButton) {
        
        if !InputValidator.isValidEmail(email: txtEmail.text ?? ""){
            Loaf ("Invalid Email Address", state: .error, sender: self).show()
            return
        }
        if !InputValidator.isValidPassword(pass: txtPassword.text ?? "", minLength: 6, maxLength: 50){
            Loaf ("Invalid Password", state: .error, sender: self).show()
            return
        }
       authenticateUser(email: txtEmail.text!, password: txtPassword.text!)
            }
       
      
    func authenticateUser (email : String , password : String){
        
        Auth.auth().signIn(withEmail: email, password: password) {
            authResult, error in
            
            if let err = error  {
                print(err.localizedDescription)
                Loaf ("User Name or password Invalied", state: .error, sender: self).show()
                return
            }
            
            if let email = authResult?.user.email {
                self.getUserData(email: email)
                }
            else{
                Loaf ("User email not found", state: .error, sender: self).show()
                return
                
            }
            //save user session
            //let SessionManager = sessionManager ()
            //SessionManager.saveUserLogin()
            //self.performSegue(withIdentifier: "SignInToHome", sender: nil)
            
        }
        
       }
        
    func getUserData (email :String){
        
        ref.child("users")
            .child(email
                    .replacingOccurrences(of: "@", with: "_")
                    .replacingOccurrences(of: ".", with: "_")).observe(.value, with: {
                                        (snapshot)  in
                        
                        if snapshot.hasChildren(){
                            if let data = snapshot.value {
                                if let userData = data as? [String : String] {
                                   
                                    let user = User(
                                        userName: userData ["UserName"]!,
                                        userEmail: userData ["UserEmail"]!,
                                        userPassword:userData ["Userpassword"]!,
                                        userPhone: userData ["Userphone"]!)
                                    
                                    let sessionMGR = sessionManager()
                                    sessionMGR.saveUserLogin(user: user)
                                    self.performSegue(withIdentifier: "SignInToHome", sender: nil)
                                }
                                
                            }
                            
                            
                            
                        } else{
                            
                            Loaf ("User not found", state: .error, sender: self).show()
                            
                        }
                    })
                                        
    }
    }
    


