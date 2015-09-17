//
//  DrawView.swift
//  TouchTracker
//
//  Created by James Roland on 9/17/15.
//  Copyright (c) 2015 LinkedIn. All rights reserved.
//

import UIKit

class DrawView: UIView {
    var currentLine: Line?
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
        if let line = currentLine {
            UIColor.redColor().setStroke()
            strokeLine(line)
        }
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        let touch = touches.first as! UITouch
        let location = touch.locationInView(self)
        
        currentLine = Line(begin: location, end: location)
        
        setNeedsDisplay() //Calls the drawRect method
    }
    
    override func touchesMoved(touches: Set<NSObject>, withEvent event: UIEvent) {
        let touch = touches.first as! UITouch
        let location = touch.locationInView(self)
        
        currentLine?.end = location
        
        setNeedsDisplay() //Calls the drawrect method.
    }

    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        if var line = currentLine {
            let touch = touches.first as! UITouch
            let location = touch.locationInView(self)
            line.end = location
            finishedLines.append(line)
        }
        currentLine = nil
        setNeedsDisplay()
    }
    
}
