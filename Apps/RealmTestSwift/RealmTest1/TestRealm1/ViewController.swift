//
//  ViewController.swift
//  TestRealm1
//
//  Created by Rosario Conti on 31/05/16.
//  Copyright © 2016 Rosario Conti. All rights reserved.
//

import UIKit
import RealmSwift
import Realm

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        printTime(["start","cleaning the db"])
        cleanDB()
        printTime(["--cleaning done--","--start writing X objects--"])
        writeTest()
        printTime(["--finished writing--","--starting reading--"])
        readTest()
        printTime(["finished reading"])
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func printTime(strings:[String]) {
        let date = NSDate()
        let calendar = NSCalendar.currentCalendar()
        let hour = calendar.components(NSCalendarUnit.Hour , fromDate: date).hour
        let minute = calendar.components(NSCalendarUnit.Minute , fromDate: date).minute
        let sec = calendar.components(NSCalendarUnit.Second , fromDate: date).second
        for str in strings {
            print("time \(str): \(hour):\(minute):\(sec)")
        }
    }
    
    func cleanDB() {
        let realm = RLMRealm.defaultRealm()
            realm.beginWriteTransaction()
            realm.deleteAllObjects()
            try! realm.commitWriteTransaction()
    }
    
    func readTest() {
        let realm = try! Realm()
        let notes = realm.objects(Note)
        print("Notes count: \(notes.count)")
        for note in notes {
            print("bID AND text of note: \(note.bID) - \(note.text)")
        }
    }
    
    func writeTest() {
        //dispatch_async(dispatch_queue_create("background", nil)) {
        //}
        let realm = try! Realm()
        for i in 0 ..< 5000 {
                try! realm.write {
                    let note = Note()
                    note.bID = "Nota \(i)"
                    note.text = "Test Text one line"
                    realm.add(note)
                }
        }
    }
}

