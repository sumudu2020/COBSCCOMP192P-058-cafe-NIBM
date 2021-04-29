//
//  LaunchViewController.swift
//  cafeNIBM
//
//  Created by Janani on 2021-04-22.
//

import UIKit

class LaunchViewController: UIViewController {
    
    let sessionMGR = sessionManager()

    override func viewDidLoad() {
        super.viewDidLoad()

        }
    
    override func viewDidAppear(_ animated: Bool) {
        if sessionMGR.getLoggedState(){
            self.performSegue(withIdentifier: "LaunchToHome", sender: nil)
            
        }
            else{
                self.performSegue(withIdentifier: "LaunchToSignIn", sender: nil)
            }
        
    }
    

}
