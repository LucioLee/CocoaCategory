//
//  NSString+Extension.swift
//  LucioExtension
//
//  Created by 李新新 on 16/4/13.
//  Copyright © 2016年 Person. All rights reserved.
//

import Foundation

public extension String {
    
    public var trim: String {
        return trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
    
    public var isPureInt: Bool {
        let scanner = Scanner(string: self)
        var value: Int = 0 //从下标0开始，扫描到的数字，碰到非数字就停止。比如 string = "12ss",则value = 12
        return scanner.scanInt(&value) && scanner.isAtEnd
    }
    
    public var escaped: String {
        let generalDelimitersToEncode = ":#[]@" // does not include "?" or "/" due to RFC 3986 - Section 3.4
        let subDelimitersToEncode = "!$&'()*+,;="
        
        var allowedCharacterSet = CharacterSet.urlQueryAllowed
        allowedCharacterSet.remove(charactersIn: "\(generalDelimitersToEncode)\(subDelimitersToEncode)")
        
        return self.addingPercentEncoding(withAllowedCharacters: allowedCharacterSet) ?? ""
    }
    
    public var lowercaseFirstCharacter: String {
        let offsetedIndex = index(startIndex, offsetBy: 1)
        let range = startIndex..<offsetedIndex
        let firstChar = substring(to: offsetedIndex).lowercased()
        return replacingCharacters(in: range, with: firstChar)
    }
    
    public var uppercaseFirstCharacter: String {
        let offsetedIndex = index(startIndex, offsetBy: 1)
        let range = startIndex..<offsetedIndex
        let firstChar = substring(to: offsetedIndex).uppercased()
        return replacingCharacters(in: range, with: firstChar)
    }
    
}