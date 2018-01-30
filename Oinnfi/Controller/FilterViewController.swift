//
//  FilterViewController.swift
//  Oinnfi
//
//  Created by Bhavin on 30/01/18.
//  Copyright © 2018 Bhavin. All rights reserved.
//

import UIKit
import M13Checkbox

protocol FilterProtocol {
    func applyTheFilters(_ languageFilterArray: [String], _ contentFilterArray: [String], _ lengthFilterArray: [String])
    func sendBoolean(_ filterApplied: Bool)
}
class FilterViewController: UIViewController {
    
    let topView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 255/255, green: 102/255, blue: 102/255, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let filterLabel: UILabel = {
        let label = UILabel()
        label.text = "Apply Filters"
        // label.backgroundColor = UIColor.green
        label.font = UIFont(name: "HelveticaNeue", size: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.white
        return label
    }()
    
    let languageLabel: UILabel = {
        let label = UILabel()
        label.text = "LANGUAGE"
        //label.backgroundColor = UIColor.green
        //label.font = UIFont(name: "HelveticaNeue-Bold", size: 16)
        //label.font = UIFont.systemFont(ofSize: 20, weight: .thin)
        
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(red: 255/255, green: 102/255, blue: 102/255, alpha: 1)
        return label
    }()
    
    let languageSeparator: UIView = {
        
        let separatorView = UIView()
        separatorView.backgroundColor = UIColor(red: 220/255, green: 220/255, blue: 220/255, alpha: 1)
        separatorView.translatesAutoresizingMaskIntoConstraints = false
        return separatorView
    }()
    
    let englishButton: UIButton = {
        let button = UIButton()
        button.setTitle("English", for: .normal)
        button.setImage(nil, for: .normal)
        button.contentHorizontalAlignment = .left
        //button.backgroundColor = UIColor.black
        button.setTitleColor(UIColor(red: 255/255, green: 102/255, blue: 102/255, alpha: 1), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .thin)
        button.addTarget(self, action: #selector(handleSelect(_:)), for: .touchUpInside)
        // button.tintColor = UIColor(red: 255/255, green: 102/255, blue: 102/255, alpha: 1)
        return button
    }()
    
    let hindiButton: UIButton = {
        let button = UIButton()
        button.setTitle("Hindi", for: .normal)
        button.setImage(nil, for: .normal)
        button.contentHorizontalAlignment = .left
        button.setTitleColor(UIColor(red: 255/255, green: 102/255, blue: 102/255, alpha: 1), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .thin)
        button.addTarget(self, action: #selector(handleSelect(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let frenchButton: UIButton = {
        let button = UIButton()
        button.setTitle("French", for: .normal)
        button.setImage(nil, for: .normal)
        button.contentHorizontalAlignment = .left
        button.setTitleColor(UIColor(red: 255/255, green: 102/255, blue: 102/255, alpha: 1), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .thin)
        button.addTarget(self, action: #selector(handleSelect(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let spanishButton: UIButton = {
        let button = UIButton()
        button.setTitle("Spanish", for: .normal)
        button.setImage(nil, for: .normal)
        button.contentHorizontalAlignment = .left
        button.setTitleColor(UIColor(red: 255/255, green: 102/255, blue: 102/255, alpha: 1), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .thin)
        button.addTarget(self, action: #selector(handleSelect(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let germanButton: UIButton = {
        let button = UIButton()
        button.setTitle("German", for: .normal)
        button.setImage(nil, for: .normal)
        button.contentHorizontalAlignment = .left
        button.setTitleColor(UIColor(red: 255/255, green: 102/255, blue: 102/255, alpha: 1), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .thin)
        button.addTarget(self, action: #selector(handleSelect(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let gujaratiButton: UIButton = {
        let button = UIButton()
        button.setTitle("Gujarati", for: .normal)
        button.setImage(nil, for: .normal)
        button.contentHorizontalAlignment = .left
        button.setTitleColor(UIColor(red: 255/255, green: 102/255, blue: 102/255, alpha: 1), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .thin)
        button.addTarget(self, action: #selector(handleSelect(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let othersButton: UIButton = {
        let button = UIButton()
        button.setTitle("Others", for: .normal)
        button.setImage(nil, for: .normal)
        button.contentHorizontalAlignment = .left
        button.setTitleColor(UIColor(red: 255/255, green: 102/255, blue: 102/255, alpha: 1), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .thin)
        button.addTarget(self, action: #selector(handleSelect(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let contentLabel: UILabel = {
        let label = UILabel()
        label.text = "CONTENT MATURITY"
        //label.backgroundColor = UIColor.green
        //label.font = UIFont(name: "HelveticaNeue-Bold", size: 16)
        //label.font = UIFont.systemFont(ofSize: 20, weight: .thin)
        
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(red: 255/255, green: 102/255, blue: 102/255, alpha: 1)
        return label
    }()
    
    let contentSeparator: UIView = {
        
        let separatorView = UIView()
        separatorView.backgroundColor = UIColor(red: 220/255, green: 220/255, blue: 220/255, alpha: 1)
        separatorView.translatesAutoresizingMaskIntoConstraints = false
        return separatorView
    }()
    
    let allButton: UIButton = {
        let button = UIButton()
        button.setTitle("All Audiences - Age Below 13", for: .normal)
        button.setImage(nil, for: .normal)
        button.contentHorizontalAlignment = .left
        button.setTitleColor(UIColor(red: 255/255, green: 102/255, blue: 102/255, alpha: 1), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .thin)
        button.addTarget(self, action: #selector(handleSelect(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let matureButton: UIButton = {
        let button = UIButton()
        button.setTitle("Mature - Age 18+", for: .normal)
        button.setImage(nil, for: .normal)
        button.contentHorizontalAlignment = .left
        button.setTitleColor(UIColor(red: 255/255, green: 102/255, blue: 102/255, alpha: 1), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .thin)
        button.addTarget(self, action: #selector(handleSelect(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let teenButton: UIButton = {
        let button = UIButton()
        button.setTitle("Teen Audiences - Age 13 to 18", for: .normal)
        button.setImage(nil, for: .normal)
        button.contentHorizontalAlignment = .left
        button.setTitleColor(UIColor(red: 255/255, green: 102/255, blue: 102/255, alpha: 1), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .thin)
        button.addTarget(self, action: #selector(handleSelect(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let lengthLabel: UILabel = {
        let label = UILabel()
        label.text = "LENGTH"
        //label.backgroundColor = UIColor.green
        //label.font = UIFont(name: "HelveticaNeue-Bold", size: 16)
        //label.font = UIFont.systemFont(ofSize: 20, weight: .thin)
        
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(red: 255/255, green: 102/255, blue: 102/255, alpha: 1)
        return label
    }()
    
    let lengthSeparator: UIView = {
        let separatorView = UIView()
        separatorView.backgroundColor = UIColor(red: 220/255, green: 220/255, blue: 220/255, alpha: 1)
        separatorView.translatesAutoresizingMaskIntoConstraints = false
        return separatorView
    }()
    
    let shortButton: UIButton = {
        let button = UIButton()
        button.setTitle("Short", for: .normal)
        button.setImage(nil, for: .normal)
        button.contentHorizontalAlignment = .left
        button.setTitleColor(UIColor(red: 255/255, green: 102/255, blue: 102/255, alpha: 1), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .thin)
        button.addTarget(self, action: #selector(handleSelect(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let mediumButton: UIButton = {
        let button = UIButton()
        button.setTitle("Medium", for: .normal)
        button.setImage(nil, for: .normal)
        button.contentHorizontalAlignment = .left
        button.setTitleColor(UIColor(red: 255/255, green: 102/255, blue: 102/255, alpha: 1), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .thin)
        button.addTarget(self, action: #selector(handleSelect(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let longButton: UIButton = {
        let button = UIButton()
        button.setTitle("Long", for: .normal)
        button.setImage(nil, for: .normal)
        button.contentHorizontalAlignment = .left
        button.setTitleColor(UIColor(red: 255/255, green: 102/255, blue: 102/255, alpha: 1), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .thin)
        button.addTarget(self, action: #selector(handleSelect(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let applyButton: UIButton = {
        let button = UIButton()
        button.setTitle("Apply", for: .normal)
        button.setImage(nil, for: .normal)
        //button.contentHorizontalAlignment = .left
        button.backgroundColor = UIColor(red: 255/255, green: 102/255, blue: 102/255, alpha: 1)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .thin)
        button.setTitleColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(applyFilters), for: .touchUpInside)
        return button
    }()
    
    var myView: UIView!
    var englishCheckBox: M13Checkbox!
    var hindiCheckBox: M13Checkbox!
    var frenchCheckBox: M13Checkbox!
    var spanishCheckBox: M13Checkbox!
    var gujaratiCheckBox: M13Checkbox!
    var germanCheckBox: M13Checkbox!
    var othersCheckBox: M13Checkbox!
    
    var shortCheckBox: M13Checkbox!
    var mediumCheckBox: M13Checkbox!
    var longCheckBox: M13Checkbox!
    
    var allCheckBox: M13Checkbox!
    var maturityCheckBox: M13Checkbox!
    var teenCheckBox: M13Checkbox!
    
    var languageFilter = [String]()
    var contentFilter = [String]()
    var lengthFilter = [String]()
    
    var delegate: FilterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let scrollView = UIScrollView(frame: self.view.bounds)
        scrollView.backgroundColor = UIColor.white
        self.view.addSubview(scrollView)
        scrollView.contentSize = CGSize(width: self.view.frame.width, height: self.view.frame.height + 150)
        
        myView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height + 150))
        myView.backgroundColor = UIColor.white
        
        
        scrollView.addSubview(myView)
        myView.addSubview(topView)
        topView.addSubview(filterLabel)
        myView.addSubview(languageLabel)
        myView.addSubview(languageSeparator)
        myView.addSubview(contentLabel)
        myView.addSubview(contentSeparator)
        myView.addSubview(lengthLabel)
        myView.addSubview(lengthSeparator)
        myView.addSubview(applyButton)
        setupCheckBoxes()
        setupUI()
        setupLabels()
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func setupCheckBoxes(){
        
        englishCheckBox = M13Checkbox(frame: CGRect(x: 12, y: 113, width: 20, height: 20))
        englishCheckBox.boxType = .square
        englishCheckBox.tintColor = UIColor(red: 255/255, green: 102/255, blue: 102/255, alpha: 1)
        myView.addSubview(englishCheckBox)
        
        hindiCheckBox = M13Checkbox(frame: CGRect(x: 12, y: 140, width: 20, height: 20))
        hindiCheckBox.boxType = .square
        hindiCheckBox.tintColor = UIColor(red: 255/255, green: 102/255, blue: 102/255, alpha: 1)
        myView.addSubview(hindiCheckBox)
        
        frenchCheckBox = M13Checkbox(frame: CGRect(x: 12, y: 165, width: 20, height: 20))
        frenchCheckBox.boxType = .square
        frenchCheckBox.tintColor = UIColor(red: 255/255, green: 102/255, blue: 102/255, alpha: 1)
        myView.addSubview(frenchCheckBox)
        
        spanishCheckBox = M13Checkbox(frame: CGRect(x: 12, y: 190, width: 20, height: 20))
        spanishCheckBox.boxType = .square
        spanishCheckBox.tintColor = UIColor(red: 255/255, green: 102/255, blue: 102/255, alpha: 1)
        myView.addSubview(spanishCheckBox)
        
        gujaratiCheckBox = M13Checkbox(frame: CGRect(x: 12, y: 215, width: 20, height: 20))
        gujaratiCheckBox.boxType = .square
        gujaratiCheckBox.tintColor = UIColor(red: 255/255, green: 102/255, blue: 102/255, alpha: 1)
        myView.addSubview(gujaratiCheckBox)
        
        germanCheckBox = M13Checkbox(frame: CGRect(x: 12, y: 240, width: 20, height: 20))
        germanCheckBox.boxType = .square
        //germanCheckBox.tintColor = UIColor(red: 255/255, green: 102/255, blue: 102/255, alpha: 1)
        germanCheckBox.tintColor = .green
        myView.addSubview(germanCheckBox)
        
        othersCheckBox = M13Checkbox(frame: CGRect(x: 12, y: 265, width: 20, height: 20))
        othersCheckBox.boxType = .square
        othersCheckBox.tintColor = UIColor(red: 255/255, green: 102/255, blue: 102/255, alpha: 1)
        myView.addSubview(othersCheckBox)
        
        shortCheckBox = M13Checkbox(frame: CGRect(x: 12, y: 460, width: 20, height: 20))
        shortCheckBox.boxType = .square
        shortCheckBox.tintColor = UIColor(red: 255/255, green: 102/255, blue: 102/255, alpha: 1)
        myView.addSubview(shortCheckBox)
        
        mediumCheckBox = M13Checkbox(frame: CGRect(x: 12, y: 485, width: 20, height: 20))
        mediumCheckBox.boxType = .square
        mediumCheckBox.tintColor = UIColor(red: 255/255, green: 102/255, blue: 102/255, alpha: 1)
        myView.addSubview(mediumCheckBox)
        
        longCheckBox = M13Checkbox(frame: CGRect(x: 12, y: 510, width: 20, height: 20))
        longCheckBox.boxType = .square
        longCheckBox.tintColor = UIColor(red: 255/255, green: 102/255, blue: 102/255, alpha: 1)
        myView.addSubview(longCheckBox)
        
        allCheckBox = M13Checkbox(frame: CGRect(x: 12, y: 337, width: 20, height: 20))
        allCheckBox.boxType = .square
        allCheckBox.tintColor = UIColor(red: 255/255, green: 102/255, blue: 102/255, alpha: 1)
        myView.addSubview(allCheckBox)
        
        maturityCheckBox = M13Checkbox(frame: CGRect(x: 12, y: 362, width: 20, height: 20))
        maturityCheckBox.boxType = .square
        maturityCheckBox.tintColor = UIColor(red: 255/255, green: 102/255, blue: 102/255, alpha: 1)
        myView.addSubview(maturityCheckBox)
        
        teenCheckBox = M13Checkbox(frame: CGRect(x: 12, y: 387, width: 20, height: 20))
        teenCheckBox.boxType = .square
        teenCheckBox.tintColor = UIColor(red: 255/255, green: 102/255, blue: 102/255, alpha: 1)
        myView.addSubview(teenCheckBox)
        
    }
    
    func setupUI(){
        topView.leftAnchor.constraint(equalTo: myView.leftAnchor, constant: 0).isActive = true
        topView.rightAnchor.constraint(equalTo: myView.rightAnchor, constant: 0).isActive = true
        topView.topAnchor.constraint(equalTo: myView.topAnchor, constant: 0).isActive = true
        topView.bottomAnchor.constraint(equalTo: myView.bottomAnchor, constant: -(myView.frame.height - 67)).isActive = true
        
        filterLabel.centerXAnchor.constraint(equalTo: topView.centerXAnchor).isActive = true
        filterLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        filterLabel.topAnchor.constraint(equalTo: topView.topAnchor, constant: 8).isActive = true
        filterLabel.bottomAnchor.constraint(equalTo: topView.bottomAnchor, constant: -8).isActive = true
        
        languageLabel.leftAnchor.constraint(equalTo: myView.leftAnchor, constant: 8).isActive = true
        languageLabel.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: 10).isActive = true
        languageLabel.rightAnchor.constraint(equalTo: myView.rightAnchor, constant: -100).isActive = true
        languageLabel.bottomAnchor.constraint(equalTo: myView.bottomAnchor, constant: -(myView.frame.height - 100)).isActive = true
        
        languageSeparator.topAnchor.constraint(equalTo: languageLabel.bottomAnchor, constant: 5).isActive = true
        languageSeparator.leftAnchor.constraint(equalTo: myView.leftAnchor, constant: 8).isActive = true
        languageSeparator.rightAnchor.constraint(equalTo: languageLabel.rightAnchor).isActive = true
        languageSeparator.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        contentLabel.leftAnchor.constraint(equalTo: myView.leftAnchor, constant: 8).isActive = true
        contentLabel.rightAnchor.constraint(equalTo: myView.rightAnchor, constant: -100).isActive = true
        contentLabel.topAnchor.constraint(equalTo: othersCheckBox.bottomAnchor, constant: 16).isActive = true
        contentLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        contentSeparator.topAnchor.constraint(equalTo: contentLabel.bottomAnchor, constant: 5).isActive = true
        contentSeparator.leftAnchor.constraint(equalTo: myView.leftAnchor, constant: 8).isActive = true
        contentSeparator.rightAnchor.constraint(equalTo: contentLabel.rightAnchor).isActive = true
        contentSeparator.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        lengthLabel.leftAnchor.constraint(equalTo: myView.leftAnchor, constant: 8).isActive = true
        lengthLabel.rightAnchor.constraint(equalTo: myView.rightAnchor, constant: -100).isActive = true
        lengthLabel.topAnchor.constraint(equalTo: teenCheckBox.bottomAnchor, constant: 16).isActive = true
        lengthLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        lengthSeparator.topAnchor.constraint(equalTo: lengthLabel.bottomAnchor, constant: 5).isActive = true
        lengthSeparator.leftAnchor.constraint(equalTo: myView.leftAnchor, constant: 8).isActive = true
        lengthSeparator.rightAnchor.constraint(equalTo: lengthLabel.rightAnchor).isActive = true
        lengthSeparator.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        applyButton.topAnchor.constraint(equalTo: longCheckBox.bottomAnchor, constant: 110).isActive = true
        //applyButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
        applyButton.leftAnchor.constraint(equalTo: myView.leftAnchor, constant: 0).isActive = true
        applyButton.rightAnchor.constraint(equalTo: myView.rightAnchor, constant: 0).isActive = true
        applyButton.bottomAnchor.constraint(equalTo: myView.bottomAnchor, constant: 0).isActive = true
        //applyButton.topAnchor.constraint(equalTo: lengthLabel.bottomAnchor, constant: 20).isActive = true
        
    }
    
    func setupLabels(){
        myView.addSubview(englishButton)
        englishButton.topAnchor.constraint(equalTo: englishCheckBox.topAnchor).isActive = true
        englishButton.leftAnchor.constraint(equalTo: englishCheckBox.rightAnchor, constant: 8).isActive = true
        englishButton.rightAnchor.constraint(equalTo: myView.rightAnchor, constant: -100).isActive = true
        englishButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        myView.addSubview(hindiButton)
        hindiButton.topAnchor.constraint(equalTo: hindiCheckBox.topAnchor).isActive = true
        hindiButton.leftAnchor.constraint(equalTo: hindiCheckBox.rightAnchor, constant: 8).isActive = true
        hindiButton.rightAnchor.constraint(equalTo: myView.rightAnchor, constant: -100).isActive = true
        hindiButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        myView.addSubview(gujaratiButton)
        gujaratiButton.topAnchor.constraint(equalTo: gujaratiCheckBox.topAnchor).isActive = true
        gujaratiButton.leftAnchor.constraint(equalTo: gujaratiCheckBox.rightAnchor, constant: 8).isActive = true
        gujaratiButton.rightAnchor.constraint(equalTo: myView.rightAnchor, constant: -100).isActive = true
        gujaratiButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        myView.addSubview(germanButton)
        germanButton.topAnchor.constraint(equalTo: germanCheckBox.topAnchor).isActive = true
        germanButton.leftAnchor.constraint(equalTo: germanCheckBox.rightAnchor, constant: 8).isActive = true
        germanButton.rightAnchor.constraint(equalTo: myView.rightAnchor, constant: -100).isActive = true
        germanButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        myView.addSubview(spanishButton)
        spanishButton.topAnchor.constraint(equalTo: spanishCheckBox.topAnchor).isActive = true
        spanishButton.leftAnchor.constraint(equalTo: spanishCheckBox.rightAnchor, constant: 8).isActive = true
        spanishButton.rightAnchor.constraint(equalTo: myView.rightAnchor, constant: -100).isActive = true
        spanishButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        myView.addSubview(frenchButton)
        frenchButton.topAnchor.constraint(equalTo: frenchCheckBox.topAnchor).isActive = true
        frenchButton.leftAnchor.constraint(equalTo: frenchCheckBox.rightAnchor, constant: 8).isActive = true
        frenchButton.rightAnchor.constraint(equalTo: myView.rightAnchor, constant: -100).isActive = true
        frenchButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        myView.addSubview(othersButton)
        othersButton.topAnchor.constraint(equalTo: othersCheckBox.topAnchor).isActive = true
        othersButton.leftAnchor.constraint(equalTo: othersCheckBox.rightAnchor, constant: 8).isActive = true
        othersButton.rightAnchor.constraint(equalTo: myView.rightAnchor, constant: -100).isActive = true
        othersButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        myView.addSubview(allButton)
        allButton.topAnchor.constraint(equalTo: allCheckBox.topAnchor).isActive = true
        allButton.leftAnchor.constraint(equalTo: allCheckBox.rightAnchor, constant: 8).isActive = true
        allButton.rightAnchor.constraint(equalTo: myView.rightAnchor, constant: -40).isActive = true
        allButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        myView.addSubview(matureButton)
        matureButton.topAnchor.constraint(equalTo: maturityCheckBox.topAnchor).isActive = true
        matureButton.leftAnchor.constraint(equalTo: maturityCheckBox.rightAnchor, constant: 8).isActive = true
        matureButton.rightAnchor.constraint(equalTo: myView.rightAnchor, constant: -40).isActive = true
        matureButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        myView.addSubview(teenButton)
        teenButton.topAnchor.constraint(equalTo: teenCheckBox.topAnchor).isActive = true
        teenButton.leftAnchor.constraint(equalTo: teenCheckBox.rightAnchor, constant: 8).isActive = true
        teenButton.rightAnchor.constraint(equalTo: myView.rightAnchor, constant: -40).isActive = true
        teenButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        myView.addSubview(shortButton)
        shortButton.topAnchor.constraint(equalTo: shortCheckBox.topAnchor).isActive = true
        shortButton.leftAnchor.constraint(equalTo: shortCheckBox.rightAnchor, constant: 8).isActive = true
        shortButton.rightAnchor.constraint(equalTo: myView.rightAnchor, constant: -40).isActive = true
        shortButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        myView.addSubview(mediumButton)
        mediumButton.topAnchor.constraint(equalTo: mediumCheckBox.topAnchor).isActive = true
        mediumButton.leftAnchor.constraint(equalTo: mediumCheckBox.rightAnchor, constant: 8).isActive = true
        mediumButton.rightAnchor.constraint(equalTo: myView.rightAnchor, constant: -40).isActive = true
        mediumButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        myView.addSubview(longButton)
        longButton.topAnchor.constraint(equalTo: longCheckBox.topAnchor).isActive = true
        longButton.leftAnchor.constraint(equalTo: longCheckBox.rightAnchor, constant: 8).isActive = true
        longButton.rightAnchor.constraint(equalTo: myView.rightAnchor, constant: -40).isActive = true
        longButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        
    }
    
    @objc func handleSelect(_ sender: UIButton){
        if let title = sender.currentTitle{
            switch title{
            case "English":
                englishCheckBox.toggleCheckState()
                if englishCheckBox.checkState == .checked{
                    languageFilter.append(title)
                }else{
                    languageFilter.remove(at: languageFilter.index(of: title)!)
                }
                
            case "Hindi":
                hindiCheckBox.toggleCheckState()
                if hindiCheckBox.checkState == .checked{
                    languageFilter.append(title)
                }else{
                    languageFilter.remove(at: languageFilter.index(of: title)!)
                }
                
            case "German":
                germanCheckBox.toggleCheckState()
                if germanCheckBox.checkState == .checked{
                    languageFilter.append(title)
                }else{
                    languageFilter.remove(at: languageFilter.index(of: title)!)
                }
                
            case "French":
                frenchCheckBox.toggleCheckState()
                if frenchCheckBox.checkState == .checked{
                    languageFilter.append(title)
                }else{
                    languageFilter.remove(at: languageFilter.index(of: title)!)
                }
                
            case "Gujarati":
                gujaratiCheckBox.toggleCheckState()
                if gujaratiCheckBox.checkState == .checked{
                    languageFilter.append(title)
                }else{
                    languageFilter.remove(at: languageFilter.index(of: title)!)
                }
                
            case "Others":
                othersCheckBox.toggleCheckState()
                if othersCheckBox.checkState == .checked{
                    languageFilter.append(title)
                }else{
                    languageFilter.remove(at: languageFilter.index(of: title)!)
                }
                
            case "Spanish":
                spanishCheckBox.toggleCheckState()
                if spanishCheckBox.checkState == .checked{
                    languageFilter.append(title)
                    print(languageFilter)
                }else{
                    languageFilter.remove(at: languageFilter.index(of: title)!)
                }
                
            case "All Audiences - Age Below 13":
                allCheckBox.toggleCheckState()
                if allCheckBox.checkState == .checked{
                    contentFilter.append(title)
                }else{
                    contentFilter.remove(at: contentFilter.index(of: title)!)
                }
                
            case "Mature - Age 18+":
                maturityCheckBox.toggleCheckState()
                if maturityCheckBox.checkState == .checked{
                    contentFilter.append(title)
                }else{
                    contentFilter.remove(at: contentFilter.index(of: title)!)
                }
                
            case "Teen Audiences - Age 13 to 18":
                teenCheckBox.toggleCheckState()
                if teenCheckBox.checkState == .checked{
                    contentFilter.append(title)
                    print(contentFilter)
                }else{
                    contentFilter.remove(at: contentFilter.index(of: title)!)
                }
                
            case "Short":
                shortCheckBox.toggleCheckState()
                if shortCheckBox.checkState == .checked{
                    lengthFilter.append(title)
                }else{
                    lengthFilter.remove(at: lengthFilter.index(of: title)!)
                }
                
            case "Medium":
                mediumCheckBox.toggleCheckState()
                if mediumCheckBox.checkState == .checked{
                    lengthFilter.append(title)
                }else{
                    lengthFilter.remove(at: lengthFilter.index(of: title)!)
                }
                
            case "Long":
                longCheckBox.toggleCheckState()
                if longCheckBox.checkState == .checked{
                    lengthFilter.append(title)
                    print(lengthFilter)
                }else{
                    lengthFilter.remove(at: lengthFilter.index(of: title)!)
                }
            default:
                print("default")
                print(title)
            }
        }
        
    }
    
    @objc func applyFilters(){
        print("applying>>>>>>>")
        delegate?.applyTheFilters(self.languageFilter, self.contentFilter, self.lengthFilter)
        if self.languageFilter.count == 0 && self.contentFilter.count == 0 && self.lengthFilter.count == 0{
            delegate?.sendBoolean(false)
        }else{
            delegate?.sendBoolean(true)
        }
        self.dismiss(animated: true, completion: nil)
        
    }
}
