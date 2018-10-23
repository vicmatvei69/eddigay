//
//  AddMateViewController.swift
//  Classe
//
//  Created by Jason Bourne on 18/10/18.
//  Copyright © 2018 Gianluca Littamè. All rights reserved.
//

import UIKit
import RealmSwift

class AddMateViewController: UIViewController {
    @IBOutlet var imageProfile: UIButton!
    @IBOutlet var nameMate: UITextField!
    @IBOutlet var surnameMate: UITextField!
    private var pickerController : UIImagePickerController?
    private var imageMate : Data?
    private var rating : Int = 0
    var primaryKey : String!
    
    
    @IBOutlet var starsButton: [UIButton]!
    
    @IBAction func updateStars(_ sender: UIButton) {
        for  button in starsButton {
            if button.tag <= sender.tag {
                button.setBackgroundImage(UIImage.init(named: "star"), for: .normal)
            } else {
                button.setBackgroundImage(UIImage.init(named: "starempty"), for: .normal)
            }
        }
        rating = sender.tag
    }
    @IBAction func addMate(_ sender: Any) {
        let name : String? = nameMate.text
        let surname : String? = surnameMate.text
        if (name == "" || surname == "") {
            let alert = UIAlertController(title: "Attenzione", message: "Name and surname must not be empty", preferredStyle: .alert)
            let okay = UIAlertAction(title: "Okay", style: .cancel, handler: nil)
            alert.addAction(okay)
            self.present(alert, animated: true, completion: nil)
            
        }
        else {
            let mate = Mate(name: name, surname: surname,rating: rating,image:imageMate)
            //debugPrint(mate)
            mate.add()
            let realm = try!Realm()
            let user = realm.object(ofType:User.self, forPrimaryKey: primaryKey)
            NSLog(user!.id)
            user!.addingMate(mate: mate)
            self.performSegue(withIdentifier: "backToListMatesSegue", sender: self)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func addingPictureProfile(_ sender: Any) {
        
        self.pickerController = UIImagePickerController()
        self.pickerController!.delegate = self
        self.pickerController!.allowsEditing = true
        
        let alert = UIAlertController(title: nil, message: "Foto profilo", preferredStyle: .actionSheet)
        let cancel = UIAlertAction(title: "Annulla", style: .cancel, handler: nil)
        alert.addAction(cancel)
        
        #if !targetEnvironment(simulator)
        let photo = UIAlertAction(title: "Scatta foto", style: .default) { action in
            self.pickerController!.sourceType = .camera
            self.present(self.pickerController!, animated: true, completion: nil)
        }
        alert.addAction(photo)
        #endif
        
        let camera = UIAlertAction(title: "Carica foto", style: .default) { alert in
            self.pickerController!.sourceType = .photoLibrary
            self.present(self.pickerController!, animated: true, completion: nil)
        }
        alert.addAction(camera)
        
        present(alert, animated: true, completion: nil)
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if let destinationSegue = segue.destination as? ListMatesController{
            destinationSegue.primaryKey = primaryKey
        }
    }
}

extension AddMateViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let image = info[.editedImage] as? UIImage else {
            debugPrint("No image found")
            return
        }
        
        let img = checkImageSizeAndResize(image: image)
        imageProfile.setImage(img, for: .normal)
        imageMate = img.pngData()
        self.dismiss(animated: true, completion: nil)
    }
    
    private func checkImageSizeAndResize(image : UIImage) -> UIImage {
        
        let imageSize: Int = image.pngData()!.count
        let imageDimension = Double(imageSize) / 1024.0 / 1024.0
        print("size of image in MB: ", imageDimension)
        
        if imageDimension > 15 {
            
            let img = image.resized(withPercentage: 0.5) ?? UIImage()
            
            return checkImageSizeAndResize(image: img)
            
        }
        
        return image
        
        
    }
    
}
