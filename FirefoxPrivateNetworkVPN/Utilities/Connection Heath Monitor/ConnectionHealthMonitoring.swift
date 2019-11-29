//
//  ConnectionHealthMonitoring
//  FirefoxPrivateNetworkVPN
//
//  This Source Code Form is subject to the terms of the Mozilla Public
//  License, v. 2.0. If a copy of the MPL was not distributed with this
//  file, You can obtain one at https://mozilla.org/MPL/2.0/.
//
//  Copyright © 2019 Mozilla Corporation.
//

import RxSwift
import RxCocoa

protocol ConnectionHealthMonitoring {
    var currentState: Driver<ConnectionState> { get }

    func start(hostAddress: String)
    func reset()
}
