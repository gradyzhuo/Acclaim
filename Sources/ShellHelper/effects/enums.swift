//
//  enums.swift
//  
//
//  Created by Grady Zhuo on 2020/3/22.
//

import Foundation

public enum TextColor{
    case config(normal: BoundaryCode, light:BoundaryCode?)

    public var normal: BoundaryCode{
        switch self{
        case .config(let normal, _):
            return normal
        }
    }
    
    public var light: BoundaryCode{
        switch self{
        case .config(_, let light):
            guard let light = light else{
                return self.normal
            }
            return light
        }
    }

}

extension TextColor:Formattable, LiteralDecorator{
    public var literalCode: String{
        return self.normal.literalCode
    }
    
    public func format(_ text: String) -> String {
        return self.normal.format(text)
    }
}

extension TextColor{
    public static let `default` = TextColor.config(normal: BoundaryCode(39), light: nil)
    public static let black = TextColor.config(normal:BoundaryCode(30), light:BoundaryCode(30))
    public static let white = TextColor.config(normal:BoundaryCode(97), light:nil)
    public static let red = TextColor.config(normal:BoundaryCode(31), light:BoundaryCode(91))
    public static let green = TextColor.config(normal:BoundaryCode(32), light:BoundaryCode(92))
    public static let yellow = TextColor.config(normal:BoundaryCode(33), light:BoundaryCode(93))
    public static let blue = TextColor.config(normal:BoundaryCode(34), light:BoundaryCode(94))
    public static let magenta = TextColor.config(normal:BoundaryCode(35), light:BoundaryCode(95))
    public static let cyan = TextColor.config(normal:BoundaryCode(36), light:BoundaryCode(96))
    public static let gray = TextColor.config(normal:BoundaryCode(90), light:BoundaryCode(37))
}

public enum BackgroundColor{
    case config(normal: BoundaryCode, light:BoundaryCode?)

    public var normal: BoundaryCode{
        switch self{
        case .config(let normal, _):
            return normal
        }
    }
    
    public var light: BoundaryCode{
        switch self{
        case .config(_, let light):
            guard let light = light else{
                return self.normal
            }
            return light
        }
    }

}

extension BackgroundColor:Formattable, LiteralDecorator{
    public var literalCode: String{
        return self.normal.literalCode
    }
    
    public func format(_ text: String) -> String {
        return self.normal.format(text)
    }
}

extension BackgroundColor{
    public static let `default` = BackgroundColor.config(normal:BoundaryCode(49), light:nil)
    public static let black = BackgroundColor.config(normal:BoundaryCode(40), light:nil)
    public static let white = BackgroundColor.config(normal:BoundaryCode(107), light:nil)
    public static let red = BackgroundColor.config(normal:BoundaryCode(41), light:BoundaryCode(101))
    public static let green = BackgroundColor.config(normal:BoundaryCode(42), light:BoundaryCode(102))
    public static let yellow = BackgroundColor.config(normal:BoundaryCode(43), light:BoundaryCode(103))
    public static let blue = BackgroundColor.config(normal:BoundaryCode(44), light:BoundaryCode(104))
    public static let magenta = BackgroundColor.config(normal:BoundaryCode(45), light:BoundaryCode(105))
    public static let cyan = BackgroundColor.config(normal:BoundaryCode(46), light:BoundaryCode(106))
    public static let gray = BackgroundColor.config(normal:BoundaryCode(100), light:BoundaryCode(47))
}


public enum Style{
    case config(normal: BoundaryCode)

    public var normal: BoundaryCode{
        switch self{
        case .config(let normal):
            return normal
        }
    }
}

extension Style:Formattable, LiteralDecorator{
    public var literalCode: String{
        return self.normal.literalCode
    }
    
    public func format(_ text: String) -> String {
        return self.normal.format(text)
    }
}


extension Style{
    public static let bold = Style.config(normal:BoundaryCode(1, reset: 21))
    public static let dim = Style.config(normal:BoundaryCode(2, reset: 22))
    public static let underlined = Style.config(normal:BoundaryCode(4, reset: 24))
    public static let blink = Style.config(normal:BoundaryCode(5, reset: 25))
    public static let reverse = Style.config(normal:BoundaryCode(7, reset: 27))
    public static let hidden = Style.config(normal:BoundaryCode(8, reset: 28))
}
