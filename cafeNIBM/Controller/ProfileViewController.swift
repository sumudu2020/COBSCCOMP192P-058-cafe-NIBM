//
//  ProfileViewController.swift
//  cafeNIBM
//
//  Created by Janani on 2021-04-22.
//

import UIKit

class ProfileViewController: UIViewController {
    let sessinMGR = sessionManager()
    
    @IBOutlet weak var txtUserName: UILabel!
    
    
    @IBOutlet weak var txtEmail: UILabel!
    
    
    @IBOutlet weak var txtPhone: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let user = sessinMGR.getUserData()
        txtUserName.text = user.userName
        txtEmail.text = user.userEmail
        txtPhone.text = user.userPhone
    }
   
    

    @IBAction func onSignOutPressed(_ sender: UIButton) {
        
        
        sessinMGR.clearUserLoggedState()
    }
    
}
