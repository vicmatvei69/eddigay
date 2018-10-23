//
//  ListMatesController.swift
//  Classe
//
//  Created by Jason Bourne on 18/10/18.
//  Copyright © 2018 Gianluca Littamè. All rights reserved.
//

import UIKit
import RealmSwift

class ListMatesController: UIViewController {
    @IBAction func modifyCollection(_ sender: UIButton) {
        self.performSegue(withIdentifier: "modifyCollectionSegue", sender: self)
    }
    @IBOutlet weak var tableView: UITableView!
    var mates : [Mate] = []
    var primaryKey : String!
    var orderByName : Bool?
    var orderBySurname : Bool?
    var orderByRating : Bool?
    var user : User?
    override func viewDidLoad() {
        super.viewDidLoad()
        updateData()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if let destinationSegue = segue.destination as? AddMateViewController{
            destinationSegue.primaryKey = primaryKey
        }
        if let destinationSegue = segue.destination as? OrderViewController{
            destinationSegue.orderByDelegate = self
            destinationSegue.primaryKey = primaryKey
        }
        if let destinationSegue = segue.destination as? CollectionMatesViewController{
            destinationSegue.primaryKey = primaryKey
        }
    }
    func updateData(){
        let realm = try!Realm(configuration: RealmUtils.config)
        user = realm.object(ofType:User.self, forPrimaryKey: primaryKey)
        mates = user!.getMates()
    }
    
    

    // MARK: - Table view data source
}
extension ListMatesController : UITableViewDelegate, UITableViewDataSource {
    override func viewWillAppear(_ animated: Bool) {
        updateData()
        tableView.reloadData()
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows

        if orderByName ?? false{
            mates = mates.sorted(by: { $0.name < $1.name})
        }
        if orderBySurname ?? false{
            mates = mates.sorted(by: { $0.surname < $1.surname})
        }
        if orderByRating ?? false{
            mates = mates.sorted(by: { $0.rating > $1.rating})
        }
        return mates.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ListMatesCell.kIdentifier, for: indexPath) as! ListMatesCell
        cell.nameProfile.text = mates[indexPath.row].fullName()
        //debugPrint(mates[indexPath.row])
        if let imageProfile = mates[indexPath.row].image {
            cell.imageProfile.image = UIImage(data: imageProfile)
        } else {
            cell.imageProfile.image = UIImage(named: "Placeholder-image")
        }
        for  button in cell.starsButton {
            if button.tag <= mates[indexPath.row].rating{
                button.setImage(UIImage(named: "star"), for: .normal)
            } else {
                button.setImage(UIImage(named: "starempty"), for: .normal)
            }
        }
        // Configure the cell...

        return cell
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            user!.removeMate(index: indexPath.row)
            mates[indexPath.row].remove()
            mates.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
 
}
extension ListMatesController: OrderByDelegate{
    func orderBy(orderByName: Bool?, orderBySurname: Bool?, orderByRating: Bool?, primaryKey: String!) {
        self.orderByName = orderByName
        self.orderBySurname = orderBySurname
        self.orderByRating = orderByRating
        self.primaryKey = primaryKey
        self.tableView.reloadData()
    }
}
