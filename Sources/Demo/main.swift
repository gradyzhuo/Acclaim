//
//  File.swift
//  
//
//  Created by Grady Zhuo on 2020/11/14.
//

import Foundation
import Logger
import ShellHelper

//let aa = InfoLogger<ConsoleOutputStream>(level: .info)
//aa("hello")


var str = "Hello, playground\n"

var a : ShellText = str.effect()
a.textColor = .blue
a.styles = [.blink, .bold, .reverse]
print(a)


//main.stdout.print(a)
//main.stdout.write("\(a.formatted)")
//\033[%dm
print("\u{001B}[31m\u{001B}[41myellow\u{001B}[0;0m")

//ConsoleOutputStream.stdout.writeAndFlush(str)

//let logger = Info()
//logger.log("hello", "world")
//logger.log("hello", "world")

//Logger<Info>("a", "b", "c")

//Logger.info("hello", "world")
//print(Logger.info.current.namespace)


//let info2 = Logger.info[namespace: "test.test"]
//print(info2.current.namespace)

Logger.rootConfig.colored = false

Logger.critical("this is my test")
Logger.debug("debug")
