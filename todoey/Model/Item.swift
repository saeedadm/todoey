//
//  Item.swift
//  todoey
//
//  Created by Saeed on 5/19/20.
//  Copyright © 2020 Saeed2346. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    @objc dynamic var title : String = ""
    @objc dynamic var done : Bool = false
    @objc dynamic var dateCreated : Date?
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
