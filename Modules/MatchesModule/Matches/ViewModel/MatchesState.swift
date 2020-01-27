//
//  MatchesState.swift
//  OkCupid
//
//  Created by Vlad Z. on 1/27/20.
//  Copyright © 2020 Vlad Z. All rights reserved.
//

import MERLin
import OCFoundation

enum MatchesState: CaseAccessible, Equatable {
    case pages([MatchesPage])
    
    indirect case loading(whileInState: MatchesState?)
    
    static func reduce(_ state: MatchesState,
                       action: MatchesUIAction) -> MatchesState {
        switch (state, action) {
            // Reload
        case let (.loading(aState), .reload):
                return .loading(whileInState: aState)
            case (.pages, .reload):
                return .loading(whileInState: state)
        // Not changing state
        default: return state
        }
    }
    
    static func reduce(_ state: MatchesState,
                       model: MatchesModelAction) -> MatchesState {
        switch (state, model) {
        case (_, .loaded(let newDatasource)):
            return .pages([newDatasource])
        }
    }
}

/// TODO: In the future this needs to be based on page id
extension MatchesPage: Equatable {
    public static func == (lhs: MatchesPage, rhs: MatchesPage) -> Bool { true }
}
