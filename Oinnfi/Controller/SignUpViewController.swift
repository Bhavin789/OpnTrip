//
//  SignUpViewController.swift
//  Oinnfi
//
//  Created by Bhavin on 03/01/18.
//  Copyright © 2018 Bhavin. All rights reserved.
//

import UIKit
import SwiftyJSON

class SignUpViewController: UIViewController {

    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var lastNameField: UITextField!
    @IBOutlet weak var mailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var confirmField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    
    let delegate = UIApplication.shared.delegate as! AppDelegate
    override func viewDidLoad() {
        super.viewDidLoad()
        cancelButton.addTarget(self, action: #selector(handleCancel), for: .touchUpInside)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func handleCancel(){
        self.dismiss(animated: true, completion: nil)
    }

    func showAlert(_ msg: String){
        let alert = UIAlertController(title: "OpenTrip", message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func handleSignUp(){
        if (nameField.text?.characters.count == 0){
            showAlert("Please enter first name")
            return
        }
        
        if (lastNameField.text?.characters.count == 0){
            showAlert("Please enter last name")
            return
        }
        
        if (mailField.text?.characters.count == 0){
            showAlert("Please enter mail id")
            return
        }
        
        if(!AppDelegate.nsStringIsValidEmail(mailField.text!)){
            showAlert("Enter a valid email")
            return
        }
        
        
        if (passwordField.text?.characters.count == 0){
            showAlert("Please enter password")
            return
        }
        
        if(confirmField.text?.characters.count == 0){
            showAlert("Please confirm password")
            return
        }
        
        if let mail = mailField.text, let password = passwordField.text, let firstName = nameField.text, let lastName = lastNameField.text{
            var registrationString = "http://www.opntrip.com/restfulapi/request.php?authkey=VR9RP1K2VU1YZ6FQNDDGJGWQWVX3IW1X&service=newcust&email=\(mail)&passwd=\(password)&lastname=\(lastName)&firstname=\(firstName)"
            
            callWebService(webUrl: registrationString, viewController: self)
        }
    }
    
    func callWebService(webUrl urlString: String, viewController cont: UIViewController) {
        var url = URL(string: urlString)
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let taskData = data else{
                print("error fetching")
                return
            }
            
            if error != nil{
                print(error?.localizedDescription)
                return
            }
            
            print(urlString)
            
            let json = JSON(taskData)
            print(json)
            
             let firstName = json["datajson"]["customer"]["firstname"].string
             let lastName = json["datajson"]["customer"]["lastname"].string
             let id = json["datajson"]["customer"]["id"].string
             let token = json["datajson"]["customer"]["secure_key"].string
             let mail = json["datajson"]["customer"]["email"].string
             let cust = json["datajson"]["customer"]
             
             print(cust)
             //var custo = json["datajson"]["customer"]
             
             if (cust != JSON.null){
                if let fname = firstName, let lname = lastName, let userid = id, let userToken = token, let mailid = mail{
             
                    var nameString = "\(fname) \(lname)"
                    print(nameString)
             
                    if (userToken.characters.count > 0){
                            UserDefaults.standard.set(userToken, forKey: "token")
                            UserDefaults.standard.set(userid, forKey: "UserID")
                            UserDefaults.standard.set(nameString, forKey: "name")
                            UserDefaults.standard.set(mailid, forKey: "Email")
                            DispatchQueue.main.async {
                                let delegate = UIApplication.shared.delegate as! AppDelegate
                                delegate.afterLogin()
                            }
                    }
                }
             }else{
                var message = json["datajson"].string
                if let msg = message{
                        DispatchQueue.main.async {
                            self.showAlert(msg)
                        }
                }
             }
        }
        task.resume()
    }
}
