//
//  Photo.swift
//  OCFoundation
//
//  Created by Vlad Z. on 1/27/20.
//  Copyright © 2020 Vlad Z. All rights reserved.
//

public struct Photo:
    PhotoProtocol,
    Decodable {
    
    public let type: PhotoType
    public let path: String
    
    public init(from decoder: Decoder) throws {
        /// Based on requirements, maybe we want to throw, vs return undefined?
        type = try PhotoType(rawValue: decoder.currentTitle()) ?? .undefined
        
        let container = try decoder.singleValueContainer()
        path = try container.decode(String.self)
    }
}

public struct PhotoContainer:
    PhotoContainerProtocol,
    Decodable {
    public let photos: [Photo]
    public init(from decoder: Decoder) throws {
        photos = try decoder.decodeTitledElements(Photo.self)
    }
}

