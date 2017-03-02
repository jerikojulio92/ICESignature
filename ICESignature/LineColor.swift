//
//  CMYK.swift
//  ICESignature
//
//  Created by Jeriko on 2/23/17.
//  Copyright © 2017 Jeriko. All rights reserved.
//

import UIKit

public class CMYKColor{
    private var _cyan: CGFloat = 1
    public var cyan: CGFloat{
        get{
           return _cyan
        }
        set(newValue){
            _cyan = setValue(value: newValue)
        }
    }
    
    private var _magenta: CGFloat = 1
    public var magenta: CGFloat{
        get{
            return _magenta
        }
        set(newValue){
            _magenta = setValue(value: newValue)
        }
    }
    
    private var _yellow: CGFloat = 1
    public var yellow: CGFloat{
        get{
            return _yellow
        }
        set(newValue){
            _yellow = setValue(value: newValue)
        }
    }
    
    private var _black: CGFloat = 1
    public var black: CGFloat{
        get{
            return _black
        }
        set(newValue){
            _black = setValue(value: newValue)
        }
    }
    
    private var _alpha: CGFloat = 1
    public var alpha: CGFloat{
        get{
            return _alpha
        }
        set(newValue){
            _alpha = setValue(value: newValue)
        }
    }
    
    private func setValue(value: CGFloat)-> CGFloat {
        var newValue = value
        if (value < 0 ) {newValue = .leastNonzeroMagnitude}
        return newValue
    }
}
