//
//  AddCoffeeOrderViewModel.swift
//  HotCoffee
//
//  Created by Amphavanh Lithyouvong on 3/25/22.
//  Copyright © 2022 Mohammad Azam. All rights reserved.
//

import Foundation

struct AddCoffeeOrderViewModel {
    
    var name: String?
    var email: String?
    
    var selectedType: String?
    var selectedSize: String?
    
    var types: [String] {
        return CoffeeType.allCases.map { $0.rawValue.capitalized }
    }
    
    var sizes: [String] {
        return CoffeeSize.allCases.map { $0.rawValue.capitalized}
    }
}
