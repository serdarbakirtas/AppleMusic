//
//  Dependencies.swift
//  AppleMusic
//
//  Created by Hasan Bakirtas on 25.07.22.
//

import Foundation

extension InjectedValues {
    var networkProvider: APIRepo {
        get { Self[NetworkProviderKey.self] }
        set { Self[NetworkProviderKey.self] = newValue }
    }
}

private struct NetworkProviderKey: InjectionKey {
    static var currentValue: APIRepo = API()
}
