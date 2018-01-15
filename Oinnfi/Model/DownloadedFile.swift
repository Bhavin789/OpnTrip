//
//  DownloadedFile.swift
//  Oinnfi
//
//  Created by Bhavin on 25/12/17.
//  Copyright © 2017 Bhavin. All rights reserved.
//

import Foundation
import CoreData
import UIKit

extension DownloadedFile{
    class func getContext() -> NSManagedObjectContext{
        let delegate = UIApplication.shared.delegate as! AppDelegate
        return delegate.persistentContainer.viewContext
    }
    
    class func saveObject(name: String, category: String, mediaImage: String, url: String) -> Bool{
        let context = getContext()
        let entity = NSEntityDescription.entity(forEntityName: "DownloadedFile", in: context)
        let managedObject = NSManagedObject(entity: entity!, insertInto: context)
        
        managedObject.setValue(name, forKey: "mediaName")
        managedObject.setValue(mediaImage, forKey: "mediaImage")
        managedObject.setValue(category, forKey: "mediaCat")
        managedObject.setValue(url, forKey: "mediaUrl")
        
        do {
            try context.save()
            return true
        } catch  {
            return false
        }
    }
    
    class func getTrackByName(name: String) -> Bool{
        var count: Int = 0
        let context = getContext()
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
}
