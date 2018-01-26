//
//  PlayerViewController.swift
//  datatest
//
//  Created by Bhavin on 27/12/17.
//  Copyright © 2017 Bhavin. All rights reserved.
//

import UIKit
import CoreData
import AVFoundation
import MediaPlayer

class PlayerViewController: UIViewController {
    
    var player: AVAudioPlayer?
    var imageData: Data?
    var playbackSlider:UISlider?
    var flag: Int!
    var isPlaying: Bool?
    var myView: UIView!
    var url: String!
    var language: String!
    var maturity: String!
    var storyteller: String!
    var about : String!
    var length: String!
    var imageUrl: String!
    
    let mainView: UIView = {
        let myView = UIView()
        myView.translatesAutoresizingMaskIntoConstraints = false
        myView.layer.shadowOpacity = 1
        myView.layer.shadowRadius = 24
        myView.backgroundColor = UIColor.white
        myView.layer.shadowColor = UIColor.lightGray.cgColor
        myView.layer.cornerRadius = 8
        return myView
    }()
    
    
    let image: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = #imageLiteral(resourceName: "logo")
        imageView.clipsToBounds = true
        imageView.layer.shadowRadius = 20
        imageView.layer.shadowOpacity = 0.6
        imageView.layer.cornerRadius = 8
        return imageView
    }()
    
    let cancelButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setBackgroundImage(#imageLiteral(resourceName: "cancelImage"), for: .normal)
        return button
    }()
    
    let playpauseButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(nil, for: .normal)
        button.setBackgroundImage(#imageLiteral(resourceName: "play.png"), for: .normal)
        return button
    }()
    
    let currTime: UILabel = {
        let label = UILabel()
        label.text = "0:00"
        // label.backgroundColor = UIColor.blue
        label.font = UIFont(name: "Avenir-Book", size: 24)
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(red: 255/255, green: 102/255, blue: 102/255, alpha: 1)
        return label
    }()
    
    let durTime: UILabel = {
        let label = UILabel()
        label.text = "0:00"
        //label.backgroundColor = UIColor.green
        label.font = UIFont(name: "Avenir-Book", size: 24)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(red: 255/255, green: 102/255, blue: 102/255, alpha: 1)
        return label
    }()
    
    let subView: UIView = {
        let myView = UIView()
        myView.translatesAutoresizingMaskIntoConstraints = false
        //myView.backgroundColor = UIColor.yellow
        return myView
    }()
    
    /*let myView: UIView = {
     let myView = UIView()
     myView.translatesAutoresizingMaskIntoConstraints = false
     myView.backgroundColor = UIColor.yellow
     return myView
     }()*/
    
    let storyTeller: UILabel = {
        let label = UILabel()
        label.text = "STORY TELLER"
        //label.backgroundColor = UIColor.green
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(red: 255/255, green: 102/255, blue: 102/255, alpha: 1)
        return label
    }()
    
    let controlSeparator: UIView = {
        
        let mailSeparatorView = UIView()
        mailSeparatorView.backgroundColor = UIColor(red: 220/255, green: 220/255, blue: 220/255, alpha: 1)
        mailSeparatorView.translatesAutoresizingMaskIntoConstraints = false
        
        return mailSeparatorView
    }()
    
    let tellerName: UILabel = {
        let label = UILabel()
        label.text = "Mayank Kumar"
        label.textColor = UIColor(red: 100/255, green: 100/255, blue: 100/255, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        //label.backgroundColor = UIColor.green
        return label
    }()
    
    let storyDescription: UILabel = {
        let label = UILabel()
        label.text = " cbejbcker "
        label.textColor = UIColor(red: 100/255, green: 100/255, blue: 100/255, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        //label.backgroundColor = UIColor.green
        return label
    }()
    
    let storyTypes: UILabel = {
        let label = UILabel()
        label.text = "STORY TYPES"
        //label.backgroundColor = UIColor.green
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(red: 255/255, green: 102/255, blue: 102/255, alpha: 1)
        return label
    }()
    
    let contentLabel: UILabel = {
        let label = UILabel()
        label.text = "Content Maturity - show"
        label.textColor = UIColor(red: 100/255, green: 100/255, blue: 100/255, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        //label.backgroundColor = UIColor.green
        return label
    }()
    
    let lengthLabel: UILabel = {
        let label = UILabel()
        label.text = "Length - Short"
        label.textColor = UIColor(red: 100/255, green: 100/255, blue: 100/255, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        //label.backgroundColor = UIColor.green
        return label
    }()
    
    let aboutLabel: UILabel = {
        let label = UILabel()
        label.text = "ABOUT STORY"
        //label.backgroundColor = UIColor.green
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(red: 255/255, green: 102/255, blue: 102/255, alpha: 1)
        return label
    }()
    
    var timer: Timer!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let scrollView = UIScrollView(frame: self.view.bounds)
        scrollView.backgroundColor = UIColor.white
        self.view.addSubview(scrollView)
        scrollView.contentSize = CGSize(width: self.view.frame.width, height: self.view.frame.height + 150)
        
        myView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height + 150))
        myView.backgroundColor = UIColor.white
        scrollView.addSubview(myView)
        
        playbackSlider = UISlider(frame:CGRect(x: 10, y: 368, width: 300, height: 15))
        playbackSlider!.minimumValue = 0
        playbackSlider?.maximumValue = 0
        playbackSlider!.isContinuous = true
        playbackSlider!.tintColor = UIColor(red: 255/255, green: 102/255, blue: 102/255, alpha: 1)
        playbackSlider?.thumbTintColor = UIColor(red: 255/255, green: 102/255, blue: 102/255, alpha: 1)
        playbackSlider?.addTarget(self, action: #selector(playbackSliderValueChanged(_:)), for: .valueChanged)
        playbackSlider?.addTarget(self, action: #selector(playbackSliderValueChangedForTouchUpInside(_:)), for: .touchUpInside)
        playbackSlider?.layer.shadowColor = UIColor(red: 255/255, green: 102/255, blue: 102/255, alpha: 1).cgColor
        myView.addSubview(playbackSlider!)
        myView.addSubview(mainView)
        myView.addSubview(cancelButton)
        myView.addSubview(subView)
        myView.addSubview(controlSeparator)
        myView.addSubview(storyTeller)
        myView.addSubview(tellerName)
        myView.addSubview(storyTypes)
        myView.addSubview(contentLabel)
        myView.addSubview(lengthLabel)
        myView.addSubview(aboutLabel)
        myView.addSubview(storyDescription)
        subView.addSubview(currTime)
        subView.addSubview(durTime)
        subView.addSubview(playpauseButton)
        mainView.addSubview(image)
        playpauseButton.isEnabled = false
        
        setupPlayerUI()
        cancelButton.addTarget(self, action: #selector(handleDismiss), for: .touchUpInside)
        playpauseButton.addTarget(self, action: #selector(handlePlayPause), for: .touchUpInside)
        flag = 1
        isPlaying = false
        tellerName.text = storyteller
        lengthLabel.text = "Length - \(length!)"
        contentLabel.text = "Content Maturity - \(maturity!)"
        image.loadImageUsingCacheWithUrlString(urlString: imageUrl)
        downloadFileToDB()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func setupPlayerUI(){
        
        cancelButton.leftAnchor.constraint(equalTo: myView.leftAnchor, constant: 8).isActive = true
        cancelButton.heightAnchor.constraint(equalToConstant: 32).isActive = true
        cancelButton.widthAnchor.constraint(equalToConstant: 32).isActive = true
        cancelButton.topAnchor.constraint(equalTo: myView.topAnchor, constant: 3).isActive = true

        
        mainView.leftAnchor.constraint(equalTo: myView.leftAnchor, constant: 16).isActive = true
        mainView.rightAnchor.constraint(equalTo: myView.rightAnchor, constant: -16).isActive = true
        mainView.topAnchor.constraint(equalTo: cancelButton.bottomAnchor, constant: 8).isActive = true
        mainView.bottomAnchor.constraint(equalTo: myView.bottomAnchor, constant: -370).isActive = true
        
        image.leftAnchor.constraint(equalTo: mainView.leftAnchor, constant: 0).isActive = true
        image.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 0).isActive = true
        image.rightAnchor.constraint(equalTo: mainView.rightAnchor, constant: 0).isActive = true
        image.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: 0).isActive = true
        
        subView.leftAnchor.constraint(equalTo: myView.leftAnchor, constant: 0).isActive = true
        subView.rightAnchor.constraint(equalTo: myView.rightAnchor, constant: 0).isActive = true
        subView.topAnchor.constraint(equalTo: (playbackSlider?.bottomAnchor)!, constant: 12).isActive = true
        subView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        playpauseButton.centerXAnchor.constraint(equalTo: subView.centerXAnchor).isActive = true
        playpauseButton.widthAnchor.constraint(equalToConstant: 60).isActive = true
        playpauseButton.topAnchor.constraint(equalTo: subView.topAnchor, constant: 8).isActive  = true
        playpauseButton.bottomAnchor.constraint(equalTo: subView.bottomAnchor, constant: -8).isActive = true
        
        currTime.leftAnchor.constraint(equalTo: subView.leftAnchor, constant: 24).isActive = true
        currTime.centerYAnchor.constraint(equalTo: subView.centerYAnchor).isActive = true
        //currTime.widthAnchor.constraint(equalToConstant: 80).isActive = true
        //currTime.rightAnchor.constraint(equalTo: subView.rightAnchor, constant: -200).isActive = true
        currTime.rightAnchor.constraint(equalTo: playpauseButton.leftAnchor, constant: -16).isActive = true
        currTime.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        durTime.rightAnchor.constraint(equalTo: subView.rightAnchor, constant: -24).isActive = true
        durTime.centerYAnchor.constraint(equalTo: subView.centerYAnchor).isActive = true
        // durTime.widthAnchor.constraint(equalToConstant: 80).isActive = true
        durTime.leftAnchor.constraint(equalTo: playpauseButton.rightAnchor, constant: 16).isActive = true
        durTime.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        controlSeparator.widthAnchor.constraint(equalTo: myView.widthAnchor).isActive = true
        controlSeparator.topAnchor.constraint(equalTo: subView.bottomAnchor).isActive = true
        controlSeparator.heightAnchor.constraint(equalToConstant: 1).isActive = true
        controlSeparator.leftAnchor.constraint(equalTo: myView.leftAnchor).isActive = true
        
        aboutLabel.leftAnchor.constraint(equalTo: myView.leftAnchor, constant: 8).isActive = true
        aboutLabel.topAnchor.constraint(equalTo: subView.bottomAnchor, constant: 8).isActive = true
        aboutLabel.rightAnchor.constraint(equalTo: myView.rightAnchor, constant: -8).isActive = true
        aboutLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        storyDescription.topAnchor.constraint(equalTo: aboutLabel.bottomAnchor, constant: 8).isActive = true
        storyDescription.leftAnchor.constraint(equalTo: myView.leftAnchor, constant: 8).isActive = true
        storyDescription.rightAnchor.constraint(equalTo: myView.rightAnchor, constant: -24).isActive = true
        storyDescription.heightAnchor.constraint(equalToConstant: 18).isActive = true
        
        storyTypes.topAnchor.constraint(equalTo: storyDescription.bottomAnchor, constant: 16).isActive = true
        storyTypes.leftAnchor.constraint(equalTo: myView.leftAnchor, constant: 8).isActive = true
        storyTypes.rightAnchor.constraint(equalTo: myView.rightAnchor, constant: -24).isActive = true
        storyTypes.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        contentLabel.leftAnchor.constraint(equalTo: myView.leftAnchor, constant: 8).isActive = true
        contentLabel.topAnchor.constraint(equalTo: storyTypes.bottomAnchor, constant: 8).isActive = true
        contentLabel.rightAnchor.constraint(equalTo: myView.rightAnchor, constant: -24).isActive = true
        contentLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        lengthLabel.leftAnchor.constraint(equalTo: myView.leftAnchor, constant: 8).isActive = true
        lengthLabel.topAnchor.constraint(equalTo: contentLabel.bottomAnchor, constant: 8).isActive = true
        lengthLabel.rightAnchor.constraint(equalTo: myView.rightAnchor, constant: -24).isActive = true
        lengthLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        storyTeller.topAnchor.constraint(equalTo: lengthLabel.bottomAnchor, constant: 16).isActive = true
        storyTeller.leftAnchor.constraint(equalTo: myView.leftAnchor, constant: 8).isActive = true
        storyTeller.rightAnchor.constraint(equalTo: myView.rightAnchor, constant: -24).isActive = true
        storyTeller.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        tellerName.topAnchor.constraint(equalTo: storyTeller.bottomAnchor, constant: 8).isActive = true
        tellerName.leftAnchor.constraint(equalTo: myView.leftAnchor, constant: 8).isActive = true
        tellerName.rightAnchor.constraint(equalTo: myView.rightAnchor, constant: -24).isActive = true
        tellerName.heightAnchor.constraint(equalToConstant: 18).isActive = true
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func downloadFileToDB(){
        
        guard let audioUrl = url else{ return }
        let trackURL = "http://\(audioUrl)"
        let r = DispatchQueue.global(qos: .default)
        r.async(execute: {() -> Void in
            
            do {
                let audiodata = try Data(contentsOf: URL(string: trackURL)!)
                print("AUDIO DATA******")
                print(audiodata)
                
                DispatchQueue.main.async {
                    self.playAudio(audiodata)
                }
            } catch let error {
                print(error.localizedDescription)
            }
        })
        
        
    }
    
    @objc func handlePlayPause(_ button: UIButton){
        print("HI")
        
        if isPlaying!{
            //button.titleLabel?.text = "Play"
            button.setBackgroundImage(#imageLiteral(resourceName: "play"), for: .normal)
            self.handlePause()
        }
        else{
            button.setBackgroundImage(#imageLiteral(resourceName: "ic_launcher"), for: .normal)
            //button.titleLabel?.text = "Pause"
            self.handlePlay()
        }
    }
    
    @objc func playbackSliderValueChanged(_ playbackSlider:UISlider)
    {
        guard let player = self.player else { return }
        print("value is changing")
        
        if flag == 1{
            if((self.timer) != nil){
                print("got the timer")
                self.stopTimer()
            }
            isPlaying = false
            player.stop()
        }
        flag = 0
        self.updateSliderLabels()
        
    }
    
    @objc func handleDismiss(){
        self.player = nil
        handlePause()
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func playbackSliderValueChangedForTouchUpInside(_ playbackSlider: UISlider){
        print("called")
        guard let player = self.player else { return }
        isPlaying = false
        player.stop()
        
        let seconds : Int64 = Int64(playbackSlider.value)
        let targetTime:CMTime = CMTimeMake(seconds, 1)
        
        let time = CMTimeGetSeconds(targetTime)
        print(CMTimeGetSeconds(targetTime))
        
        //player.currentTime = playbackSlider.value
        let curtime = TimeInterval(playbackSlider.value)
        player.currentTime = curtime
        
        player.prepareToPlay()
        flag = 1
        self.handlePlay()
    }
    
    func updateDisplay(){
        guard let player = self.player else { return }
        var currentTime = player.currentTime
        self.playbackSlider?.value = Float(currentTime)
        updateSliderLabels()
    }
    
    func updateSliderLabels(){
        
        guard let player = self.player else { return }
        let seconds = self.playbackSlider?.value
        
        let currseconds = Int(seconds!) % 60
        let onesPlace = Int(currseconds) % 10
        let tensPlace = Int(currseconds)/10
        
        let currMins = Int(seconds!)/60
        self.currTime.text = "\(currMins):\(tensPlace)\(onesPlace)"
    }
    
    func stopTimer(){
        print("timer stopped")
        self.timer.invalidate()
    }
    
    @objc func timerFired(){
        //print("timer Fired")
        self.updateDisplay()
    }
    
    @objc func handlePlay(){
        
        print("handle playe")
        isPlaying = true
        guard let player = self.player else { return }
        player.prepareToPlay()
        player.play()
        
        self.timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(timerFired), userInfo: nil, repeats: true)
        
        
    }
    
    @objc func handlePause(){
        
        print("handle Pause")
        isPlaying = false
        guard let player = self.player else { return }
        player.pause()
        self.stopTimer()
        self.updateDisplay()
    }
    
    func playAudio(_ urlData: Data){
        do {
            
            playpauseButton.isEnabled = true
            self.player = try AVAudioPlayer(data: urlData)
            guard let player = self.player else { return }
            
            
            let seconds = player.duration
            
            let mySecs = Int(seconds) % 60
            let myMins = Int(seconds / 60)
            
            print(mySecs)
            print(myMins)
            
            self.durTime.text = "\(myMins):\(mySecs)"
            
            playbackSlider!.maximumValue = Float(seconds)
            
            
            //player.play()
        } catch let error {
            print(error.localizedDescription)
        }
    }
}
