//
//  MatchesAPIConfigurable.swift
//  OCFoundation
//
//  Created by Vlad Z. on 1/27/20.
//  Copyright © 2020 Vlad Z. All rights reserved.
//

public protocol MatchesAPIConfigurable where Self: MainAPIConfigurable {}

public extension MatchesAPIConfigurable {
    static var apiConfig: APIConfig { MainAPIConfig.matches.config() }
}

