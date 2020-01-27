//
//  Match.swift
//  OCFoundation
//
//  Created by Vlad Z. on 1/27/20.
//  Copyright © 2020 Vlad Z. All rights reserved.
//

public struct Match:
    MatchProtocol,
    Decodable {
    public var age: Int
    public var liked: Bool
    public var userId: String
    public var isOnline: Bool
    public var userName: String
    public var location: Location
    public var photo: PhotoContainer
    
    enum CodingKeys: String, CodingKey {
        case age
        case liked
        case photo
        case userId
        case isOnline
        case userName
        case location
    }
}
