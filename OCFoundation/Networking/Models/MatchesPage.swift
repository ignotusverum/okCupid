//
//  MatchesPage.swift
//  OCFoundation
//
//  Created by Vlad Z. on 1/27/20.
//  Copyright © 2020 Vlad Z. All rights reserved.
//

public struct MatchesPage: Decodable {
    public let items: [Match]
    
    enum CodingKeys: String, CodingKey {
        case items = "data"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        items = try container.decode([Match].self, forKey: .items)
    }
}
