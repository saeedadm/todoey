//
//  Category.swift
//  todoey
//
//  Created by Saeed on 5/19/20.
//  Copyright © 2020 Saeed2346. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name : String = ""
    let items = List<Item>()
    
}
