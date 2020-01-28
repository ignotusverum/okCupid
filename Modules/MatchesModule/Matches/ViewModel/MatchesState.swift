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
    indirect case error(Error, whileInState: MatchesState)
    
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
            
            /// Update when paging in place
            let pageToRows = newDatasource.items
                .map(MatchesRow.init)
            
            return .pages(pageToRows)
        case (_, let .error(error)):
            return .error(error, whileInState: state)
        }
    }
    
    static func == (lhs: MatchesState,
                    rhs: MatchesState) -> Bool {
        switch (lhs, rhs) {
        case let (.pages(lPages), .pages(rPages)): return lPages == rPages
        case let (.loading(lState), .loading(rState)): return lState == rState
        case let (.error(lError, lState), .error(rError, rState)):
            return lError.localizedDescription == rError.localizedDescription && lState == rState
        default: return false
        }
    }
}
