//
//  FoodItemViewController.swift
//  cafeNIBM
//
//  Created by Janani on 2021-04-22.
//

import UIKit
import Kingfisher

class FoodItemViewController: UIViewController {

    @IBOutlet weak var imgFood: UIImageView!
    
    @IBOutlet weak var lblFoodName: UILabel!
    
    @IBOutlet weak var lblFoodDescription: UILabel!
    
    @IBOutlet weak var lblFoodPrice: UILabel!
    
    var fooditem : FoodItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let item = self.fooditem {
            imgFood.kf.setImage(with: URL(string: item.image))
            lblFoodName.text = item.foodName
            lblFoodDescription.text = item.foodDescription
            lblFoodPrice.text = "LKR: \(item.foodPrice)"
            
        }
    }
    

    @IBAction func btnBackPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func btnAddToCart(_ sender: Any) {
        
        if let item = self.fooditem {
            CartHandler.foodItems.append(item)
            
        }
        print (CartHandler.foodItems)
    }
    
    
    
}
