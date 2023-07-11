//
//  WeatherState.swift
//  WeatherAPI
//
//  Created by Çağla Karakuş on 4/18/23.
//

import Foundation

struct WeatherState: Codable {
    
    let temperature: Int
    let city: String
    let desriptions :[String]
    let icons : [URL]
    var dictionary: [String: Any] {
        return ["temperature": temperature,
                "city": city,
                "desriptions": desriptions,
                "icons": icons]
    }
}
