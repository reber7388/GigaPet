//
//  MonsterImg.swift
//  GigaPet
//
//  Created by Reber on 3/17/16.
//  Copyright © 2016 Reber. All rights reserved.
//

import Foundation
import UIKit

class MonsterImg: UIImageView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        playIdleAnimation() //start the idle animations
    }
    
    func playIdleAnimation() {
        
        self.image = UIImage(named: "idel1.png") //this sets a default image
        
        self.animationImages = nil
        
        var imgArray = [UIImage]()
        for var x = 1; x <= 4; x += 1 {
            let img = UIImage(named: "idle\(x).png")
            imgArray.append(img!)
        }
        
        self.animationImages = imgArray
        self.animationDuration = 0.8
        self.animationRepeatCount = 0 //having a zero here means it will repeat infinitely
        self.startAnimating()
    }
    
    func playDeathAnimation() {
        
        self.image = UIImage(named: "dead5.png")
        
        self.animationImages = nil //empty the animation images out
        
        var imgArray = [UIImage]()
        for var x = 1; x <= 5; x += 1 {
            let img = UIImage(named: "dead\(x).png")
            imgArray.append(img!)
        }
        
        self.animationImages = imgArray
        self.animationDuration = 0.8
        self.animationRepeatCount = 1 //having a zero here means it will repeat infinitely
        self.startAnimating()
    }
    
    func playReviveAnimation() {
        
        self.image = UIImage(named: "idle1.png")
        
        self.animationImages = nil //empty the animation images out
        
        var imgArray = [UIImage]()
        for var x = 5; x >= 1; x -= 1 {
            let img = UIImage(named: "dead\(x).png")
            imgArray.append(img!)
        }
        
        self.animationImages = imgArray
        self.animationDuration = 0.8
        self.animationRepeatCount = 1 //having a zero here means it will repeat infinitely
        self.startAnimating()
        NSTimer.scheduledTimerWithTimeInterval(0.8, target: self, selector: "playIdleAnimation", userInfo: nil, repeats: false)
    }
    
}