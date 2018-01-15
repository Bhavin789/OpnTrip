//
//  CategoryTableViewCell.swift
//  Oinnfi
//
//  Created by Bhavin on 18/12/17.
//  Copyright © 2017 Bhavin. All rights reserved.
//

import UIKit
import SwiftyJSON

class CategoryTableViewCell: UITableViewCell {
    
    let categoryImageView: UIImageView = {
        
        let imageView = UIImageView()
        //profileimageView.image = UIImage(named: "Logout")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        // profileimageView.layer.cornerRadius = 20
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        return imageView
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
        
        
        categoryImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: -3).isActive = true
        //categoryImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        categoryImageView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        //categoryImageView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        categoryImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: -10).isActive = true
        categoryImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 5).isActive = true
        
        //titleLabel.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: categoryImageView.rightAnchor, constant: 8).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -8).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
    }
    
    func setElements(_ imageUrl: String,_ title: String ){
        
        categoryImageView.loadImageUsingCacheWithUrlString(urlString: imageUrl)
        titleLabel.text = title
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
