//
//  LoginViewController.swift
//  Classe
//
//  Created by Jason Bourne on 18/10/18.
//  Copyright © 2018 Gianluca Littamè. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    

    @IBOutlet var passwordField: UITextField!
    @IBOutlet var mailField: UITextField!
    private var primaryKey : String!
    @IBAction func login(_ sender: Any) {
    let mail : String? = mailField.text
        let password : String? = passwordField.text
        let users = User.all()
        var errorMessage : String?
        var error : Bool = true
        for user in users {
            if user.mail == mail {
                if user.password == password {
                    primaryKey = user.id
                    error = false
                    self.performSegue(withIdentifier: "listMatesSegue", sender: self)
                }
                else {
                    errorMessage = "Your password is wrong"
                }
                
            }
            else {
                errorMessage = "we can't find your mail, are you already signed?"
            }
        }
        if error{
            let alert = UIAlertController(title: "Error", message: errorMessage, preferredStyle: .alert)
            let okay = UIAlertAction(title: "Okay", style: .cancel, handler: nil)
            alert.addAction(okay)
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if let destinationSegue = (segue.destination as? UINavigationController)?.viewControllers[0] as? ListMatesController{
            destinationSegue.primaryKey = primaryKey
        }
    }
    
}

