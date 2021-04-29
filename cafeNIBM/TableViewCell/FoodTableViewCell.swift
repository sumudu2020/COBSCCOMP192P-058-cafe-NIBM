//
//  FoodTableViewCell.swift
//  cafeNIBM
//
//  Created by Janani on 2021-04-13.
//

import UIKit
import Kingfisher

class FoodTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var imgFood: UIImageView!
    @IBOutlet weak var lblFoodName: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblFoodPrice: UILabel!
    @IBOutlet weak var viewContainer: UIView!
    @IBOutlet weak var lblDiscount: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
    func setupView (foodItem : FoodItem){
        
        lblFoodName.text = foodItem.foodName
        lblDescription.text = foodItem.foodDescription
        lblFoodPrice.text = "LKR \(foodItem.foodPrice)"
        imgFood.image = UIImage(named: foodItem.image)
        imgFood.kf.setImage(with: URL(string: foodItem.image))
        
        if foodItem.discount > 0 {
            
            viewContainer.isHidden = false
            lblDiscount.text = "\(foodItem.discount)%"
        }
            else{
              
                
                viewContainer.isHidden = true
                lblDiscount.text = ""
        }
    }
    
    
}
