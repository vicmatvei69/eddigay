//
//  CollectionMatesViewController.swift
//  Classe
//
//  Created by Jason Bourne on 20/10/18.
//  Copyright © 2018 Gianluca Littamè. All rights reserved.
//

import UIKit
import RealmSwift
class CollectionMatesViewController: UIViewController {
    @IBOutlet var collectionView: UICollectionView!
    var position : Int!
    var primaryKey : String!
    var user : User?
    var mates : [Mate] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        updateData()
        // Do any additional setup after loading the view.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if let destinationSegue = segue.destination as? SelectMateViewController{
            destinationSegue.primaryKey = primaryKey
            destinationSegue.position = position
        }
        if let destinationSegue = segue.destination as? ListMatesController{
            destinationSegue.primaryKey = primaryKey
        }
    }
    func updateData(){
        let realm = try!Realm(configuration: RealmUtils.config)
        user = realm.object(ofType:User.self, forPrimaryKey: primaryKey)
        mates = user!.getMates()
    }
}
extension CollectionMatesViewController: UICollectionViewDelegate,UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    override func viewWillAppear(_ animated: Bool) {
        updateData()
        collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 20
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        position = indexPath.row
        self.performSegue(withIdentifier: "selectMateSegue", sender: self)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.kIdentifier, for: indexPath) as! CollectionViewCell
        for mate in mates{
            if mate.position>=0{
                if mate.position == indexPath.row{
                    cell.nameProfile.text = mate.fullName()
                    if let imageProfile = mate.image {
                        cell.imageProfile.image = UIImage(data: imageProfile)
                    } else {
                        cell.imageProfile.image = UIImage(named: "Placeholder-image")
                    }
                }
            }
        }
        
        return cell
    }
}
