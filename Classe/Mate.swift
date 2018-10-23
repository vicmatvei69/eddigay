//
//  Mate.swift
//  Classe
//
//  Created by Jason Bourne on 18/10/18.
//  Copyright © 2018 Gianluca Littamè. All rights reserved.
//


import UIKit
import RealmSwift

@objcMembers class Mate: Object {
    
    dynamic var name : String!
    dynamic var surname : String!
    dynamic var image : Data?
    dynamic var position = -1
    dynamic var rating = 0
    //let position = RealmOptional<Int>()
    //let rating = RealmOptional<Int>()
    dynamic var id : String!
    
    override static func primaryKey() -> String? {
        return "id"
    }
    convenience init (name : String!, surname : String!, rating : Int? = nil, position : Int? = nil,image : Data? = nil) {
        
        self.init()
        self.name = name
        self.surname = surname
        self.id = name+surname
        self.image = image
        self.rating = rating ?? 0
        self.position = position ?? -1
        
    }
    func fullName() -> String {
        var fullName = ""
        
        fullName += (self.name != nil) ? self.name! + " " : ""
        fullName += self.surname ?? ""
        
        return fullName
    }
    
    func add(in realm: Realm = try! Realm(configuration: RealmUtils.config)) {
        do {
            try realm.write {
                realm.add(self)
            }
        } catch {}
    }
    
    static func all(in realm: Realm = try! Realm(configuration: RealmUtils.config)) -> [Mate] {
        return Array(realm.objects(Mate.self))
    }
    
    func remove(in realm: Realm = try! Realm(configuration: RealmUtils.config)) {
        do {
            try realm.write {
                realm.delete(self)
            }
        } catch {}
    }
    
    func changeData(in realm: Realm = try! Realm(configuration: RealmUtils.config),image: Data? = nil, rating : Int? = nil, position : Int? = nil, mate: Mate? = nil) {
        do {
            try realm.write {
                self.image = image ?? mate?.image ?? self.image
                self.rating = rating ?? mate?.rating ?? self.rating
                self.position = position ?? mate?.position ?? self.position
                
            }
        }catch {}
        
    }
}
