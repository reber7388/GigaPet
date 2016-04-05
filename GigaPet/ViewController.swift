//
//  ViewController.swift
//  GigaPet
//
//  Created by Reber on 3/16/16.
//  Copyright © 2016 Reber. All rights reserved.
//

import UIKit
import AVFoundation //import for sound FX

class ViewController: UIViewController {

    @IBOutlet weak var monsterImg: MonsterImg!
    @IBOutlet weak var foodImg: DragImg!
    @IBOutlet weak var heartImg: DragImg!
    @IBOutlet weak var waterDropImg: DragImg!
    @IBOutlet weak var penalty1Img: UIImageView!
    @IBOutlet weak var penalty2Img: UIImageView!
    @IBOutlet weak var penalty3Img: UIImageView!
    @IBOutlet weak var restartBtn: UIButton!
    
    let DIM_ALPHA: CGFloat = 0.2 //in graphics 1.0 is full/opaque anything lower is not opaque
    let OPAUQE: CGFloat = 1.0
    let MAX_PENALTIES = 3
    
    var penalties = 0
    var timer: NSTimer! //we are definietly going to have a timer therefore we can unwrap it here (exclimation point)
    var monsterHappy = true
    var currentItm: UInt32 = 0
    
    var musicPlayer: AVAudioPlayer!
    var sfxBite: AVAudioPlayer!
    var sfxHeart: AVAudioPlayer!
    var sfxDeath: AVAudioPlayer!
    var sfxSkull: AVAudioPlayer!
    var sfxWaterDrop: AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        foodImg.dropTarget = monsterImg
        heartImg.dropTarget = monsterImg
        waterDropImg.dropTarget = monsterImg
        
        penalty1Img.alpha = DIM_ALPHA
        penalty2Img.alpha = DIM_ALPHA
        penalty3Img.alpha = DIM_ALPHA
        
        //the colon after "itemDroppedOnCharacter" means there is one or more parameters you NEED this colon or it wont work
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "itemDroppedOnCharacter:", name: "onTargetDropped", object: nil)
        
        do {
            try musicPlayer = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("cave-music", ofType: "mp3")!))
            
            try sfxBite = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("bite", ofType: "wav")!))
            
            try sfxHeart = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("heart", ofType: "wav")!))
            
            try sfxDeath = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("death", ofType: "wav")!))
            
            try sfxSkull = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("skull", ofType: "wav")!))
            
            try sfxWaterDrop = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("heart", ofType: "wav")!))
            
            musicPlayer.prepareToPlay()
            musicPlayer.play() //start the backgorund music
            
            sfxBite.prepareToPlay()
            sfxHeart.prepareToPlay()
            sfxDeath.prepareToPlay()
            sfxSkull.prepareToPlay()
            sfxWaterDrop.prepareToPlay()
            
            
            
        } catch let err as NSError {
            print(err.debugDescription)
        }
        changeGameState()
        startTimer()
        
    }
    
    func itemDroppedOnCharacter(notif: AnyObject) {
        monsterHappy = true
        startTimer()
        
        foodImg.alpha = DIM_ALPHA
        foodImg.userInteractionEnabled = false
        heartImg.alpha = DIM_ALPHA
        heartImg.userInteractionEnabled = false
        waterDropImg.alpha = DIM_ALPHA
        waterDropImg.userInteractionEnabled = false
        
        if currentItm == 0 {
            sfxHeart.play()
        } else if currentItm == 1 {
            sfxBite.play()
        } else {
            sfxWaterDrop.play()
        }
    }
    
    func startTimer() {
        if timer != nil {
            timer.invalidate() // if there is another timer running, this will stop that timer
        }
        
        timer = NSTimer.scheduledTimerWithTimeInterval(3.0, target: self, selector: "changeGameState", userInfo: nil, repeats: true)
        
    }
    
    func changeGameState() {
        
        
        if !monsterHappy {
            
            penalties += 1
            
            sfxSkull.play()
            
            if penalties == 1 {
                penalty1Img.alpha = OPAUQE
                penalty2Img.alpha = DIM_ALPHA
            }else if penalties == 2 {
                penalty2Img.alpha = OPAUQE
                penalty3Img.alpha = DIM_ALPHA
            }else if penalties >= 3 {
                penalty3Img.alpha = OPAUQE
            }else {
                penalty1Img.alpha = DIM_ALPHA
                penalty2Img.alpha = DIM_ALPHA
                penalty3Img.alpha = DIM_ALPHA
            }
            
            if penalties >= MAX_PENALTIES {
                gameOver() //we died
                restartBtn.hidden = false
            }
            
        }
        
        //randomly generate what the pet wants
        let rand = arc4random_uniform(3)//give a random number between 3 numbers which will be 0 or 1 or 2
        
        if rand == 0 { //if 0 pet wants a heart
            heartImg.alpha = OPAUQE
            heartImg.userInteractionEnabled = true
            
            foodImg.alpha = DIM_ALPHA
            foodImg.userInteractionEnabled = false
            
            waterDropImg.alpha = DIM_ALPHA
            waterDropImg.userInteractionEnabled = false
        } else if rand == 1 {
            heartImg.alpha = DIM_ALPHA
            heartImg.userInteractionEnabled = false
            
            foodImg.alpha = OPAUQE
            foodImg.userInteractionEnabled = true
            
            waterDropImg.alpha = DIM_ALPHA
            waterDropImg.userInteractionEnabled = false
        } else {
            heartImg.alpha = DIM_ALPHA
            heartImg.userInteractionEnabled = false
            
            foodImg.alpha = DIM_ALPHA
            foodImg.userInteractionEnabled = false
            
            waterDropImg.alpha = OPAUQE
            waterDropImg.userInteractionEnabled = true
        }
        
        currentItm = rand
        monsterHappy = false
        
    }
    
    func gameOver() {
        timer.invalidate() //stop the tiem we died
        monsterImg.playDeathAnimation()
        sfxDeath.play()
    }
    
    
    @IBAction func onRestartBtnPressed(sender: AnyObject) {
        
        monsterHappy = true
        restartBtn.hidden = true
        monsterImg.playReviveAnimation()
        penalties = 0
        viewDidLoad()
    }
    

}

