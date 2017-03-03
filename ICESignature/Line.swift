//
//  Line.swift
//  ICESignature
//
//  Created by Jeriko on 2/22/17.
//  Copyright © 2017 Jeriko. All rights reserved.
//

import UIKit

internal class Line {
    var start: CGPoint
    var end: CGPoint
    var previousPoint1: CGPoint
    var previousPoint2: CGPoint
    var currentPoint: CGPoint
    
    init(start _start: CGPoint, end _end: CGPoint, previousPoint1 _previousPoint1: CGPoint, previousPoint2 _previousPoint2: CGPoint, currentPoint _currentPoint: CGPoint){
        start = _start
        end = _end
        previousPoint1 = _previousPoint1
        previousPoint2 = _previousPoint2
        currentPoint = _currentPoint
    }
}
