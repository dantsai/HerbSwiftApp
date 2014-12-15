//
//  Herb.swift
//  EmojiTabbed
//
//  Created by Micah on 12/14/14.
//  Copyright (c) 2014 Micah. All rights reserved.
//

import Foundation

struct Herb {
    var lat: Double
    var long: Double
    var description: String?
    var type: String
    
    init(newlat: Double, newlong: Double, newdescription: String, newtype: String) {
        lat = newlat
        long = newlong
        description = newdescription
        type = newtype
    }
}