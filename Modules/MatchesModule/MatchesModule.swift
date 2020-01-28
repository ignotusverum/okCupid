//
//  MatchesModule.swift
//  MatchesModule
//
//  Created by Vlad Z. on 1/27/20.
//  Copyright © 2020 Vlad Z. All rights reserved.
//

import MERLin
import OCFoundation

public class MatchesModuleContext: ModuleContextProtocol {
    public typealias ModuleType = MatchesModule
    public var routingContext: String
    
    public init(routingContext: String) {
        self.routingContext = routingContext
    }
    
    public func make()-> (AnyModule, UIViewController) {
        let module = ModuleType(usingContext: self)
        return (module, module.prepareRootViewController())
    }
}

public enum MatchesModuleEvents: EventProtocol {
    case matchIdSelected(String)
}

public class MatchesModule: ModuleProtocol, EventsProducer {
    public var events: Observable<MatchesModuleEvents> { return _events.asObservable() }
    private var _events = PublishSubject<MatchesModuleEvents>()
    
    public var context: MatchesModuleContext
    
    public required init(usingContext buildContext: MatchesModuleContext) {
        context = buildContext
    }
    
    public func unmanagedRootViewController() -> UIViewController {
        let model = MatchesModel()
        let viewModel = MatchesViewModel(model: model,
                                         events: _events)
        
        let view = MatchesViewController(with: viewModel)
        
        return view
    }
}
