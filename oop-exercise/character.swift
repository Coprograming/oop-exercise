//
//  character.swift
//  oop-exercise
//
//  Created by Kasey Schlaudt on 6/14/16.
//  Copyright © 2016 coprograming.com. All rights reserved.
//

import Foundation

class Character {
    
    private var _hp:Int = 100
    private var _attackPwr:Int = 10
    
    var hp: Int {
        get {
            return _hp
        }
    }
    
    var attackPwr: Int {
        get {
            return _attackPwr
        }
    }
    
        
    init(startingHp: Int, attackPwr: Int) {
        self._hp = startingHp
        self._attackPwr = attackPwr
    }
    
    func atemptAttack(attackPwr: Int) -> Bool {
        self._hp -= attackPwr
        return true
    }
}