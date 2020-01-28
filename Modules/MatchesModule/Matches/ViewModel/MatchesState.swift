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
    /// Ideally we would also want to introduce empty state, if there's no results
    case pages([MatchesRow])
    
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
            
            let pageToRows = newDatasource.items
                .sorted(by: { $0.match > $1.match }) // Maybe in the future it should be sorted by location, based on business needs
                .map(MatchesRow.init)
            
            return .pages(pageToRows)
        }
    }
}
