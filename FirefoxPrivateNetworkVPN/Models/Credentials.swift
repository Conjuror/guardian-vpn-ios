//
//  KeyStore
//  FirefoxPrivateNetworkVPN
//
//  This Source Code Form is subject to the terms of the Mozilla Public
//  License, v. 2.0. If a copy of the MPL was not distributed with this
//  file, You can obtain one at https://mozilla.org/MPL/2.0/.
//
//  Copyright © 2019 Mozilla Corporation.
//

import Foundation

private class CredentialsKeyStore {

    static let shared = CredentialsKeyStore()

    private static let containerKey = "org.mozilla.guardian.credentials"
    @KeychainStored(service: containerKey) var credentials: Credentials

    private init() { }
}

class Credentials: Codable {
    private(set) var deviceKeys: DeviceKeys
    private(set) var verificationToken: String

    init(with verification: VerifyResponse) {
        let privateKey = Curve25519.generatePrivateKey()
        let publicKey = Curve25519.generatePublicKey(fromPrivateKey: privateKey)
        deviceKeys = DeviceKeys(privateKey: privateKey, publicKey: publicKey)
        verificationToken = verification.token
    }

    // MARK: - Helpers

    static func fetchAll() -> Credentials? {
        return CredentialsKeyStore.shared.credentials
    }

    func saveAll() {
        CredentialsKeyStore.shared.credentials = self
    }

    static func removeAll() {
        CredentialsKeyStore.shared.credentials = nil
    }
}
