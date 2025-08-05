//
//  IRemoteRepository.swift
//  CowryTakeHome
//
//  Created by Moses A. on 04/08/2025.
//

import Foundation

protocol IRemoteRepository {
    var client: HTTPClient { get }
}

extension IRemoteRepository {
    func onResponse(_ result: HTTPClient.Result,
                      resultData: @escaping (Data) -> Void,
                      resultError: @escaping (ResponseError) -> Void) {
        switch result {
        case let .success(tupleResult as SuccessResponse):
            if let errorInfo = tupleResult.data.decode(key: "error")?.error?.info {
                resultError(.otherCause(errorInfo))
            } else {
                resultData(tupleResult.data)
            }
        case .failure(let error):
            resultError(.otherCause(error.localizedDescription))
        }
    }
}
