//
//  MatchesAdapter+Config.swift
//  OkCupid
//
//  Created by Vlad Z. on 1/27/20.
//  Copyright © 2020 Vlad Z. All rights reserved.
//

import OCFoundation

extension MatchesAdapter:
    MainAPIConfigurable,
    NetworkingConfigurable,
    MatchesAPIConfigurable {
    public static func configurator() {
        MatchesAdapter(config: AdapterConfig(base: baseURL,
                                             name: apiConfig.path))
    }
}

