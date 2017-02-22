//
//  ICESignature.swift
//  ICESignature
//
//  Created by Jeriko on 2/22/17.
//  Copyright © 2017 Jeriko. All rights reserved.
//

import UIKit

public class ICESignature: UIView {
    
    private var lines: [Line]=[]
    private var lastPoint: CGPoint!
    private var oldTimeStamp: Int64!
    private var deltaTime: Int64!
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    required public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let tempTouch = touches.first?.location(in: self) {
            lastPoint = tempTouch
        }
        
        let date = NSDate()
        oldTimeStamp = Int64(floor(date.timeIntervalSince1970 * 1000))
        
        self.setNeedsDisplay()
    }
    
    override public func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        var newPoint = CGPoint()
        if let tempTouch = touches.first?.location(in: self) {
            newPoint = tempTouch
        }
        
        let date = NSDate()
        let newTimeStamp = Int64(floor(date.timeIntervalSince1970 * 1000))
        
        deltaTime = newTimeStamp - oldTimeStamp
        
        lines.append(Line(start: lastPoint, end: newPoint))
        lastPoint = newPoint
        oldTimeStamp = newTimeStamp
        self.setNeedsDisplay()
    }
    
    override public func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        context?.beginPath()
        for line in lines {
            context?.move(to: CGPoint(x: line.start.x, y: line.start.y))
            context?.addLine(to: CGPoint(x: line.end.x, y: line.end.y))
        }
        
        context?.setLineWidth(3)
        context?.setStrokeColor(cyan: 1, magenta: 1, yellow: 1, black: 1, alpha: 1)
        context?.strokePath()
    }
    
    public func clearLines(){
        lines.removeAll()
        self.setNeedsDisplay()
    }
    
    func calculateLineWidth()-> CGFloat {
        if deltaTime >= 100 {
        deltaTime = 100
        }
        let width = deltaTime / 100 * 5
        return CGFloat(width as Int64)
    }
}
