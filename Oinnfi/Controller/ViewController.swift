//
//  ViewController.swift
//  Oinnfi
//
//  Created by Bhavin on 11/12/17.
//  Copyright © 2017 Bhavin. All rights reserved.
//

import UIKit
import SwiftyJSON

class ViewController: UIViewController {
    
    let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1)
        button.setTitle("SIGN IN", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 6
        button.layer.masksToBounds = true
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        button.restorationIdentifier="loginbutton"
        
        button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        return button
    }()
    
    let signupButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("SKIP", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.masksToBounds = true
        button.tintColor = UIColor(red: 255/255, green: 102/255, blue: 102/255, alpha: 1)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .thin)
        button.restorationIdentifier="loginbutton"
        
        button.addTarget(self, action: #selector(handleSkip), for: .touchUpInside)
        return button
    }()
    
    lazy var  logoImage: UIImageView = {
        
        let profileImage = UIImageView()
        
        profileImage.image = UIImage(named: "logo")
        profileImage.translatesAutoresizingMaskIntoConstraints = false
        profileImage.contentMode = .scaleAspectFill
        return profileImage
        
    }()
    
    let nameTextField: UITextField = {
        let txtField = UITextField()
        
        txtField.placeholder = "Enter Email ID or Phone Number"
        txtField.translatesAutoresizingMaskIntoConstraints = false
        
        return txtField
    }()
    
    let nameSeparator: UIView = {
        
        let nameSeparatorView = UIView()
        nameSeparatorView.backgroundColor = UIColor(red: 193/255, green: 193/255, blue: 193/255, alpha: 1)
        nameSeparatorView.translatesAutoresizingMaskIntoConstraints = false
        
        return nameSeparatorView
        
        
    }()
    
    let passwordTextField: UITextField = {
        let txtField = UITextField()
        
        txtField.placeholder = "Enter Password"
        txtField.translatesAutoresizingMaskIntoConstraints = false
        
        return txtField
    }()
    
    let passwordSeperator: UIView = {
        
        let nameSeparatorView = UIView()
        nameSeparatorView.backgroundColor = UIColor(red: 193/255, green: 193/255, blue: 193/255, alpha: 1)
        nameSeparatorView.translatesAutoresizingMaskIntoConstraints = false
        
        return nameSeparatorView
        
        
    }()

    let signinButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(red: 255/255, green: 102/255, blue: 102/255, alpha: 1)
        button.setTitle("SIGN IN", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 6
        button.layer.masksToBounds = true
        
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        button.restorationIdentifier="loginbutton"
        
        button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        return button
    }()
    
    let newLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "New User?"
        lbl.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        lbl.textColor = UIColor(red: 255/255, green: 102/255, blue: 102/255, alpha: 1)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("SIGN UP", for: .normal)
        button.setImage(nil, for: .normal)
        button.tintColor = UIColor(red: 255/255, green: 102/255, blue: 102/255, alpha: 1)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 6
        button.layer.masksToBounds = true
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        
        button.addTarget(self, action: #selector(handleRegister), for: .touchUpInside)
        return button
    }()
    
    let forgetPasswordButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Forgot Password", for: .normal)
        button.setImage(nil, for: .normal)
        
        button.tintColor = UIColor(red: 255/255, green: 102/255, blue: 102/255, alpha: 1)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        button.layer.masksToBounds = true
        button.titleEdgeInsets.left = -10
        button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        return button
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.view.addSubview(loginButton)
        self.view.addSubview(signupButton)
        self.view.addSubview(logoImage)
        self.view.addSubview(nameTextField)
        self.view.addSubview(nameSeparator)
        self.view.addSubview(passwordTextField)
        self.view.addSubview(passwordSeperator)
        self.view.addSubview(signinButton)
        self.view.addSubview(newLabel)
        self.view.addSubview(signUpButton)
        self.view.addSubview(forgetPasswordButton)
        
        nameTextField.autocorrectionType = .no
        passwordTextField.autocorrectionType = .no
        
        passwordTextField.isSecureTextEntry = true
        nameTextField.autocapitalizationType = UITextAutocapitalizationType.none
        
       // loginButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
       // loginButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 30).isActive = true
       // loginButton.widthAnchor.constraint(equalToConstant: 80).isActive = true
       // loginButton.heightAnchor.constraint(equalToConstant: 55).isActive = true
        
        signupButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 30).isActive = true
        signupButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        signupButton.widthAnchor.constraint(equalToConstant: 65).isActive = true
        signupButton.heightAnchor.constraint(equalToConstant: 45).isActive = true
        
        logoImage.topAnchor.constraint(equalTo: signupButton.bottomAnchor, constant: 30).isActive = true
        logoImage.widthAnchor.constraint(equalToConstant: 160).isActive = true
        logoImage.heightAnchor.constraint(equalToConstant: 160).isActive = true
        logoImage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        nameTextField.topAnchor.constraint(equalTo: logoImage.bottomAnchor, constant: 10).isActive = true
        nameTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        nameTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        nameTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        nameSeparator.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 0).isActive = true
        nameSeparator.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        nameSeparator.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        nameSeparator.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        passwordTextField.topAnchor.constraint(equalTo: nameSeparator.bottomAnchor, constant: 5).isActive = true
        passwordTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        passwordTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        passwordTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        passwordSeperator.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 0).isActive = true
        passwordSeperator.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        passwordSeperator.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        passwordSeperator.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        signinButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        signinButton.topAnchor.constraint(equalTo: passwordSeperator.topAnchor, constant: 8).isActive = true
        signinButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        signinButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        
        newLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        newLabel.topAnchor.constraint(equalTo: signinButton.bottomAnchor, constant: 8).isActive = true
        newLabel.heightAnchor.constraint(equalToConstant: 15).isActive = true
        newLabel.widthAnchor.constraint(equalToConstant: 75).isActive = true
        
        signUpButton.leftAnchor.constraint(equalTo: newLabel.rightAnchor, constant: 0).isActive = true
        signUpButton.topAnchor.constraint(equalTo: signinButton.bottomAnchor, constant: 8).isActive = true
        signUpButton.heightAnchor.constraint(equalToConstant: 15).isActive = true
        signUpButton.widthAnchor.constraint(equalToConstant: 70).isActive = true
        
        
        forgetPasswordButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 5).isActive = true
        forgetPasswordButton.topAnchor.constraint(equalTo: newLabel.bottomAnchor, constant: 8).isActive = true
        forgetPasswordButton.heightAnchor.constraint(equalToConstant: 15).isActive = true
        forgetPasswordButton.widthAnchor.constraint(equalToConstant: 150).isActive = true
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func handleSkip(){
        let board = UIStoryboard(name: "Main", bundle: nil)
        let controller = board.instantiateViewController(withIdentifier: "vc2")
        self.present(controller, animated: true, completion: nil)
    }
    
    @objc func handleLogin(){
        
        if(nameTextField.text?.characters.count == 0){
            showAlert("Please enter mail id")
            return
        }
        
        if(passwordTextField.text?.characters.count == 0){
            showAlert("Please enter password")
            return
        }
        
        if let mail = nameTextField.text, let password = passwordTextField.text{
             var registrationString = "http://www.opntrip.com/restfulapi/request.php?authkey=VR9RP1K2VU1YZ6FQNDDGJGWQWVX3IW1X&service=auth&email=\(mail)&passwd=\(password)"
            callWebService(webUrl: registrationString, viewController: self)
        }
    }
    
    @objc func handleRegister(){
        let board = UIStoryboard(name: "Main", bundle: nil)
        let controller = board.instantiateViewController(withIdentifier: "signupvc")
        self.present(controller, animated: true, completion: nil)
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
    
    func showAlert(_ msg: String){
        let alert = UIAlertController(title: "OpenTrip", message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }


}

