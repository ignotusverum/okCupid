//
//  AppDelegateEvent.swift
//  OkCupid
//
//  Created by Vlad Z. on 1/27/20.
//  Copyright © 2020 Vlad Z. All rights reserved.
//

import MERLin
import RxSwift

enum AppDelegateEvent: EventProtocol {
    case willFinishLaunching(application: UIApplication, launchOptions: [UIApplication.LaunchOptionsKey: Any]?)
}

