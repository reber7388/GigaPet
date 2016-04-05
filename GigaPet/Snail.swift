//
//  Snail.swift
//  GigaPet
//
//  Created by Reber on 4/5/16.
//  Copyright © 2016 Reber. All rights reserved.
//

import Foundation
import UIKit


class Snail: UIImageView {
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        playIdleAnimation()
    }
    
    func playIdleAnimation() {
        
        self.image = UIImage(named: "blue_idle1.png") //this sets a default image
        
        self.animationImages = nil //clear any images that might be in there
        
        var imgArray = [UIImage]()
        for var x = 1; x <= 4; x = x + 1 {
            let img = UIImage(named: "blue_idle\(x).png")
            imgArray.append(img!)
        }
        
        self.animationImages = imgArray
        self.animationDuration = 0.8
        self.animationRepeatCount = 0 //having a zero here means it will repeat infinitely
        self.startAnimating()
        
    }
    
    func playDeathAnimation() {
        
        self.image = UIImage(named: "blue_dead3.png") //this sets a default image
        
        self.animationImages = nil //clear any images that might be in there
        
        var imgArray = [UIImage]()
        for x in 1...3 {
            let img = UIImage(named: "blue_dead\(x).png")
            imgArray.append(img!)
        }
        
        self.animationImages = imgArray
        self.animationDuration = 0.8
        self.animationRepeatCount = 1 //having a zero here means it will repeat infinitely
        self.startAnimating()
        
    }
    
    
    func playReviveAnimation() {
        
        self.image = UIImage(named: "blue_dead1.png") //this sets a default image
        
        self.animationImages = nil //clear any images that might be in there
        
        var imgArray = [UIImage]()
        for x in (1 ..< 3).reverse() {
            let img = UIImage(named: "blue_dead\(x).png")
            imgArray.append(img!)
        }
        
        self.animationImages = imgArray
        self.animationDuration = 0.8
        self.animationRepeatCount = 1 //having a zero here means it will repeat infinitely
        self.startAnimating()
        NSTimer.scheduledTimerWithTimeInterval(0.8, target: self, selector: "playIdleAnimation", userInfo: nil, repeats: false)
        
    }
    
    
}