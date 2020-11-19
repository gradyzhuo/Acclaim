//
//  Error.swift
//  Procedure
//
//  Created by Grady Zhuo on 08/01/2017.
//  Copyright © 2017 Grady Zhuo. All rights reserved.
//


extension Procedure {
    public struct Error : Swift.Error {
        public let name: String
        public let userInfo: [String: Any]?
        public let reason: String?

        public init(name: String, reason: String? = nil, userInfo:[String:Any]? = nil){
            self.name = name
            self.reason = reason
            self.userInfo = userInfo
        }
    }
}

extension Procedure.Error : ExpressibleByStringLiteral{
    public typealias ExtendedGraphemeClusterLiteralType = String
    public typealias StringLiteralType = String
    public typealias UnicodeScalarLiteralType = String
    
    public init(stringLiteral value: StringLiteralType){
        self = Procedure.Error(name: value)
    }
    
    public init(extendedGraphemeClusterLiteral value: ExtendedGraphemeClusterLiteralType) {
        self = Procedure.Error(stringLiteral: value)
    }
    
    public init(unicodeScalarLiteral value: UnicodeScalarLiteralType) {
        self = Procedure.Error(stringLiteral: value)
    }
}

extension Procedure.Error : Intent {
    public var command: String {
        return name
    }
    
    public var value: Any? {
        return userInfo
    }
    
    public init(command: String, value: Any? = nil) {
        self = Procedure.Error(name: command, reason: nil, userInfo: nil)
    }
    
}
