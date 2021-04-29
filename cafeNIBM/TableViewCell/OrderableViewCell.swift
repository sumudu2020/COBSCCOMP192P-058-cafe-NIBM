//
//  OrderableViewCell.swift
//  cafeNIBM
//
//  Created by Janani on 2021-04-23.
//

import UIKit

class OrderableViewCell: UITableViewCell {

    @IBOutlet weak var lblOrderID: UILabel!
    
    @IBOutlet weak var lblStatus: UILabel!
    
    @IBOutlet weak var lblTotal: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    func setupUI (order: Order){
        lblOrderID.text = order.orderID
        lblStatus.text = order.orderStatus
        lblTotal.text = "LKR \(order.ordertotal)"
        
        
    }
    
}
