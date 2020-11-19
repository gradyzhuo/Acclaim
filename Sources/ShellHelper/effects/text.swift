//
//  text.swift
//  
//
//  Created by Grady Zhuo on 2020/9/24.
//

import Foundation

public struct ShellText{
    
    private var text: String
    public var textColor: TextColor = .default
    public var backgroundColor: BackgroundColor = .default
    public var styles: [Style] = []
    public var formatable: Bool = true
    
    public init(stringLiteral text: String) {
        self.text = text
    }

    public init(_ text: String) {
        self.text = text
    }
    
    public var formatted : String{
        guard formatable else {
            return self.text
        }
        var formatted = textColor.format(self.text)
        formatted = backgroundColor.format(formatted)
        for s in styles{
            formatted = s.format(formatted)
        }
        return formatted
    }
}


extension ShellText: StringProtocol{
    public typealias UTF8View = String.UTF8View
    
    public typealias UTF16View = String.UTF16View
    
    public typealias UnicodeScalarView = String.UnicodeScalarView
    
    public var utf8: String.UTF8View{
        return self.text.utf8
    }
    
    public var utf16: String.UTF16View{
        return self.text.utf16
    }
    
    public var unicodeScalars: String.UnicodeScalarView{
        return self.text.unicodeScalars
    }
    
    public var startIndex: String.Index{
        return self.text.startIndex
    }
    
    public var endIndex: String.Index{
        return self.text.endIndex
    }
    
    public var description: String{
        return self.formatted
    }
    
    
    public init<C, Encoding>(decoding codeUnits: C, as sourceEncoding: Encoding.Type) where C : Collection, Encoding : _UnicodeEncoding, C.Element == Encoding.CodeUnit {
        self.text = String(decoding: codeUnits, as: sourceEncoding)
    }
    
    public init(cString nullTerminatedUTF8: UnsafePointer<CChar>) {
        self.text = String(cString: nullTerminatedUTF8)
    }
    
    public init<Encoding>(decodingCString nullTerminatedCodeUnits: UnsafePointer<Encoding.CodeUnit>, as sourceEncoding: Encoding.Type) where Encoding : _UnicodeEncoding {
        self.text = String(decodingCString: nullTerminatedCodeUnits, as: sourceEncoding)
    }
    
    public func withCString<Result>(_ body: (UnsafePointer<CChar>) throws -> Result) rethrows -> Result {
        return try self.text.withCString(body)
    }
    
    public func withCString<Result, Encoding>(encodedAs targetEncoding: Encoding.Type, _ body: (UnsafePointer<Encoding.CodeUnit>) throws -> Result) rethrows -> Result where Encoding : _UnicodeEncoding {
        return try self.text.withCString(encodedAs: targetEncoding, body)
    }
    
    public func index(before i: String.Index) -> String.Index {
        return self.text.index(before: i)
    }
    
    public func index(after i: String.Index) -> String.Index {
        return self.text.index(after: i)
    }
    
    public func uppercased() -> String {
        return self.text.uppercased()
    }

    public func lowercased() -> String {
        return self.text.lowercased()
    }
    
    public subscript(position: String.Index) -> Character {
        return self.text[position]
    }
    
    public mutating func write(_ string: String) {
        self.text = string
    }
    
    public func write<Target>(to target: inout Target) where Target : TextOutputStream {
        target.write(self.formatted)
    }
    
}
