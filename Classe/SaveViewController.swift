//
//  SaveViewController.swift
//  Classe
//
//  Created by Jason Bourne on 18/10/18.
//  Copyright © 2018 Gianluca Littamè. All rights reserved.
//


import UIKit
import RealmSwift

class SaveViewController: UIViewController {
    var mail : String?
    var password : String?
    var imageUser : Data?
    private var primaryKey : String!
    private var users : [User] = []
    private var pickerController:UIImagePickerController?
    @IBOutlet var imageProfile: UIButton!
    @IBOutlet var addressField: UITextField!
    @IBOutlet var mobileField: UITextField!
    @IBOutlet var surnameField: UITextField!
    @IBOutlet var nameField: UITextField!
    @IBAction func save(_ sender: Any) {
        let name : String? = nameField.text
        let surname : String? = surnameField.text
            if (name == "" || surname == "") {
                let alert = UIAlertController(title: "Attenzione", message: "Name and surname must not be empty", preferredStyle: .alert)
                let okay = UIAlertAction(title: "Okay", style: .cancel, handler: nil)
                alert.addAction(okay)
                self.present(alert, animated: true, completion: nil)
                
            }
            else {
                let mobile : String? = mobileField.text
                let address : String? = addressField.text
                let user = User(name : name, surname: surname, mail: mail, password: password, image: imageUser, mobile: mobile, address: address)
                user.add()
                primaryKey = user.id
                self.performSegue(withIdentifier: "listMatesSegue", sender: self)
            }
    }
    @IBAction func addPictureProfile(_ sender: Any) {
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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        users = User.all()
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if let destinationSegue = (segue.destination as? UINavigationController)?.viewControllers[0] as? ListMatesController{
            destinationSegue.primaryKey = primaryKey
        }
    }
    
}
extension SaveViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let image = info[.editedImage] as? UIImage else {
            debugPrint("No image found")
            return
        }
        
        let img = checkImageSizeAndResize(image: image)
        imageProfile.setImage(img, for: .normal)
        imageUser = img.pngData()
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
extension UIImage {
    
    func resized(withPercentage percentage: CGFloat) -> UIImage? {
        let canvasSize = CGSize(width: size.width * percentage, height: size.height * percentage)
        UIGraphicsBeginImageContextWithOptions(canvasSize, false, scale)
        defer { UIGraphicsEndImageContext() }
        draw(in: CGRect(origin: .zero, size: canvasSize))
        return UIGraphicsGetImageFromCurrentImageContext()
    }
    
}



