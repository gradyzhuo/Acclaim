//
//  File.swift
//  
//
//  Created by Grady Zhuo on 2020/11/14.
//

import Foundation
import Logger
import ShellHelper

let aa = StdLog(level: .info)
aa("hello")


var str = "Hello, playground"

var a : ShellText = str.effect()
a.styles = [.blink, .bold, .reverse]
print(a)



