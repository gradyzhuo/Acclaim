//
//  code.swift
//  
//
//  Created by Grady Zhuo on 2020/3/22.
//

import Foundation

public struct Code {
    public internal(set) var value: Int
    
    public init(_ value: Int){
        self.value = value
    }
}

extension Code: Formattable, LiteralDecorator{
    public var literalCode:String{
        return #"\033[\#(self.value)m"#
    }
    
    public func format(_ text: String)->String{
        return #"\#(self.literalCode)\#(text)"#
    }
}

extension String.StringInterpolation {
    mutating func appendInterpolation(_ value: Code) {
        appendInterpolation(value.literalCode)
    }
}

public struct BoundaryCode{
    public internal(set) var normal: Code
    public internal(set) var reset: Code
    
    
    public var value: Int{
        return self.normal.value
    }

    public init(_ normalCode: Int, reset resetCode: Int=0){
        self.normal = Code(normalCode)
        self.reset = Code(resetCode)
    }
}

extension BoundaryCode: Formattable, LiteralDecorator{
    public var literalCode:String{
        return self.normal.literalCode
    }

    public func format(_ text: String)->String{
        return  #"\#(self.normal.format(text))\#(self.reset)"#
    }
}
