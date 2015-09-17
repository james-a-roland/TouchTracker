//
//  DrawView.swift
//  TouchTracker
//
//  Created by James Roland on 9/17/15.
//  Copyright (c) 2015 LinkedIn. All rights reserved.
//

import UIKit

class DrawView: UIView {
    
    //We must wrap Touch objects, as they are not allowed to be retained
    var currentLines = [NSValue:Line]()
    var finishedLines = [Line]()
    
    func strokeLine(line: Line) {
        let path = UIBezierPath()
        path.lineWidth = 10
        path.lineCapStyle = kCGLineCapRound
        
        path.moveToPoint(line.begin)
        path.addLineToPoint(line.end)
        path.stroke()
    }
    
    override func drawRect(rect: CGRect) {
        UIColor.blackColor().setStroke()
        for line in finishedLines {
            strokeLine(line)
        }
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        println(__FUNCTION__)
        
        for touch in touches as! Set<UITouch> {
            let location = touch.locationInView(self)
            let newLine = Line(begin:location, end:location)
            let key = NSValue(nonretainedObject: touch)
            currentLines[key] = newLine
        }
        setNeedsDisplay() //Calls the drawRect method
    }
    
    override func touchesMoved(touches: Set<NSObject>, withEvent event: UIEvent) {
        println(__FUNCTION__)
        
        for touch in touches as! Set<UITouch> {
            let key = NSValue(nonretainedObject: touch)
            currentLines[key]?.end = touch.locationInView(self)
        }
        setNeedsDisplay() //Calls the drawrect method.
    }

    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        println(__FUNCTION__)
        
        for touch in touches as! Set<UITouch> {
            let key = NSValue(nonretainedObject: touch)
            if var line = currentLines[key] {
                let location = touch.locationInView(self)
                line.end = location
                finishedLines.append(line)
            }
        }
        setNeedsDisplay()
    }
    
    override func touchesCancelled(touches: Set<NSObject>!, withEvent event: UIEvent!) {
        println(__FUNCTION__)
        
        for touch in touches! as! Set<UITouch> {
            let key = NSValue(nonretainedObject: touch)
            currentLines.removeValueForKey(key)
        }
        setNeedsDisplay()
    }
    
}
