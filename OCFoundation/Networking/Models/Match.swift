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
    public let age: Int
    public let liked: Bool
    public let userId: String
    public let isOnline: Int
    public let userName: String
    public let location: Location
    public let photo: PhotoContainer
    
    enum CodingKeys: String, CodingKey {
        case age
        case liked
        case photo
        case userId = "userid"
        case isOnline = "is_online"
        case userName = "username"
        case location
    }
}

extension Match: Equatable {
    public static func == (lhs: Match, rhs: Match) -> Bool { lhs.userId == rhs.userId }
}
