//
//  MatchProtocol.swift
//  OCFoundation
//
//  Created by Vlad Z. on 1/27/20.
//  Copyright © 2020 Vlad Z. All rights reserved.
//

public protocol MatchProtocol {
    var age: Int { get }
    var liked: Bool { get }
    var userId: String { get }
    var isOnline: Bool { get }
    var userName: String { get }
    var location: Location { get }
    var photo: PhotoContainer { get }
}
