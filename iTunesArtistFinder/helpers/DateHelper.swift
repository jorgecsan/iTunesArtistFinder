//
//  DateHelper.swift
//  UnidadEditorialTest
//
//  Created by Jorge Cordero Sanchez on 6/10/18.
//  Copyright © 2018 Informagic. All rights reserved.
//

import Foundation

class DateHelper{
    
    func getYearFromStringDate(stringDate: String) -> String{
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX") as Locale
        let date = dateFormatter.date(from: stringDate)!
        
        return date.getYear()
    }
}
