//
//  SongsListInteractor.swift
//  AppleMusic
//
//  Created by Hasan Serdar Bakirtas on 09.08.22.
//

import Foundation
import SwiftUI
import Combine

class SongsListInteractor {
    
    // MARK: Injected
    @Injected(\.networkProvider) var networkProvider: APIRepo

    let viewState: SongsListViewState
    
    // MARK: Private properties
    private var cancellables = Set<AnyCancellable>()
    private var updateCancellable: AnyCancellable?

    // Set 500 miliseconds to wait for the text to end to make a request.
    private let timeInterval: TimeInterval = 0.5

    // Limit of records per page. (Only if backend supports, it usually does)
    private let perPage = 20
    
    // Error message
    private var errorSubject: PassthroughSubject<APIError, Never> = PassthroughSubject<APIError, Never>()
    init() {
        self.viewState = SongsListViewState()
    }
}


// MARK: - Requests

extension SongsListInteractor {

    func loadChartSongList() {

        updateCancellable = networkProvider.response(from: StandartChartsSongListRepository(apiRepo: .getSongList(offset: viewState.currentPage)))
            .map { return $0.results.songs.first!.data.map(SongsItem.init) }
            .sink( receiveCompletion: { [weak self] completion in
                guard case .failure(let error) = completion else { return }
                self?.failureResponseData(error: error)
            }, receiveValue: { [weak self] songList in
                self?.checkPaginationAndAddSongItem(with: songList)
            })
    }

    func updateSongList(with search: String) {

        updateCancellable = Just<Void>(())
            .delay(for: .seconds(timeInterval), scheduler: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                guard case .failure = completion else { return }
                self?.updateSongList(with: search)
            }, receiveValue: { [weak self] state in
                self?.loadSongList(with: search)
            })
    }

    func loadSongList(with search: String) {

        updateCancellable = networkProvider.response(from: StandartSongListRepository(apiRepo: .getFilteredSongList(term: search, offset: viewState.currentPage)))
            .map { return $0.results.songs.data.map(SongsItem.init) }
            .sink( receiveCompletion: { [weak self] completion in
                guard case .failure(let error) = completion else { return }
                self?.failureResponseData(error: error)
                Logger.error(error)
            }, receiveValue: { [weak self] songList in
                self?.checkPaginationAndAddSongItem(with: songList)
            })
    }
}


// MARK: - Helpers

extension SongsListInteractor {

    private func checkPaginationAndAddSongItem(with songList: [SongsItem]) {
        viewState.currentPage += 20
        viewState.dataSource.append(contentsOf: songList)
        if songList.count < perPage {
            viewState.songListFull = true
        }
    }

    /// if receive process is not completed
    private func failureResponseData(error: APIError) {
        errorSubject.assign(to: \.viewState.errorMessage, on: self).store(in: &cancellables)
        errorSubject.send(error)
        viewState.isShownError.toggle()
    }

    func resetResponseData() {
        viewState.currentPage = 0
        viewState.dataSource.removeAll()
        cancellables.removeAll()
        updateCancellable?.cancel()
    }
}
