//
//  Brooks.swift
//  oop-exercise
//
//  Created by Kasey Schlaudt on 6/14/16.
//  Copyright © 2016 coprograming.com. All rights reserved.
//

import Foundation

class Brooks: Character {
    
    let weakness = 0
    
    private var _player1Name = "Brooks"
    private var _p1Inventory = [String]()
    
    var player1Name: String {
        get {
            return _player1Name
        }
    }
    
    var p1Inventory: [String] {
        get {
            return _p1Inventory
        }
    }
    
    var p1Loot: [String] {
        return ["Lunch money", "Cookies", "Man Cards", "Dignity", "Virginity", "Hope"]
    }

    var p1IsAlive: Bool {
        get {
            if hp <= 0 {
                return false
            } else {
                return true
            }
        }
    }
    
    convenience init(name: String, startingHp: Int, attackPwr: Int){
        self.init(startingHp: startingHp, attackPwr: attackPwr)
        
        _player1Name = player1Name
    }
    
    func dropLoot() -> String? {
        if !p1IsAlive {
            let rand = Int(arc4random_uniform(UInt32(p1Loot.count)))
            return p1Loot[rand]
        }
        
        return nil
    }
}