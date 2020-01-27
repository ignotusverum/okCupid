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
    
    public var cityName: String
    public var countryCode: String
    public var countryName: String
    public var stateCode: String
    public var stateName: String
    
    enum CodingKeys: String, CodingKey {
        case cityName
        case countryCode
        case countryName
        case stateCode
        case stateName
    }
}
