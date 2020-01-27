//
//  MatchesSetup.swift
//  OkCupid
//
//  Created by Vlad Z. on 1/27/20.
//  Copyright © 2020 Vlad Z. All rights reserved.
//

import MatchesModule
import MERLin
import Foundation

typealias MatchesEvents = MatchesModuleEvents

extension ModuleRoutingStep {
    static func matches() -> ModuleRoutingStep {
        let context = MatchesModuleContext(routingContext: "main")
        return ModuleRoutingStep(withMaker: context)
    }
}
