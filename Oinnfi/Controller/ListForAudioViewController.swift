//
//  ListForAudioViewController.swift
//  Oinnfi
//
//  Created by Bhavin on 21/12/17.
//  Copyright © 2017 Bhavin. All rights reserved.
//

import UIKit
import SwiftyJSON
import AFNetworking
import AVFoundation
import AVKit
import MediaPlayer
import CoreData


class ListForAudioViewController: UITableViewController {
    

    var name: String!
    var cat_id: String!
    var count: Int!
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var items = [Item]()
    var audio = [Audio]()
    var language = [String]()
    var coverImage = [String]()
    var player: AVAudioPlayer!
    var playerItem: AVPlayerItem!
    var audioPlayer: AVAudioPlayer!
    var track: DownloadedFile!
    var imagePath: String!
    var audioUrl: String!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(DownloadCell.self, forCellReuseIdentifier: "reuseIdentifier")
        self.navigationItem.title = name
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white, NSAttributedStringKey.font: UIFont(name: "Arial", size: 18.0)!]
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 255/255, green: 102/255, blue: 102/255, alpha: 1)
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.isTranslucent = false
        
        count = 1;
        getData()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return items.count
    }
    
    func getData(){
        
        let id = Int(cat_id)
        guard let categoryid = id, let c = count else{
            print("error")
            return
        }
        
        let request = NSMutableURLRequest(url: NSURL(string: "\(appDelegate.APPLICATIONURL)\("category")&id_category=\(categoryid)&p=\(c)")! as URL)
        
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request.url!) { (data, response, error) -> Void in
            
            if let data = data {
                let json = JSON(data)
                for (_, subJson): (String, JSON) in json["datajson"]["products"]{
                    if var item = Item(fromJson: subJson){
                        
                        // MARK: Loop to extract only the audio
                        
                        for (_, subJson): (String, JSON) in item.audio{
                            guard let audioId = subJson["id"].string,
                                let proId = subJson["product_id"].string,
                                let title = subJson["title"].string,
                                let fullPath = subJson["full_path"].string,
                                let cuttingPath = subJson["cutting_path"].string else{
                                    return
                            }
                            
                            let audio = Audio(id: audioId, proId: proId, title: title, fullPath: fullPath, cutPath: cuttingPath)
                            self.audio.append(audio)
                        }
                        
                        // MARK: Loop to extract only the language
                        
                        for (_, subJson): (String, JSON) in item.features{
                            let name = subJson["name"]
                            switch name{
                            case "Language":
                                if let language = subJson["value"].string{
                                    item.language = language
                                    self.language.append(language)
                                }
                            case "Content Maturity":
                                item.contentMaturity = subJson["value"].string!
                            case "Length":
                                item.length = subJson["value"].string!
                            default:
                                print("")
                            }
                        }
                        
                        self.items.append(item)
                    }
                }
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
        task.resume()
        print("Task completed")
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as? DownloadCell
        
        cell?.categoryImageView.loadImageUsingCacheWithUrlString(urlString: items[indexPath.row].coverImage)
        cell?.titleLabel.text = items[indexPath.row].name
        print(items[indexPath.row].name)
        cell?.subTitleLabel.text = language[indexPath.row]
        cell?.deleteButton.addTarget(self, action: #selector(downloadFileToDB), for: .touchUpInside)
        // Configure the cell...
        
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewController = PlayerViewController()
        viewController.language = language[indexPath.row]
        viewController.storyteller = items[indexPath.row].narratorName
        viewController.maturity = items[indexPath.row].contentMaturity!
        viewController.length = items[indexPath.row].length!
        viewController.url = audio[indexPath.row].audioFullPath
        viewController.imageUrl = items[indexPath.row].coverImage
        viewController.storyName = items[indexPath.row].name
        
        self.present(viewController, animated: true, completion: nil)
        
    }
            
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
        
    }
    
    @objc func downloadFileToDB(_ sender: UIButton){
        print("clicked")
        var buttonPosition = sender.convert(CGPoint.zero, to: tableView)
        var downloadIndexPath: IndexPath? = tableView.indexPathForRow(at: buttonPosition)
        
        if(!getTrackByName(name: audio[(downloadIndexPath?.row)!].audioTitle)){
            let imageUrl = items[(downloadIndexPath?.row)!].coverImage
            var q = DispatchQueue.global(qos: .default)
            q.async(execute: {() -> Void in
                /* Fetch the Media from the server... */
                
                do{
                    var videoData = try Data(contentsOf: URL(string: imageUrl)!)
                    DispatchQueue.main.async(execute: {() -> Void in
                        do{
                            let fileManager = FileManager.default
                            let documentsurl = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
                            let documentPath = documentsurl.path
                            let filepath = documentsurl.appendingPathComponent("\(self.uuid()).jpg")
                            self.imagePath = filepath.path
                            try videoData.write(to: filepath, options: .atomic)
                        
                        }catch{
                            print("Error while saving")
                        }
                    })
                } catch{
                    print("error")
                }
            })
            
            var trackURL = "http://\(audio[(downloadIndexPath?.row)!].audioFullPath)"
            var r = DispatchQueue.global(qos: .default)
            r.async(execute: {() -> Void in
                /* Fetch the Media from the server... */
                do{
                    
                    print(trackURL)
                    
                    var urlData = try Data(contentsOf: URL(string: trackURL)!)
                    DispatchQueue.main.async(execute: {() -> Void in
                        if urlData != nil {
                            do{
                                
                                let fileManager = FileManager.default
                                let documentsurl = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
                                let documentPath = documentsurl.path
                                
                                let filepath = documentsurl.appendingPathComponent("\(self.uuid()).mp3")
                                self.audioUrl = filepath.path
                                
                                try urlData.write(to: filepath, options: .atomic)
                       
                            }catch {
                                print("Error in writing the data to mediaPath")
                            }
                        }
                    })
                }catch{
                    print("Didn't recieved data")
                }
                
                if let index = downloadIndexPath?.row{
                    print(self.audio[index])
                    DispatchQueue.main.async{
                        let res = DownloadedFile.saveObject(name: self.audio[(downloadIndexPath?.row)!].audioTitle, category: self.name!, mediaImage: self.imagePath, url: self.audioUrl)
                        if(res){
                            print("saved")
                        }else{
                            print("failed to save")
                        }
                    }
                }else{
                    print("error gettign")
                }
                           })
        }
    }
    
    func getTrackByName(name: String) -> Bool{
        var count: Int = 0
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let context = delegate.persistentContainer.viewContext
        var files: [DownloadedFile]? = nil
        do {
            files = try context.fetch(DownloadedFile.fetchRequest())
            
            if let filesData = files{
                for file in filesData{
                    if file.mediaName == name{
                        count+=1;
                    }
                }
            }
            
            if (count == 0){
                return false
            }else {
                return true
            }
            
        } catch  {
            print("Error in fetching")
            return false
        }
    }
    
    func urlForNewImage() -> String {
        return "\(documentPath())/\(uuid()).jpg"
    }
    
    func urlForNewMp3() -> String {
        return "\(documentPath())/\(uuid()).mp3"
    }
    
    func documentPath() -> String {
        let strPath: String = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        return strPath
    }
    
    func uuid() -> String {
        let uuidRef: CFUUID = CFUUIDCreate(nil)
        let uuidStringRef: CFString = CFUUIDCreateString(nil, uuidRef)
        return (uuidStringRef as? String) ?? ""
    }
        
}

    /*
 
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */


