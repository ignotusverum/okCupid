//
//  Match.swift
//  OCFoundation
//
//  Created by Vlad Z. on 1/27/20.
//  Copyright © 2020 Vlad Z. All rights reserved.
//

public enum OnlineType: Int, Decodable {
    case offline = 0
    case active
    case unknown
}

public struct Match:
    MatchProtocol,
    Decodable {
    public let age: Int
    public let match: Int
    public let liked: Bool
    public let userId: String
    public let onlineType: OnlineType
    public let userName: String
    public let location: Location
    public let photo: PhotoContainer
    
    enum CodingKeys: String, CodingKey {
        case age
        case liked
        case match
        case photo
        case userId = "userid"
        case onlineType = "is_online"
        case userName = "username"
        case location
    }
}

extension Match: Equatable {
    public static func == (lhs: Match, rhs: Match) -> Bool { lhs.userId == rhs.userId }
}
