//
//  BanShoutGift.swift
//  Procedure
//
//  Created by Grady Zhuo on 22/11/2016.
//  Copyright © 2016 Grady Zhuo. All rights reserved.
//

import Foundation

public struct SimpleIntent : Intent  {
    
    public let command: String
    public let value: Any?
    
    public init(command: String, value: Any? = nil){
        self.command = command
        self.value = value
    }
    
}

extension SimpleIntent : ExpressibleByStringLiteral{
    public typealias ExtendedGraphemeClusterLiteralType = String
    public typealias StringLiteralType = String
    public typealias UnicodeScalarLiteralType = String
    
    public init(stringLiteral value: StringLiteralType){
        self = SimpleIntent(command: value)
    }
    
    public init(extendedGraphemeClusterLiteral value: ExtendedGraphemeClusterLiteralType) {
        self = SimpleIntent(stringLiteral: value)
    }
    
    public init(unicodeScalarLiteral value: UnicodeScalarLiteralType) {
        self = SimpleIntent(stringLiteral: value)
    }
}
