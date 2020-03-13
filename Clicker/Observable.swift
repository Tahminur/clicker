//
//  Observable.swift
//  Clicker
//
//  Created by Tahminur Rahman on 3/13/20.
//  Copyright © 2020 Tahminur Rahman. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

final class Observable:ObservableObject{
    @Published var Money = 200
    //@Published var AnimalsBought = 0
    @Published var AnimalsInShop:[Animal] = [
        Animal(uid:1, name: "Chicken", picture: "🐔", cost: 10, incrementVal: 1),
        Animal(uid:2, name: "Duck", picture: "🦆", cost: 20, incrementVal: 2),
        Animal(uid:3, name: "Cow", picture: "🐮", cost: 40, incrementVal: 4)
    ]
    @Published var AnimalsBought:[Animal] = []
}

struct Animal: Hashable{
    var uid:Int
    var name:String
    var picture:String// I will keep this picture as an emoji for now and then have it so that multiple animals bought will make it so that more emoji's appear randomly within the box it is assigned too
    var cost:Int
    var incrementVal:Int
    var Number = 1
}
