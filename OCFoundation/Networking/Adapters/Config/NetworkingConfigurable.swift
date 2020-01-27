//
//  NetworkingConfigurable.swift
//  OCFoundation
//
//  Created by Vlad Z. on 1/27/20.
//  Copyright © 2020 Vlad Z. All rights reserved.
//

public protocol NetworkingConfigurable {
    static var baseURL: String { get }
}

public extension MainAPIConfigurable {
    static var baseURL: String { "techblog-static.s3.amazonaws.com" }
}

