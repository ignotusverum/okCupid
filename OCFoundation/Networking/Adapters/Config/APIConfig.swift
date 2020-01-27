//
//  APIConfig.swift
//  OCFoundation
//
//  Created by Vlad Z. on 1/27/20.
//  Copyright © 2020 Vlad Z. All rights reserved.
//

public struct APIConfig {
    public var path: String
    public init(path: String) {
        self.path = path
    }
}

enum MainAPIConfig {
    case matches
    
    func config() -> APIConfig {
        switch self {
        case .matches: return APIConfig(path: "interview/matches.json")
        }
    }
}

public protocol MainAPIConfigurable where Self: NetworkingConfigurable {
    static var apiConfig: APIConfig { get }
}

