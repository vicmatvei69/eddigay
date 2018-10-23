//
//  SelectMateViewController.swift
//  Classe
//
//  Created by Jason Bourne on 20/10/18.
//  Copyright © 2018 Gianluca Littamè. All rights reserved.
//

import UIKit
import RealmSwift

class SelectMateViewController: UIViewController {
    @IBOutlet var tableView: UITableView!
    var mates : [Mate] = []
    var position : Int!
    var primaryKey : String!
    var user : User?
    override func viewDidLoad() {
        super.viewDidLoad()
        let realm = try!Realm(configuration: RealmUtils.config)
        user = realm.object(ofType:User.self, forPrimaryKey: primaryKey)
        mates = user!.getMates()
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if let destinationSegue = segue.destination as? CollectionMatesViewController{
            destinationSegue.primaryKey = primaryKey
        }
        
    }

}
extension SelectMateViewController : UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mates.count
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let message = "Confermi di inserire "+String(mates[indexPath.row].fullName())+" nella posizione "+String(position+1)+" ?"
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .actionSheet)
        let cancel = UIAlertAction(title: "Annulla", style: .cancel, handler: nil)
        alert.addAction(cancel)
 
        let inserisci = UIAlertAction(title: "Conferma", style: .default) { alert in
            
            for i in 0...self.mates.count-1{
                if self.mates[i].position == self.position{
                    self.user?.modifyMate(index: i,position: -1)
                }
            }
            self.user?.modifyMate(index: indexPath.row, position: self.position)
            self.navigationController?.popViewController(animated: true)
        }
        alert.addAction(inserisci)
        
        present(alert, animated: true, completion: nil)
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SelectMateCell.kIdentifier, for: indexPath) as! SelectMateCell
        cell.nameProfile.text = mates[indexPath.row].fullName()
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
}
