//
//  Extentions.swift
//  Oinnfi
//
//  Created by Bhavin on 20/12/17.
//  Copyright © 2017 Bhavin. All rights reserved.
//

import Foundation
import UIKit

let imageCache = NSCache<AnyObject, AnyObject>()

extension UIImageView{
    
    func loadImageUsingCacheWithUrlString(urlString: String){
        
        self.image = nil
        
        if let cachedImage = imageCache.object(forKey: urlString as AnyObject) as? UIImage{
            self.image = cachedImage
            return
        }
        
        let imageUrl = NSURL(string: urlString)
        
        let request = URLRequest(url:imageUrl! as URL)
        
        //print(request)
        
        URLSession.shared.dataTask(with: request, completionHandler: { (Data, response, error) in
            if error != nil{
                print(error!)
                return
            }
            
            
            DispatchQueue.main.async(execute: {
                
                if let downloadedimage = UIImage(data: Data!){
                    
                    imageCache.setObject(downloadedimage, forKey: urlString as AnyObject)
                    self.image = downloadedimage
                }
                
            })
            
            
        }).resume()
        
    }
}

extension UIColor{
    
}
