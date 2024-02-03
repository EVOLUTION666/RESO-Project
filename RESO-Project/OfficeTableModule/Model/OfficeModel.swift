//
//  OfficeModel.swift
//  RESO-Project
//
//  Created by Andrey on 07.05.2022.
//

import Foundation

// MARK: - OfficeElement
struct OfficeElement: Codable {
    let idokrug: Int
    let sstatus: Sstatus
    let ndistanse, nlong: Double
    let saddress, sshortname, sshortaddress: String
    let sphone: String?
    let sgraf: String
    let graf: [Graf]?
    let nlat: Double
    let cphone: [Cphone]
    let ntimezone: Ntimezone
    let semail: String?
    
    func officeIsOpen() -> Bool {
        
        var timeZoneID = ntimezone.rawValue
        
        if timeZoneID.first == " " {
            timeZoneID.removeFirst()
        }
        
        guard let timeZone = TimeZone.init(abbreviation: "GMT+\(timeZoneID)") else { return false }
        
        let calendar = Calendar(identifier: .gregorian)
        
        var dayOfWeek = calendar.component(.weekday, from: Date()) - calendar.firstWeekday
        if dayOfWeek <= 0 {
            dayOfWeek += 7
        }
        let dateComponents = calendar.dateComponents(in: timeZone, from: Date())
        
        guard let currentHour = dateComponents.hour,
              let currentMinute = dateComponents.minute,
              let graf = graf,
              let currentGraf = graf.first(where: {$0.nday == dayOfWeek}) else { return false }
        
        var beginTime = currentGraf.sbegin.rawValue
        var endTime = currentGraf.send.rawValue
        if beginTime.first == " " {
            beginTime.removeFirst()
        }
        if endTime.first == " " {
            endTime.removeFirst()
        }
        
        let dateFormatted = DateFormatter()
        dateFormatted.dateFormat = "HH.mm"
        
        guard let beginDate = dateFormatted.date(from: beginTime),
              let endDate = dateFormatted.date(from: endTime) else { return  false }
        
        let beginHour = Calendar.current.component(.hour, from: beginDate)
        let beginMinute = Calendar.current.component(.minute, from: beginDate)
        let endHour = Calendar.current.component(.hour, from: endDate)
        let endMinute = Calendar.current.component(.minute, from: endDate)
        
        let openMinutes = (beginHour * 60) + beginMinute
        let closedMinutes = (endHour * 60) + endMinute
        let currentMinutes = (currentHour * 60) + currentMinute
        
        return currentMinutes >= openMinutes && currentMinutes <= closedMinutes
    }
    
    enum CodingKeys: String, CodingKey {
        case idokrug = "IDOKRUG"
        case sstatus = "SSTATUS"
        case ndistanse = "NDISTANSE"
        case nlong = "NLONG"
        case saddress = "SADDRESS"
        case sshortname = "SSHORTNAME"
        case sshortaddress = "SSHORTADDRESS"
        case sphone = "SPHONE"
        case sgraf = "SGRAF"
        case graf = "GRAF"
        case nlat = "NLAT"
        case cphone = "CPHONE"
        case ntimezone = "NTIMEZONE"
        case semail = "SEMAIL"
    }
}

// MARK: - Cphone
struct Cphone: Codable {
    let sphone, sphonetype, sphoneadd: String
    
    enum CodingKeys: String, CodingKey {
        case sphone = "SPHONE"
        case sphonetype = "SPHONETYPE"
        case sphoneadd = "SPHONEADD"
    }
}

// MARK: - Graf
struct Graf: Codable {
    let sbegin: Sbegin
    let nday: Int
    let send: Send
    
    enum CodingKeys: String, CodingKey {
        case sbegin = "SBEGIN"
        case nday = "NDAY"
        case send = "SEND"
    }
}

enum Sbegin: String, Codable {
    case empty = ""
    case sbegin1000 = "10.00 "
    case sbegin930 = "9.30 "
    case the0800 = "08.00"
    case the0900 = "09.00"
    case the0930 = "09.30"
    case the1000 = "10.00"
    case the1100 = "11.00"
    case the1200 = "12.00"
    case the830 = "8.30"
    case the900 = "9.00"
    case the930 = "9.30"
}

enum Send: String, Codable {
    case send1800 = " 18.00"
    case send2000 = " 20.00"
    case the10001800 = "10.0018.00"
    case the1400 = "14.00"
    case the1600 = "16.00"
    case the1630 = "16.30"
    case the1700 = "17.00"
    case the1800 = "18.00"
    case the1900 = "19.00"
    case the2000 = "20.00"
    case the2030 = "20.30"
    case the2100 = "21.00"
    case the2200 = "22.00"
    case the2400 = "24.00"
    case выходной = "выходной"
    case нет = "нет"
}

enum Ntimezone: String, Codable {
    case the0300 = " 03:00"
}

enum Sstatus: String, Codable {
    case открыто = "Открыто"
}

//typealias Office = [OfficeElement]
