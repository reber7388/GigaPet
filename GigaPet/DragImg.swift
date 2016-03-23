//
//  DragImg.swift
//  GigaPet
//
//  Created by Reber on 3/17/16.
//  Copyright © 2016 Reber. All rights reserved.
//

import Foundation
import UIKit

class DragImg: UIImageView {
    
    var originalPosition:CGPoint! //CGPoint has an x and a y
    var dropTarget: UIView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        originalPosition = self.center //this will get the center point of where the image (food, heart etc) was before dragging it
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let touch = touches.first {
            let position = touch.locationInView(self.superview) //this is telling us where the user touched on the screen or superview where everything is displayed
            self.center = CGPointMake(position.x, position.y) //this is moving the center point of the food/heart img to where the user has their finger
        }
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        if let touch = touches.first, let target = dropTarget { //if there is a touch AND there is a target
            
            let postition = touch.locationInView(self.superview) //this is the one from Marks vid
            //let postition = touch.locationInView(self.superview?.superview)
            
            if CGRectContainsPoint(target.frame, postition) { // if the postion is anywhere on the monsters UIImageView frame, you dropped it on the monster
                NSNotificationCenter.defaultCenter().postNotification(NSNotification(name: "onTargetDropped", object: nil)) //
                
            }
        }
        
        self.center = originalPosition
    }
    

    
}

