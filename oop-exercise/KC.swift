//
//  KC.swift
//  oop-exercise
//
//  Created by Kasey Schlaudt on 6/14/16.
//  Copyright © 2016 coprograming.com. All rights reserved.
//

import Foundation

class KC: Character {
    
    let imunity = 10
    
    private var _player2name = "KC"
    private var _p2Inventory = [String]()
    
    var player2name: String {
        get {
            return _player2name
        }
    }
    
    var p2Inventory: [String] {
        get {
            return _p2Inventory
        }
    }
    
    var p2Loot: [String] {
        return ["WheelChairs", "Cooks", "Women", "Loosing Abilities", "Glue", "Hops"]
    }
    
    var p2IsAlive: Bool {
        get {
            if hp <= 0 {
                return false
            } else {
                return true
            }
        }
    }

    convenience init(name: String, startingHp: Int, attackPwr: Int) {
        
        self.init(startingHp: startingHp, attackPwr: attackPwr)
        
        _player2name = player2name
    }
    
    func dropLoot() -> String? {
        if !p2IsAlive {
            let rand = Int(arc4random_uniform(UInt32(p2Loot.count)))
            return p2Loot[rand]
        }
        
        return nil
    }
    
    override func atemptAttack(attackPwr: Int) -> Bool {
        if attackPwr >= imunity {
            return super.atemptAttack(attackPwr)
        } else {
            return false
        }
    }

    
}