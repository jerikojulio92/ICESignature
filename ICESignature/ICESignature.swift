//
//  ICESignature.swift
//  ICESignature
//
//  Created by Jeriko on 2/22/17.
//  Copyright © 2017 Jeriko. All rights reserved.
//

import UIKit

public class ICESignature: UIView {
    
    public var lineColor = CMYKColor()
    
    private var widthDifferenceMultiplier: CGFloat = 1.07
    private var maximumWidth: CGFloat = 2.5
    private var minimumWidth: CGFloat = 0.25
    private var controlConstant:CGFloat = 2.5
    private var isEditing = true
    
    private var lines: [Line]=[]
    private var lastPoint: CGPoint!
    private var previousPoint1: CGPoint!
    private var previousPoint2: CGPoint!
    private var currentPoint: CGPoint!
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.backgroundColor = UIColor.clear
    }
    
    required public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if isEditing {
            if let tempTouch = touches.first?.location(in: self) {
                lastPoint = tempTouch
                previousPoint1 = tempTouch
                previousPoint2 = tempTouch
            }
            self.setNeedsDisplay()
        }
    }
    
    override public func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if isEditing {
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
            
            let ySpeed = calculateSpeed(endPoint: line.end.y , startPoint: line.start.y)
            let xSpeed = calculateSpeed(endPoint: line.end.x , startPoint: line.start.x)
            
            currentWidth = controlConstant / min(ySpeed, xSpeed)
            
            if (currentWidth - previousWidth1) > (previousWidth1 - previousWidth2) {
                currentWidth = previousWidth1 * widthDifferenceMultiplier
            }
            
            if (currentWidth > maximumWidth) {
                currentWidth = maximumWidth
            }
            
            if (currentWidth < minimumWidth) {
                currentWidth = minimumWidth
            }
            
            context?.setLineWidth(currentWidth)
            context?.setStrokeColor(cyan: lineColor.cyan, magenta: lineColor.magenta, yellow: lineColor.yellow, black: lineColor.black, alpha: lineColor.alpha)
            context?.strokePath()
            
            previousWidth2 = previousWidth1
            previousWidth1 = currentWidth
        }
    }
    
    private func calculateSpeed(endPoint: CGFloat, startPoint: CGFloat) -> CGFloat {
        return abs(endPoint - startPoint)
        
    }
    
    private func calculateMidPoint(point1: CGPoint, point2: CGPoint) -> CGPoint {
        return CGPoint(x: (point1.x + point2.x) * 0.5, y: (point1.y + point2.y) * 0.5)
    }
    
    public func clearLines(){
        lines.removeAll()
        self.setNeedsDisplay()
    }
    
    public func beginEditingSignature(){
        isEditing = true
    }
    
    public func stopEditingSignature(){
        isEditing = false
    }
    
    public func setMinimumWidth(width: CGFloat){
        var newWidth = CGFloat()
        if (width < 0 ) {newWidth = .leastNonzeroMagnitude}
        minimumWidth = newWidth
    }
    
    public func setMaximumWidth(width: CGFloat){
        var newWidth = CGFloat()
        if (width < 0 ) {newWidth = .leastNonzeroMagnitude}
        maximumWidth = newWidth
    }
    
    public func setControlConstant(constant: CGFloat){
        var newConstant = CGFloat()
        if (constant < 0 ) {newConstant = .leastNonzeroMagnitude}
        controlConstant = newConstant
    }
    
    public func setWidthDifferenceMultiplier(multiplier: CGFloat){
        var newMultiplier = CGFloat()
        if (multiplier < 0 ) {newMultiplier = .leastNonzeroMagnitude}
        widthDifferenceMultiplier = newMultiplier
    }
}
