//
//  ViewController.swift
//  oop-exercise
//
//  Created by Kasey Schlaudt on 6/14/16.
//  Copyright © 2016 coprograming.com. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var playerImgP2: UIImageView!
    @IBOutlet weak var enemyImgP2: UIImageView!
    @IBOutlet weak var p2EnemySelector: UIButton!
    @IBOutlet weak var p2PlayerSelector: UIButton!
    @IBOutlet weak var p2OrSelector: UITextField!
    @IBOutlet weak var p2AttackBtn: UIButton!
    
    @IBOutlet weak var enemyImgP1: UIImageView!
    @IBOutlet weak var playerImgP1: UIImageView!
    @IBOutlet weak var p1enemyselector: UIButton!
    @IBOutlet weak var p1PlayerSelector: UIButton!
    @IBOutlet weak var p1OrSelector: UITextField!
    @IBOutlet weak var p1AttackBtn: UIButton!
    
    @IBOutlet weak var printLbl: UITextField!
    @IBOutlet weak var tapToRestart: UIButton!
    
    var player1: Brooks!
    var player2: KC!
    
    
    var backGroundSound: AVAudioPlayer!
    var swordEffect: AVAudioPlayer!
    var punchEffect: AVAudioPlayer!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        notReadyForPlay()
        
        player1 = Brooks(name: "brooks", startingHp: 100, attackPwr: 10)
        player2 = KC(name: "kc", startingHp: 100, attackPwr: 10)
        
        
        let soundFilePath = NSBundle.mainBundle().pathForResource("Vexento - Pixel Party", ofType: "mp3")
        let soundFileURL = NSURL(fileURLWithPath: soundFilePath!)
        do {
            
            try backGroundSound = AVAudioPlayer(contentsOfURL: soundFileURL, fileTypeHint: nil)
        } catch
            let error as NSError {
                
                print(error.debugDescription)
        }
        
        backGroundSound.numberOfLoops = -1 //Infinite times
        backGroundSound.volume = 0.3 //less volume
        backGroundSound.play()
        
        
        let soundPath = NSBundle.mainBundle().pathForResource("Sword1", ofType: "wav")
        let soundUrl = NSURL(fileURLWithPath: soundPath!)
        do {
            
            try swordEffect = AVAudioPlayer(contentsOfURL: soundUrl, fileTypeHint: nil)
            swordEffect.prepareToPlay()
            
        } catch let error as NSError {
            
            print(error.debugDescription)
            
        }
        
        swordEffect.volume = 5
        
        let soundPunch = NSBundle.mainBundle().pathForResource("punch2", ofType: "wav")
        let punchUrl = NSURL(fileURLWithPath: soundPunch!)
        
        do {
            
            try punchEffect = AVAudioPlayer(contentsOfURL: punchUrl, fileTypeHint: nil)
            punchEffect.prepareToPlay()
        } catch let error as NSError {
            
            print(error.debugDescription)
        }
        
    }
    
       @IBAction func onAttackP2Pressed(sender: AnyObject) {
        p2Attack()
        
        if player1.atemptAttack(player2.attackPwr){
            printLbl.text = ""
            printLbl.text = "\(player1.player1Name) Lost \(player1.hp) HP"
        }else {
            printLbl.text = "Attack was Unsuccessful"
        }
            if !player1.isAlive {
                if let p2Loot = player1.dropLoot(){
                    printLbl.text = "\(player1.player1Name) Lost His \(p2Loot)"
                    justDied()
                }
            }
        self.p1AttackBtn.enabled = false
        NSTimer.scheduledTimerWithTimeInterval(3, target: self, selector: #selector(ViewController.enabledButton), userInfo: nil, repeats: false)
        }
    
    @IBAction func onAttackP1Pressed(sender: AnyObject) {
        p1Attack()
        
        if player2.atemptAttack(player1.attackPwr) {
            printLbl.text = "\(player2.player2name) Lost \(player2.hp) HP"
        } else {
            printLbl.text = "Attack was Unsuccessful"
        }
        if !player2.isAlive {
            if let p1Loot = player2.dropLoot(){
                printLbl.text = "\(player2.player2name) Lost His \(p1Loot)"
                justDied()
            }
        }
        self.p2AttackBtn.enabled = false
        NSTimer.scheduledTimerWithTimeInterval(3, target: self, selector: #selector(ViewController.enableButton), userInfo: nil, repeats: false)
        
    }
    
    func p2Attack() {
        if swordEffect.playing {
            swordEffect.stop()
        }
        swordEffect.currentTime = 0.1
        swordEffect.play()
    }
    
    func p1Attack() {
        if punchEffect.playing {
            punchEffect.stop()
        }
        punchEffect.currentTime = 0
        punchEffect.play()
    }
    
    @IBAction func onP1EnemySelectorPressed(sender: AnyObject) {
        p1enemyselector.hidden = true
        p1PlayerSelector.hidden = true
        p1OrSelector.hidden = true
        playerImgP1.hidden = true
        enemyImgP1.hidden = false
        p1AttackBtn.hidden = false
        notReadyForPlay()
    }
    
    @IBAction func onP1PlayerSelectorPressed(sender: AnyObject) {
        p1enemyselector.hidden = true
        p1PlayerSelector.hidden = true
        p1OrSelector.hidden = true
        playerImgP1.hidden = false
        enemyImgP1.hidden = true
        p1AttackBtn.hidden = false
        notReadyForPlay()
    }
    
    @IBAction func onP2EnemySelectorPressed(sender: AnyObject) {
        p2EnemySelector.hidden = true
        p2PlayerSelector.hidden = true
        p2OrSelector.hidden = true
        playerImgP2.hidden = true
        enemyImgP2.hidden = false
        p2AttackBtn.hidden = false
        notReadyForPlay()
    }
    
    @IBAction func onP2PlayerSelectorPressed(sender: AnyObject) {
        p2EnemySelector.hidden = true
        p2PlayerSelector.hidden = true
        p2OrSelector.hidden = true
        playerImgP2.hidden = false
        enemyImgP2.hidden = true
        p2AttackBtn.hidden = false
        notReadyForPlay()
    }
    
    func letsRestart() {
        tapToRestart.hidden = false
        p1AttackBtn.hidden = true
        p2AttackBtn.hidden = true
        enemyImgP2.hidden = true
        enemyImgP1.hidden = true
        playerImgP2.hidden = true
        playerImgP1.hidden = true
        viewDidLoad()
    }
    
    func enableButton() {
        self.p2AttackBtn.enabled = true
    }
    
    func enabledButton() {
        self.p1AttackBtn.enabled = true
    }
    
    @IBAction func restartBtnPressed(sender: AnyObject) {
        p2EnemySelector.hidden = false
        p2PlayerSelector.hidden = false
        p2OrSelector.hidden = false
        playerImgP2.hidden = true
        enemyImgP2.hidden = true
        p2AttackBtn.hidden = true
        p1enemyselector.hidden = false
        p1PlayerSelector.hidden = false
        p1OrSelector.hidden = false
        playerImgP1.hidden = true
        enemyImgP1.hidden = true
        p1AttackBtn.hidden = true
        tapToRestart.hidden = true
    }
    
    func justDied() {
        if !player1.isAlive {
            letsRestart()
        }else if !player2.isAlive {
            letsRestart()
        }
    }
    
    func notReadyForPlay() {
        if p2AttackBtn.hidden || p1AttackBtn.hidden {
            p1AttackBtn.enabled = false
            p2AttackBtn.enabled = false
        } else if p2OrSelector.hidden && p1OrSelector.hidden {
            p1AttackBtn.enabled = true
            p2AttackBtn.enabled = true
        }
    }
}
    
