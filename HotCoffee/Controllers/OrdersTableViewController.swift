//
//  OrdersTableViewController.swift
//  HotCoffee
//
//  Created by Mohammad Azam on 5/10/19.
//  Copyright © 2019 Mohammad Azam. All rights reserved.
//

import Foundation
import UIKit

class OrdersTableViewController: UITableViewController, AddCoffeeOrderDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        populateOrders()
    }

    // delegate functions of AddCoffeeOrderDelegate
    
    func addCoffeeOrderViewControllerDidClose(controller: UIViewController) {
        
        controller.dismiss(animated: true, completion: nil)
    }
    
    func addCoffeeOrderViewControllerDidSave(order: Order, controller: UIViewController) {
        
        controller.dismiss(animated: true, completion: nil)
        
        let orderVM = OrderViewModel(order: order)
        self.orderListViewModel.ordersViewModel.append(orderVM)
        self.tableView.insertRows(at: [IndexPath.init(row: self.orderListViewModel.ordersViewModel.count - 1, section: 0)], with: .automatic)
    }
    //create view model
    var orderListViewModel = OrderListViewModel()
    
    
    
    private func populateOrders() {
//        guard let coffeeOrdersURL = URL(string:
//            "https://warp-wiry-rugby.glitch.me/orders") else {
//            fatalError("URL was incorrect")
//
//        }
//
        //let resource = Resource<[Order]>(url: coffeeOrdersURL)
        //Webservice().load(resource: resource) { [weak self] result in
        //add below (resource: Order.all)
        
        
        Webservice().load(resource: Order.all) { [weak self] result in
            switch result {
                case .success(let orders):
                    //print(orders)
                self?.orderListViewModel.ordersViewModel = orders.map(OrderViewModel.init)
                self?.tableView.reloadData()
                case .failure(let error):
                    print(error)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let navC = segue.destination as?  UINavigationController,
              let addCoffeeOrderVC = navC.viewControllers.first as? AddOrderViewController else {
                  fatalError("Error performing segue!")
              }
        
        addCoffeeOrderVC.delegate = self
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.orderListViewModel.ordersViewModel.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let vm = self.orderListViewModel.orderViewModel(at: indexPath.row)
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrderTableViewCell", for: indexPath)
        
        cell.textLabel?.text = vm.type
        cell.detailTextLabel?.text = vm.size
        
        return cell
    }
}
