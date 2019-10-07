// SPDX-License-Identifier: MIT
// Copyright © 2018-2019 WireGuard LLC. All Rights Reserved.

import Foundation

class NetworkLayer {
    static func fireURLRequest(with urlRequest: URLRequest, completion: @escaping (Result<Data, Error>) -> Void) {
        let defaultSession = URLSession(configuration: .default)
        defaultSession.configuration.timeoutIntervalForRequest = 120

        let dataTask = defaultSession.dataTask(with: urlRequest) { data, response, error in
            if let error = error {
                completion(.failure(error))
            } else if let data = data,
                let response = response as? HTTPURLResponse,
                response.statusCode == 200 {
                completion(.success(data))
            } else {
                completion(.failure(GuardianFailReason.no200))
            }
        }

        dataTask.resume()
    }
}
