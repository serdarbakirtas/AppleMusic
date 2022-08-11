//
//  RequestState.swift
//  AppleMusic
//
//  Created by Hasan Serdar Bakirtas on 10.08.22.
//

import Foundation
import Combine

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
