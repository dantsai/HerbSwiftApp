//
//  Herbs.swift
//  EmojiTabbed
//
//  Created by Micah on 12/14/14.
//  Copyright (c) 2014 Micah. All rights reserved.
//

import Foundation

class Herbs {
    var herbList:[Herb] = []
    var toAdd:[Herb] = []
    init() {
        // prepopulate with some defaults
        herbList.append(Herb(newlat: 37.8660347, newlong: -122.2591022, newdescription: "", newtype: "Fennel"))
        herbList.append(Herb(newlat: 37.86596057, newlong: -122.2577494, newdescription: "", newtype: "Rosemary"))
        herbList.append(Herb(newlat: 37.86594928, newlong: -122.2578174, newdescription: "", newtype: "Fennel"))
        herbList.append(Herb(newlat: 37.86589634, newlong: -122.2582465, newdescription: "", newtype: "Mint"))
        herbList.append(Herb(newlat: 37.86540509, newlong: -122.2577772, newdescription: "", newtype: "Rosemary"))
        herbList.append(Herb(newlat: 37.87216766, newlong: -122.2748454, newdescription: "", newtype: "Rosemary"))
        herbList.append(Herb(newlat: 37.87114183, newlong: -122.3003089, newdescription: "", newtype: "Sage"))
        herbList.append(Herb(newlat: 37.87111219, newlong: -122.3002231, newdescription: "", newtype: "Sage"))
        herbList.append(Herb(newlat: 37.8634958, newlong: -122.2577503, newdescription: "", newtype: "Thyme"))
        herbList.append(Herb(newlat: 37.86418188, newlong: -122.2564709, newdescription: "", newtype: "Sage"))
    }
}

var herbs = Herbs()

