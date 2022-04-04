//
//  OrderViewModel.swift
//  HotCoffee
//
//  Created by Amphavanh Lithyouvong on 3/25/22.
//  Copyright © 2022 Mohammad Azam. All rights reserved.
//

import Foundation

//This is a parent view model. It displays entire order in table view
class OrderListViewModel {
    
    var ordersViewModel: [OrderViewModel]
    
    init() {
        self.ordersViewModel = [OrderViewModel]()
    }
}

extension OrderListViewModel {
    
    func orderViewModel(at index: Int) -> OrderViewModel {
        return self.ordersViewModel[index]
    }
}


struct OrderViewModel {
    let order: Order
}

extension OrderViewModel {
    
    var name: String {
        return self.order.name
    }
    
    var email: String {
        return self.order.email
    }
    
    var type: String {
        return self.order.type.rawValue.capitalized
    }
    
    var size: String {
        return self.order.size.rawValue.capitalized
    }
}
