//
//  OrderViewController.swift
//  cafeNIBM
//
//  Created by Janani on 2021-04-23.
//

import UIKit
import Firebase
import Loaf

class OrderViewController: UIViewController {
    
    @IBOutlet weak var tblOrders: UITableView!
    var orders:[Order] = []
    let sessionmMGR = sessionManager()

    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        
        tblOrders.register(UINib(nibName: "OrderableViewCell", bundle: nil), forCellReuseIdentifier: "OrderCellReusedIdentifier")
    }
    override func viewDidAppear(_ animated: Bool) {
        getAllOrders()
    }
        
}
    


extension OrderViewController{
    func getAllOrders(){
        self.orders.removeAll()
        
        self.ref.child("orders").child(sessionmMGR.getUserData().userEmail
                                        
                        .replacingOccurrences(of: "@", with: "_")
                        .replacingOccurrences(of: ".", with:"_"))
            .observe(.value, with: {
                snapshot in
                if let data = snapshot.value{
                    if let orders = data as?[String:Any]{
                        for singleOrder in orders{
                            var placedOrder = Order()
                            placedOrder.orderID = singleOrder.key
                        
                            if let orderInfo = singleOrder.value as? [String: Any]{
                                //var placedOrder = Order()
                                placedOrder.orderStatus = orderInfo ["Status"] as! String
                                if let orderItems = orderInfo["Order Items"] as? [Any] {
                                    for item in orderItems{
                                        
                                        if let itemInfo = item as?[String: Any]{
                                            placedOrder.ordertotal += itemInfo["foodPrice"] as! Double
                                        }
                                    }
                                }
                                
                            }
                            self.orders.append(placedOrder)
                            
                        }
                        self.tblOrders.reloadData()
                    }
                    
                    
                }
            })
      
    }
    
}
extension OrderViewController: UITableViewDelegate , UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblOrders.dequeueReusableCell(withIdentifier: "OrderCellReusedIdentifier", for: indexPath) as! OrderableViewCell
        cell.setupUI(order: orders[indexPath.row])
        return cell
    }
    
    
    
}
