//
//  protocol.swift
//  
//
//  Created by Grady Zhuo on 2020/3/21.
//

import Foundation

public protocol LiteralDecorator{
    var literalCode:String { get }
}

public protocol Formattable{
    func format(_ text: String)->String
}


