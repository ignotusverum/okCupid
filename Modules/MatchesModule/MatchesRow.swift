//
//  MatchesRow.swift
//  MatchesModule
//
//  Created by Vlad Z. on 1/27/20.
//  Copyright © 2020 Vlad Z. All rights reserved.
//

import OCFoundation
import RxDataSources

struct MatchesRow {
    let imageURL: URL?
    let title: String
    let ageLocationSubtitle: String
    
    private let match: Int
    private let activeType: OnlineType
    
    
    var isOnline: Bool {
        activeType == .active
    }
    
    var matchPercentage: String {
        "\(match / 100)% Match"
    }
    
    init(model: Match) {
        match = model.match
        title = model.userName
        activeType = model.onlineType
        imageURL = model.photo.photoByType[.large]?.pathURL
        ageLocationSubtitle = "\(model.age) • \(model.location.cityName), \(model.location.stateCode)"
    }
}
