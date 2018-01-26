//
//  MyAccountViewController.swift
//  Oinnfi
//
//  Created by Bhavin on 26/01/18.
//  Copyright © 2018 Bhavin. All rights reserved.
//

import UIKit

class MyAccountViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var mailLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        if let name = UserDefaults.standard.value(forKey: "name"), let mailId = UserDefaults.standard.value(forKey: "Email"){
            print("got it")
            var username = name as! String
            var emailId = mailId as! String
            if (username.characters.count > 0 && emailId.count > 0){
                print(username)
                nameLabel.text = username
                mailLabel.text = emailId
            }else{
                nameLabel.text = "Please login or signup"
                mailLabel.text = ""
            }
        }else{
            nameLabel.text = "Please login or signup"
        }
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
