//
//  RegisterViewController.swift
//  Classe
//
//  Created by Jason Bourne on 18/10/18.
//  Copyright © 2018 Gianluca Littamè. All rights reserved.
//

import UIKit
import RealmSwift

class RegisterViewController: UIViewController {
    
    private var users : [User] = []
    var mail : String?
    var password : String?

        
    @IBOutlet var repeatPasswordField: UITextField!
    @IBOutlet var passwordField: UITextField!
    @IBOutlet var mailField: UITextField!
    @IBAction func register(_ sender: Any) {
        if (passwordField.text == repeatPasswordField.text) {
            mail = mailField.text
            password = passwordField.text
            if (mail == "" || password == "") {
                let alert = UIAlertController(title: "Attenzione", message: "You left a field or more empty", preferredStyle: .alert)
                let okay = UIAlertAction(title: "Okay", style: .cancel, handler: nil)
                alert.addAction(okay)
                self.present(alert, animated: true, completion: nil)
                
            }
            else {
                
                if !isValidEmail(testStr: mail!) {
                    
                    let alert = UIAlertController(title: "Attenzione", message: "Email non valida", preferredStyle: .alert)
                    let okay = UIAlertAction(title: "Okay", style: .cancel, handler: nil)
                    alert.addAction(okay)
                    self.present(alert, animated: true, completion: nil)
                    
                }
                    
                else {
                    self.performSegue(withIdentifier: "saveSegue", sender: self)
                    
                }
                
            }
            
        }
        else {
            
            let alert = UIAlertController(title: "Attenzione", message: "Le password inserite non corrispondono", preferredStyle: .alert)
            let okay = UIAlertAction(title: "Okay", style: .cancel, handler: nil)
            alert.addAction(okay)
            self.present(alert, animated: true, completion: nil)
            
        }
        
        
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if let destinationSegue = segue.destination as? SaveViewController{
            destinationSegue.mail = mail
            destinationSegue.password = password
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        users = User.all()
        
    }
    
    func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
}
