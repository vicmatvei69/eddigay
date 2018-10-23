//
//  OrderViewController.swift
//  Classe
//
//  Created by Jason Bourne on 20/10/18.
//  Copyright © 2018 Gianluca Littamè. All rights reserved.
//

import UIKit
protocol OrderByDelegate {
    func orderBy(orderByName : Bool?,orderBySurname : Bool?,orderByRating : Bool?,
                 primaryKey: String!)
}
class OrderViewController: UIViewController {
    var orderByDelegate : OrderByDelegate!
    var orderByName : Bool?
    var orderBySurname : Bool?
    var orderByRating : Bool?
    var primaryKey : String!
    @IBOutlet var orderView: UIView!
    @IBAction func orderByNameAction(_ sender: Any) {
        orderByDelegate.orderBy(orderByName: true, orderBySurname: false, orderByRating: false, primaryKey: primaryKey)
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func orderBySurnameAction(_ sender: Any) {
        
        orderByDelegate.orderBy(orderByName: false, orderBySurname: true, orderByRating: false, primaryKey: primaryKey)
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func orderByRatingAction(_ sender: Any) {
        orderByDelegate.orderBy(orderByName: false, orderBySurname: false, orderByRating: true, primaryKey: primaryKey)
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        orderView.layer.cornerRadius = 10
        orderView.layer.masksToBounds = true
        // Do any additional setup after loading the view.
    }
    
    /*override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if let destinationSegue = (segue.destination as? UINavigationController)?.viewControllers[0] as? ListMatesController{
            destinationSegue.orderByRating = orderByRating
            destinationSegue.orderBySurname = orderBySurname
            destinationSegue.orderByName = orderByName
            destinationSegue.primaryKey = primaryKey
        }
    }*/

}
