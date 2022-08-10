//
//  RequestState.swift
//  AppleMusic
//
//  Created by Hasan Serdar Bakirtas on 10.08.22.
//

import Foundation
import Combine

/// A type that represents the state of an asynchronous request. Views can then align their current appearance in accordance
/// with the current RequestState. It is usually owned by a screen state and set as part of the request publisher
/// pipeline, conveniently in combination with the mapToRequestState() combine operator.
enum RequestState<Value, Failure> {

    case pending
    case progressing
    case succeeded
    case failed(Failure)
}


// MARK: Convenience state accessors

extension RequestState {

    var isPending: Bool {

        if case .pending = self {
            return true
        }

        return false
    }

    var isProgressing: Bool {

        if case .progressing = self {
            return true
        }

        return false
    }

    var isSuccess: Bool {

        if case .succeeded = self {
            return true
        }

        return false
    }

    var isFailure: Bool {

        if case .failed = self {
            return true
        }

        return false
    }
}
