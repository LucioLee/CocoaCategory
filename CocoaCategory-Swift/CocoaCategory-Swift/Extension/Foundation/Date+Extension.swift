//
//  Date+Extension.swift
//
//  Created by Lucio on 15/12/23.
//  Copyright © 2016年 Person. All rights reserved.
//

import Foundation

public extension Date {
    
    public var era: Int {
        return NSCalendar.current.component(Calendar.Component.era, from: self)
    }
    public var year: Int {
        return NSCalendar.current.component(Calendar.Component.year, from: self)
    }
    public var month: Int {
        return NSCalendar.current.component(Calendar.Component.month, from: self)
    }
    public var day: Int {
        return NSCalendar.current.component(Calendar.Component.day, from: self)
    }
    public var hour: Int {
        return NSCalendar.current.component(Calendar.Component.hour, from: self)
    }
    public var minute: Int {
        return NSCalendar.current.component(Calendar.Component.minute, from: self)
    }
    public var second: Int {
        return NSCalendar.current.component(Calendar.Component.second, from: self)
    }
    public var weekOfMonth: Int {
        return NSCalendar.current.component(Calendar.Component.weekOfMonth, from: self)
    }
    public var weekOfYear: Int {
        return NSCalendar.current.component(Calendar.Component.weekOfYear, from: self)
    }
    public var weekday: Int {
        return NSCalendar.current.component(Calendar.Component.weekday, from: self)
    }
    public var weekdayOrdinal: Int {
        return NSCalendar.current.component(Calendar.Component.weekdayOrdinal, from: self)
    }
    public var quarter: Int {
        return Int(self.format(by: "Q"))!
    }
    public var nanosecond: Int {
        return NSCalendar.current.component(Calendar.Component.nanosecond, from: self)
    }
    public var weekDayName: String {
        return self.format(by: "EEEE")
    }
    public var monthName: String {
        return self.format(by: "MMMM")
    }
    
    public static var now: Date {
        return Date()
    }
    
    public static func from(string: String, withFormat dateFormat:String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        dateFormatter.locale = NSLocale.current
        return dateFormatter.date(from: string)
    }
    
    public func isLeapYear() -> Bool {
        return ((year % 400 == 0) || ((year % 100 != 0) && (year % 4 == 0)))
    }
    
    public func isToday() -> Bool {
        if fabs(self.timeIntervalSinceNow) >= 60 * 60 * 24 {
            return false
        }
        return Date().day == day
    }
    
    public func isYesterDay() -> Bool {
        let date = append(days: 1)!
        return date.isToday()
    }
    
    public func format(by dateFormat:String, timeZone: TimeZone = TimeZone.current, locale: Locale = Locale.current) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = locale
        dateFormatter.timeZone = timeZone
        dateFormatter.dateFormat = dateFormat
        return dateFormatter.string(from: self)
    }
    
    public func append(years: Int) -> Date? {
        var components = DateComponents()
        components.year = years
        return self.add(components: components)
    }
    
    public func append(months: Int) -> Date? {
        var components = DateComponents()
        components.month = months
        return self.add(components: components)
    }
    
    public func append(days: Int) -> Date? {
        var components = DateComponents()
        components.day = days
        return self.add(components: components)
    }
    
    public func append(hours: Int) -> Date? {
        var components = DateComponents()
        components.hour = hours
        return self.add(components: components)
    }
    
    public func append(minutes: Int) -> Date? {
        var components = DateComponents()
        components.minute = minutes
        return self.add(components: components)
    }
    
    public func append(seconds: Int) -> Date? {
        var components = DateComponents()
        components.minute = seconds
        return self.add(components: components)
    }
    
    public func add(components: DateComponents) -> Date? {
        var calendar = NSCalendar.current
        calendar.timeZone = TimeZone.current
        return calendar.date(byAdding: components, to: self)
    }
}

