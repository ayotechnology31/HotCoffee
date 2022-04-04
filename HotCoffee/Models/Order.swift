//
//  Order.swift
//  HotCoffee
//
//  Created by Amphavanh Lithyouvong on 3/25/22.
//  Copyright © 2022 Mohammad Azam. All rights reserved.
//

import Foundation


enum CoffeeType: String, Codable, CaseIterable {
    
    case cappuccino
    case latte
    case espressino
    case cortado
    
}


enum CoffeeSize: String, Codable, CaseIterable {
    case small
    case medium
    case large
}


struct Order: Codable {
    
    let name: String
    let email: String
    let type: CoffeeType
    let size: CoffeeSize
    
}


/// implementing the resource for creating new orders
extension Order {
    
    // a static property; use in OrdersTableViewController
    static var all: Resource<[Order]> = {
        
        guard let url = URL(string: "https://warp-wiry-rugby.glitch.me/orders") else {
            fatalError("URL is incorrect!")
        }
        
        return Resource<[Order]>(url: url)
    }()
    
    
    static func create(vm: AddCoffeeOrderViewModel) -> Resource<Order?> {
        let order = Order(vm)
        guard let url = URL(string: "https://warp-wiry-rugby.glitch.me/orders") else {
            fatalError("URL is incorrect!")
        }
        
        guard let data = try? JSONEncoder().encode(order) else {
            fatalError("Error encoding order!")
        }
        
        var resource = Resource<Order?>(url: url)
        resource.httpMethod = HttpMethod.post
        resource.body = data
        
        return resource
        
    }
}

///populating Model using View Model
extension Order {
    
    init?(_ vm: AddCoffeeOrderViewModel) {
        
        guard let name = vm.name,
              let email = vm.email,
              let selectedType = CoffeeType(rawValue: vm.selectedType!.lowercased()),
        let selectedSize = CoffeeSize(rawValue: vm.selectedSize!.lowercased())
        else {
            return nil
        }
        
        self.name = name
        self.email = email
        self.type = selectedType
        self.size = selectedSize
        
    }
}
