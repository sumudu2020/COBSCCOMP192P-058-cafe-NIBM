//
//  CartViewController.swift
//  cafeNIBM
//
//  Created by Janani on 2021-04-23.
//

import UIKit
import Firebase
import Loaf

class CartViewController: UIViewController {

    @IBOutlet weak var tblCartItems: UITableView!
    
    
    var cartItems: [FoodItem] = []
    let sessionmMGR = sessionManager()
    
    var ref: DatabaseReference!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()

        self.cartItems = CartHandler.getCartItem()
        tblCartItems.register(UINib(nibName: "FoodTableViewCell", bundle: nil), forCellReuseIdentifier: "FoodCellReusedIdentifier")
    }
    

    
    @IBAction func onConfirmPressed(_ sender: Any) {
        saveOrder()
    }
    
    @IBAction func btnBackpressed(_ sender: UIButton) {
        
        self.dismiss(animated: true, completion: nil)
    }
    }
extension CartViewController{
    func saveOrder(){
        
        var orderData : [String: Any] = [:]
        var foodItemInfo: [String: Any] = [:]
        
        for index in 0..<cartItems.count{
            
            foodItemInfo.removeAll()
            foodItemInfo["foodName"] = cartItems[index].foodName
            foodItemInfo["foodDescription"] = cartItems[index].foodDescription
            foodItemInfo["foodPrice"] = cartItems[index].foodPrice
            orderData ["\(index)"] = foodItemInfo
        }
        var order : [String: Any] = [:]
        order["Status"] = "pending"
        order["Order Items"] = orderData
        
        self.ref.child("orders").child(sessionmMGR.getUserData().userEmail
                                        
                        .replacingOccurrences(of: "@", with: "_")
                        .replacingOccurrences(of: ".", with:"_"))
            .childByAutoId()
            .setValue(order){
            (error, ref) in
            
            if let err  = error {
                print(err.localizedDescription)
                Loaf ("Order data not Saved on database", state: .error, sender: self).show()
                 return
                
            }
            
            Loaf ("Order data Saved on database", state: .success, sender: self).show(){
                                                
                    type in
                CartHandler.clearCart()
                    self.dismiss(animated: true, completion: nil)
            }
                                            
        }
        
    }
    
}

extension CartViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cartItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblCartItems.dequeueReusableCell(withIdentifier: "FoodCellReusedIdentifier", for: indexPath) as! FoodTableViewCell
        cell.setupView(foodItem: cartItems[indexPath.row])
        return cell
    }
    
    
}

