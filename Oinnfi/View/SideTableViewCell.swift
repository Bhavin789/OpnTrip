//
//  SideTableViewCell.swift
//  Oinnfi
//
//  Created by Bhavin on 16/12/17.
//  Copyright © 2017 Bhavin. All rights reserved.
//

import UIKit

class SideTableViewCell: UITableViewCell {

    let categoryImageView: UIImageView = {
        
        let profileimageView = UIImageView()
        //profileimageView.image = UIImage(named: "Logout")
        profileimageView.translatesAutoresizingMaskIntoConstraints = false
        // profileimageView.layer.cornerRadius = 20
        profileimageView.contentMode = .scaleAspectFit
        profileimageView.layer.masksToBounds = true
        return profileimageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
       // label.tintColor = UIColor(red: 146/255, green: 146/255, blue: 146/255, alpha: 1)
        label.textColor = UIColor(red: 146/255, green: 146/255, blue: 146/255, alpha: 1)
        
        return label
    }()
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        
        addSubview(categoryImageView)
        addSubview(titleLabel)
        
        // addSubview(timeLabel)
        
        
        categoryImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 8).isActive = true
        categoryImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        categoryImageView.widthAnchor.constraint(equalToConstant: 40).isActive = true
        categoryImageView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        //titleLabel.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: categoryImageView.rightAnchor, constant: 8).isActive = true
        titleLabel.widthAnchor.constraint(equalToConstant: 130).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
    }
    
    func setElements(_ imageName: String,_ title: String ){
        categoryImageView.image = UIImage(named: imageName)
        titleLabel.text = title
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
