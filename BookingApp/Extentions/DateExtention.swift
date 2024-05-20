//
//  DateExtention.swift
//  BookingApp
//
//  Created by Gentjan Manuka on 2024-05-13.
//

import Foundation

enum DateType : String {
    case hour = "HH:mm" // return 19:00
    case date = "EEEE d MMMM" //return Fredag 12 mars
    case chatDate = "dd/mm/yy HH:mm"
    case dateAndHour = "EEEE d MMMM HH:mm"
    case fullDate = "EEEE d MMMM yyyy" //return full date
    case day = "dd"
    case weekday = "EEE"
    case month = "MMM"
    case monthValue = "M"
    case dateJSON = "yyyy-MM-dd'T'HH:mm:ssZ"
    case firstLetter = "E"
    case year = "yyyy"
}

extension Date {
    func extractDate(to dateType: DateType) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateType.rawValue
        return dateFormatter.string(from: self)
    }
    
    func showTime() -> String{
        if Calendar.current.isDateInToday(self){
            return self.extractDate(to: .hour)
        } else if Calendar.current.isDateInYesterday(self) {
            return "Yesterday " + self.extractDate(to: .hour)
        } else {
            return self.extractDate(to: .chatDate)
        }
    }
}

extension Date {
    
    static var firstDayOfWeek = Calendar.current.firstWeekday
    
    static var capitalizedFirstLettersOfWeekdays: [String] {
        let calendar = Calendar.current
        let weekdays = calendar.shortWeekdaySymbols
        
        return weekdays.map { weekday in
            guard let firstLetter = weekday.first else { return "" }
            return String(firstLetter).capitalized
        }
    }
    
    var startOfMonth: Date {
        Calendar.current.dateInterval(of: .month, for: self)!.start
    }
    
    var endOfMonth: Date {
        let lastDay = Calendar.current.dateInterval(of: .month, for: self)!.end
        return Calendar.current.date(byAdding: .day, value: -1, to: lastDay)!
    }
    
    var startOfPreviousMonth: Date {
        let dayInPreviusMonth = Calendar.current.date(byAdding: .month, value: -1, to: self)!
        return dayInPreviusMonth.startOfMonth
    }
    
    var numberOfDaysInTheMonth: Int {
        Calendar.current.component(.day, from: endOfMonth)
    }
    
    var sundayBeforeStart: Date {
        let startOfMonthWeekDay = Calendar.current.component(.weekday, from: startOfMonth)
        let numberFromPreviousMonth = startOfMonthWeekDay - 1
        return Calendar.current.date(byAdding: .day, value: -numberFromPreviousMonth, to: startOfMonth)!
    }
    
    var calendarDisplayDays: [Date] {
        var days: [Date] = []
        
        for dayOffset in 0..<numberOfDaysInTheMonth {
            let newDay = Calendar.current.date(byAdding: .day, value: dayOffset, to: startOfMonth)
            days.append(newDay!)
        }
        
        for dayOffset in 0..<startOfPreviousMonth.numberOfDaysInTheMonth {
            let newDay = Calendar.current.date(byAdding: .day, value: dayOffset, to: startOfPreviousMonth)
            days.append(newDay!)
        }
        return days.filter { $0 >= sundayBeforeStart && $0 <= endOfMonth}.sorted(by: <)
    }
    
    var startOfDay: Date {
            Calendar.current.startOfDay(for: self)
    }
    
    var calendarDays: [Date] {
        var days: [Date] = []
        
        for dayOffset in 0..<numberOfDaysInTheMonth {
            let newDay = Calendar.current.date(byAdding: .day, value: dayOffset, to: startOfMonth)
            days.append(newDay!)
        }
        return days.filter { $0 >= sundayBeforeStart && $0 <= endOfMonth}.sorted(by: <)
    }
    
    
}

