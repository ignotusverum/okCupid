//
//  Location.swift
//  OCFoundation
//
//  Created by Vlad Z. on 1/27/20.
//  Copyright © 2020 Vlad Z. All rights reserved.
//

public struct Location:
    LocationProtocol,
    Decodable {
    
    public let cityName: String
    public let countryCode: String
    public let countryName: String
    public let stateCode: String
    public let stateName: String
    
    enum CodingKeys: String, CodingKey {
        case cityName = "city_name"
        case countryCode = "country_code"
        case countryName = "country_name"
        case stateCode = "state_code"
        case stateName = "state_name"
    }
}
