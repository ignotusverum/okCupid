//
//  MatchesActions.swift
//  MatchesModule
//
//  Created by Vlad Z. on 1/27/20.
//  Copyright © 2020 Vlad Z. All rights reserved.
//

import MERLin
import OCFoundation

enum MatchesUIAction: EventProtocol {
    case reload
    case matchSelected(Match)
}

enum MatchesModelAction: EventProtocol {
    case loaded(_ sections: MatchesPage)
}

enum MatchesActions: EventProtocol {
    case ui(MatchesUIAction)
    case model(MatchesModelAction)
}

