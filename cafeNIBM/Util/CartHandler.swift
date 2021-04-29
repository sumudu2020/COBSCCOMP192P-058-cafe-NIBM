//
//  CartHandler.swift
//  cafeNIBM
//
//  Created by Janani on 2021-04-22.
//

import Foundation

class CartHandler {
    
    static var foodItems : [FoodItem] = []
    
    static func getCartItem() -> [FoodItem]{
        
        return foodItems
    }
    static func clearCart(){
        
        self.foodItems.removeAll()
    }
}
