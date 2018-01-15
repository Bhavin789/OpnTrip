//
//  Audio.swift
//  Oinnfi
//
//  Created by Bhavin on 21/12/17.
//  Copyright © 2017 Bhavin. All rights reserved.
//

import Foundation
import SwiftyJSON

public struct Audio{
    public var audioId: String
    public var audioProductId: String
    public var audioTitle: String
    public var audioFullPath: String
    public var audioCuttingPath: String
    
    init(id: String, proId: String, title: String, fullPath: String, cutPath: String) {
        self.audioId = id
        self.audioProductId = proId
        self.audioCuttingPath = cutPath
        self.audioFullPath = fullPath
        self.audioTitle = title
    }
    
}
