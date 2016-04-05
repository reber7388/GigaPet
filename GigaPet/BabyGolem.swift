//
//  BabyGolem.swift
//  GigaPet
//
//  Created by Reber on 3/24/16.
//  Copyright © 2016 Reber. All rights reserved.
//

import Foundation
import UIKit


class BabyGolem: UIImageView {
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        playIdleAnimation()
    }
    
    func playIdleAnimation() {
        
        self.image = UIImage(named: "bGolemIdle1.png") //this sets a default image
        
        self.animationImages = nil //clear any images that might be in there
        
        var imgArray = [UIImage]()
        for var x = 1; x <= 4; x = x + 1 {
            let img = UIImage(named: "bGolemIdle\(x).png")
            imgArray.append(img!)
        }
        
        self.animationImages = imgArray
        self.animationDuration = 0.8
        self.animationRepeatCount = 0 //having a zero here means it will repeat infinitely
        self.startAnimating()
        
    }
    
    func playDeathAnimation() {
        
        self.image = UIImage(named: "bGolemDead5.png") //this sets a default image
        
        self.animationImages = nil //clear any images that might be in there
        
        var imgArray = [UIImage]()
        for x in 1...5 {
            let img = UIImage(named: "bGolemDead\(x).png")
            imgArray.append(img!)
        }
        
        self.animationImages = imgArray
        self.animationDuration = 0.8
        self.animationRepeatCount = 1 //having a zero here means it will repeat infinitely
        self.startAnimating()
        
    }
    
    func playThrowRockAnimation() {
        
        self.image = UIImage(named: "bGolemAttack1.png") //this sets a default image
        
        self.animationImages = nil //clear any images that might be in there
        
        var imgArray = [UIImage]()
        for x in 1...7 {
            let img = UIImage(named: "bGolemAttack\(x).png")
            imgArray.append(img!)
        }
        
        self.animationImages = imgArray
        self.animationDuration = 0.8
        self.animationRepeatCount = 1 //having a zero here means it will repeat infinitely
        self.startAnimating()
        NSTimer.scheduledTimerWithTimeInterval(0.8, target: self, selector: "playIdleAnimation", userInfo: nil, repeats: false)
        
    }
    
    
    func playReviveAnimation() {
        
        self.image = UIImage(named: "bGolemIdle1.png") //this sets a default image
        
        self.animationImages = nil //clear any images that might be in there
        
        var imgArray = [UIImage]()
        for x in (1 ..< 5).reverse() {
            let img = UIImage(named: "bGolemDead\(x).png")
            imgArray.append(img!)
        }
        
        self.animationImages = imgArray
        self.animationDuration = 0.8
        self.animationRepeatCount = 1 //having a zero here means it will repeat infinitely
        self.startAnimating()
        NSTimer.scheduledTimerWithTimeInterval(0.8, target: self, selector: "playIdleAnimation", userInfo: nil, repeats: false)
        
    }
    
    
}