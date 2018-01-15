//
//  Item.swift
//  Oinnfi
//
//  Created by Bhavin on 21/12/17.
//  Copyright © 2017 Bhavin. All rights reserved.
//

import Foundation
import SwiftyJSON

public struct Item{
    
    public var name: String
    public var description: String
    public var descriptionShort: String
    public var catergoryName: String
    public var id: String
    public let features: JSON
    public let audio: JSON
    public var language: String?
    public var contentMaturity: String?
    public var length: String?
    public var narratorName: String
    public var coverImage: String
    
    public init?(fromJson: JSON){
        guard let name = fromJson["name"].string,
        let description = fromJson["description"].string,
        let descriptionShort = fromJson["description_short"].string,
        let categoryName = fromJson["category_default"].string,
        let narratorName = fromJson["narrator"].string,
        let coverImage = fromJson["cover_image"].string,
        let id = fromJson["id_product"].string else{
                return nil
        }
        self.name = name
        self.description = description
        self.descriptionShort = descriptionShort
        self.narratorName = narratorName
        self.id = id
        self.coverImage = coverImage
        self.catergoryName = categoryName
        self.features = fromJson["features"]
        self.audio = fromJson["audio"]
        
       /* for (_, subJson): (String, JSON) in fromJson["features"]{
            let name = subJson["name"]
            switch name{
            case "Language":
                self.language = subJson["value"].string!
            case "Content Maturity":
                self.contentMaturity = subJson["value"].string!
            case "Length":
                self.length = subJson["value"].string!
            default:
                print("")
            }
        }
        */
        
        self.language = nil
        self.contentMaturity = nil
        self.length = nil
        
    }
    
}
