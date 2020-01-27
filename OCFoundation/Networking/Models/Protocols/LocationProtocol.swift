//
//  LocationProtocol.swift
//  OCFoundation
//
//  Created by Vlad Z. on 1/27/20.
//  Copyright © 2020 Vlad Z. All rights reserved.
//

public protocol LocationProtocol {
    var cityName: String { get }
    var stateCode: String { get }
    var stateName: String { get }
    var countryCode: String { get }
    var countryName: String { get }
}
