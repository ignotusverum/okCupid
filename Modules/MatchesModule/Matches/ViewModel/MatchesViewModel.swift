//
//  MatchesViewModel.swift
//  MatchesModule
//
//  Created by Vlad Z. on 1/27/20.
//  Copyright © 2020 Vlad Z. All rights reserved.
//

import MERLin
import OCFoundation

protocol MatchesViewModelProtocol {
    func transform(input: Observable<MatchesUIAction>) -> Observable<MatchesState>
    func transform(input: Observable<MatchesUIAction>,
                   scheduler: ImmediateSchedulerType) -> Observable<MatchesState>
}

class MatchesViewModel: MatchesViewModelProtocol {
    let model: MatchesModelProtocol
    let events: PublishSubject<MatchesModuleEvents>
    
    init(model: MatchesModelProtocol,
         events: PublishSubject<MatchesModuleEvents>) {
        self.model = model
        self.events = events
    }
    
    func transform(input: Observable<MatchesUIAction>) -> Observable<MatchesState> {
        return transform(input: input,
                         scheduler: MainScheduler.asyncInstance)
    }
    
    func transform(input: Observable<MatchesUIAction>,
                   scheduler: ImmediateSchedulerType) -> Observable<MatchesState> {
        let errors = PublishSubject<Error>()
        return Observable.feedbackLoop(initialState: MatchesState.loading(whileInState: nil),
                                       scheduler: scheduler,
                                       reduce: { (state, action) -> MatchesState in
                                        switch action {
                                        case let .ui(action): return .reduce(state, action: action)
                                        case let .model(action): return .reduce(state, model: action)
                                        }
        }, feedback: { _ in input.map(MatchesActions.ui) },
           weakify(self,
                   default: .empty()) { (me: MatchesViewModel, state) in
                    Observable.merge(state.capture(case: MatchesState.loading).toVoid()
                        .compactFlatMapLatest { _ in
                            me.model
                                .fetchMatches()
                                .asObservable()
                                .catchError(sendTo: errors)
                                .map(MatchesModelAction.loaded)
                        },
                                     errors.map(MatchesModelAction.error))
                        .map(MatchesActions.model)
        })
            .sendSideEffects({ state in
                input.capture(case: MatchesUIAction.matchIdSelected)
                    .map(MatchesModuleEvents.matchIdSelected)
            }, to: events.asObserver())
    }
}
