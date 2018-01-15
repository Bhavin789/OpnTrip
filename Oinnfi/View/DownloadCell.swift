//
//  DownloadCell.swift
//  Oinnfi
//
//  Created by Bhavin on 14/12/17.
//  Copyright © 2017 Bhavin. All rights reserved.
//

import UIKit

class DownloadCell: UITableViewCell {
    
    let categoryImageView: UIImageView = {
        
        let profileimageView = UIImageView()
        profileimageView.image = UIImage(named: "fiction")
        profileimageView.translatesAutoresizingMaskIntoConstraints = false
       // profileimageView.layer.cornerRadius = 20
        profileimageView.layer.masksToBounds = true
        return profileimageView
    }()
    
    let titleLabel: UILabel = {
       let label = UILabel()
        label.text = "Fiction"
        //label.layer.backgroundColor = UIColor.red.cgColor
        label.translatesAutoresizingMaskIntoConstraints = false
        
       return label
    }()
    
    let subTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Horror/Spiritual"
       // label.layer.backgroundColor = UIColor.blue.cgColor
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let pausePlayButton: UIButton = {
        let button = UIButton(type: .system)
        //button.backgroundColor = UIColor(red: 255/255, green: 102/255, blue: 102/255, alpha: 1)
        button.setBackgroundImage(#imageLiteral(resourceName: "ic_launcher"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.masksToBounds = true
        button.restorationIdentifier="loginbutton"
        return button
    }()
    
    let deleteButton: UIButton = {
        let button = UIButton(type: .system)
        //button.backgroundColor = UIColor(red: 255/255, green: 102/255, blue: 102/255, alpha: 1)
        button.setBackgroundImage(#imageLiteral(resourceName: "play.png"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.masksToBounds = true
        button.restorationIdentifier="loginbutton"
        return button
    }()

    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        
        addSubview(categoryImageView)
        addSubview(titleLabel)
        addSubview(subTitleLabel)
        addSubview(pausePlayButton)
        addSubview(deleteButton)
        
       // addSubview(timeLabel)
        
        
        categoryImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 8).isActive = true
        categoryImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        categoryImageView.widthAnchor.constraint(equalToConstant: 70).isActive = true
        categoryImageView.heightAnchor.constraint(equalToConstant: 70).isActive = true
        
        //titleLabel.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 8).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: categoryImageView.rightAnchor, constant: 8).isActive = true
        titleLabel.widthAnchor.constraint(equalToConstant: 130).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
       // subTitleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 18).isActive = true
        subTitleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8).isActive = true
        subTitleLabel.leftAnchor.constraint(equalTo: categoryImageView.rightAnchor, constant: 8).isActive = true
        subTitleLabel.widthAnchor.constraint(equalToConstant: 130).isActive = true
        subTitleLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        pausePlayButton.leftAnchor.constraint(equalTo: subTitleLabel.rightAnchor, constant: 8).isActive = true
        pausePlayButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8).isActive = true
        pausePlayButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        pausePlayButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        deleteButton.leftAnchor.constraint(equalTo: pausePlayButton.rightAnchor, constant: 4).isActive = true
        deleteButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8).isActive = true
        deleteButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        deleteButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
