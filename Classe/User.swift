//
//  User.swift
//  Classe
//
//  Created by Jason Bourne on 18/10/18.
//  Copyright © 2018 Gianluca Littamè. All rights reserved.
//


import UIKit
import RealmSwift

@objcMembers class User: Object {
    
    dynamic var name : String!
    dynamic var surname : String!
    dynamic var mail : String!
    dynamic var password : String!
    dynamic var image : Data?
    dynamic var mobile : String?
    dynamic var address : String?
    private let mates : List<Mate> = List<Mate>()
    
    dynamic var id : String!
    
    override static func primaryKey() -> String? {
        return "id"
    }
    convenience init (name : String!, surname : String!, mail : String!, password : String!, image : Data? = nil, mobile : String? = nil, address : String? = nil) {
        
        self.init()
        
        self.name = name
        self.surname = surname
        self.mail = mail
        self.password = password
        self.id = mail
        self.image = image
        self.mobile = mobile
        self.address = address
        
    }
    
    
    func add(in realm: Realm = try! Realm(configuration: RealmUtils.config)) {
        do {
            try realm.write {
                realm.add(self)
            }
        } catch {}
    }
    
    static func all(in realm: Realm = try! Realm(configuration: RealmUtils.config)) -> [User] {
        return Array(realm.objects(User.self))
    }
    
    func remove(in realm: Realm = try! Realm(configuration: RealmUtils.config)) {
        do {
            try realm.write {
                realm.delete(self)
            }
        } catch {}
    }
    func getMates() -> [Mate] {
        return Array(mates)
    }
    
    func addingMate(in realm: Realm = try! Realm(configuration: RealmUtils.config), mate : Mate) {
        do {
            try realm.write {
                mates.insert(mate, at: mates.count)
            }
        }catch {}
    }
    
    func removeMate(in realm: Realm = try! Realm(configuration: RealmUtils.config), index: Int) {
        do {
            try realm.write {
                self.mates.remove(at: index)
            }
        }catch {}
    }
    func modifyMate(in realm: Realm = try! Realm(configuration: RealmUtils.config), index: Int,image: Data? = nil, rating : Int? = nil, position : Int? = nil, mate: Mate? = nil) {
            self.mates[index].changeData(image: image, rating: rating, position: position)

    }
}
