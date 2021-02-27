//
//  code.swift
//  
//
//  Created by Grady Zhuo on 2020/3/22.
//

import Foundation

public protocol Code: LiteralDecorator, Formattable{
    var value: Int { get }
}

public struct ValueCode: Code {
    public internal(set) var value: Int
    
    public init(_ value: Int){
        self.value = value
    }
}

extension Code{
    public var literalCode:String{
        return "\u{001B}[0\(self.value)m"
    }
    
    public func format(_ text: String)->String{
        return #"\#(self.literalCode)\#(text)"#
    }
}

extension String.StringInterpolation {
    mutating func appendInterpolation(_ value: ValueCode) {
        appendInterpolation(value.literalCode)
    }
}

public struct BoundaryCode: Code{
    public internal(set) var normal: ValueCode
    public internal(set) var reset: ValueCode
    
    
    public var value: Int{
        return self.normal.value
    }

    public init(_ normalCode: Int, reset resetCode: Int=0){
        self.normal = ValueCode(normalCode)
        self.reset = ValueCode(resetCode)
    }
    
    public func format(_ text: String)->String{
        return "\(self.literalCode)\(text)\(self.reset)"
    }
}

//extension String.StringInterpolation {
//    mutating func appendInterpolation() {
//        let formatter = NumberFormatter()
//        formatter.numberStyle = .spellOut
//
//        if let result = formatter.string(from: value as NSNumber) {
//            appendLiteral(result)
//        }
//    }
//}
