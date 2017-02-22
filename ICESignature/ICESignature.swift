//
//  ICESignature.swift
//  ICESignature
//
//  Created by Jeriko on 2/22/17.
//  Copyright © 2017 Jeriko. All rights reserved.
//

import UIKit
import Foundation

public class ICESignature: UIView {
    
    private var lines: [Line]=[]
    private var lastPoint: CGPoint!
    
    private var previousPoint1: CGPoint!
    private var previousPoint2: CGPoint!
    private var currentPoint: CGPoint!
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    required public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let tempTouch = touches.first?.location(in: self) {
            lastPoint = tempTouch
            previousPoint1 = tempTouch
            previousPoint2 = tempTouch
        }
        self.setNeedsDisplay()
    }
    
    override public func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        var newPoint = CGPoint()
        if let tempTouch = touches.first?.location(in: self) {
            previousPoint2 = previousPoint1
            previousPoint1 = lastPoint
            currentPoint = tempTouch
            
            newPoint = tempTouch
        }
        
        lines.append(Line(start: lastPoint, end: newPoint, previousPoint1: previousPoint1, previousPoint2: previousPoint2, currentPoint: currentPoint))
        lastPoint = newPoint
        
        self.setNeedsDisplay()
    }
    
    override public func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        var previousWidth1: CGFloat = 1
        var previousWidth2 = CGFloat()
        var currentWidth = CGFloat()
        
        context?.beginPath()
        for line in lines {
            let mid1 = calculateMidPoint(point1: line.previousPoint1, point2: line.previousPoint2)
            let mid2 = calculateMidPoint(point1: line.currentPoint, point2: line.previousPoint1)
            
            context?.move(to: mid1)
            context?.addLine(to: line.previousPoint1)
            context?.addQuadCurve(to: line.currentPoint, control: mid2)
            
            context?.setLineCap(.round)
            context?.setBlendMode(.normal)
            
            let ySpeed = abs(line.end.y - line.start.y)
            let xSpeed = abs(line.end.x - line.start.x)
            
            currentWidth = 2.5 / min(ySpeed, xSpeed)
            
            if (currentWidth - previousWidth1) > (previousWidth1 - previousWidth2) {
                currentWidth = previousWidth1 * 1.2
            }
            
            if (currentWidth > 2.5) {
                currentWidth = 2.5
            }
            
            if (currentWidth < 0.15) {
                currentWidth = 0.15
            }
            
            context?.setLineWidth(currentWidth)
            context?.setStrokeColor(cyan: 1, magenta: 1, yellow: 1, black: 1, alpha: 1)
            context?.strokePath()
            
            previousWidth2 = previousWidth1
            previousWidth1 = currentWidth
        }
    }
    
    func calculateMidPoint(point1: CGPoint, point2: CGPoint) -> CGPoint {
        return CGPoint(x: (point1.x + point2.x) * 0.5, y: (point1.y + point2.y) * 0.5)
    }
    
    public func clearLines(){
        lines.removeAll()
        self.setNeedsDisplay()
    }
}
