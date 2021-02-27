//
//  extension.swift
//  
//
//  Created by Grady Zhuo on 2020/3/22.
//

import Foundation


extension String {
    public func effect(textColor: TextColor? = nil, backgroundColor:BackgroundColor? = nil, styles: TextStyle...)->ShellText{
        var shellText = ShellText(self)
        if let textColor = textColor{
            shellText.textColor = textColor
        }
        if let backgroundColor = backgroundColor{
            shellText.backgroundColor = backgroundColor
        }
        shellText.styles = styles
        return shellText
    }
}

extension ShellText {
    public func effect(textColor: TextColor? = nil, backgroundColor:BackgroundColor? = nil, styles: TextStyle...)->ShellText{
        var shellText = self
        if let textColor = textColor{
            shellText.textColor = textColor
        }
        if let backgroundColor = backgroundColor{
            shellText.backgroundColor = backgroundColor
        }
        shellText.styles = styles
        return shellText
    }
}

