//
//  Note.swift
//  TestRealm1
//
//  Created by Rosario Conti on 31/05/16.
//  Copyright © 2016 Rosario Conti. All rights reserved.
//

import Foundation
import RealmSwift

class Note: Object {
    dynamic var _id = ""
    dynamic var location = 0
    dynamic var text = ""
    dynamic var _p_user = ""
    dynamic var bID = ""
    dynamic var _created_at = NSDate()
    dynamic var _updated_at = NSDate()
}
