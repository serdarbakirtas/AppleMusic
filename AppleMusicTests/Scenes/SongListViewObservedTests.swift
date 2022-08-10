//
//  SongListViewObservedTests.swift
//  AppleMusicTests
//
//  Created by Hasan Bakirtas on 26.07.22.
//

import Combine
import XCTest
@testable import AppleMusic

class SongListViewObservedTests: XCTestCase {

    var sut: SongsListView.Observed!
    
    private var cancellables = Set<AnyCancellable>()

    override func setUp() {

        super.setUp()

        sut = SongsListView.Observed()
    }

    func test_givenRequestType_whenChartPathIsCalled_thenThePathIsEqual() {
        let endpoint = StandartChartsSongListRepository(apiRepo: .getSongList(offset: 0))
        
        XCTAssertEqual(endpoint.path, "charts")
    }

    func test_givenRequestType_whenChartPathIsCalled_thenTheMethodGetIsEqual() {
        let endpoint = StandartChartsSongListRepository(apiRepo: .getSongList(offset: 0))
        
        XCTAssertEqual(endpoint.method, .get)
    }

    // Mock APIRepo (MockedNetworkProvider)
    func test_givenResponseData_whenCallTheAPI_thenResponseDataIsNotEmpty() {

        InjectedValues[\.networkProvider] = MockedNetworkProvider()
        
        let mockApi = sut.networkProvider.response(from: StandartChartsSongListRepository(apiRepo: .getSongList(offset: 0)))

        mockApi.sink { completion in
            switch completion {
                case .finished:
                    XCTAssertNotNil(completion)
                case .failure:
                    XCTAssertNil(completion)
            }
        } receiveValue: { response in
            XCTAssertNotNil(response)
            XCTAssertEqual(response.results.songs.first?.data.first?.attributes.artistName, "DJ Robin & Schürze")
        }
        .store(in: &cancellables)
    }

    func test_givenRequestType_whenChartPathIsCalled_thenTheParamIsEqual() {
        let endpoint = StandartChartsSongListRepository(apiRepo: .getSongList(offset: 0))
        
        let queryItems = [
            URLQueryItem(name: "limit", value: "20"),
            URLQueryItem(name: "types", value: "songs"),
            URLQueryItem(name: "offset", value: "\(0)")
        ]
        
        XCTAssertEqual(endpoint.params, queryItems)
    }

    func test_givenRequestType_whenChartPathIsCalled_thenTheParamIsNotEqual() {
        let endpoint = StandartChartsSongListRepository(apiRepo: .getSongList(offset: 0))
        
        let queryItems = [
            URLQueryItem(name: "limit", value: "20"),
            URLQueryItem(name: "types", value: "charts"),
            URLQueryItem(name: "offset", value: "\(0)")
        ]
        
        XCTAssertNotEqual(endpoint.params, queryItems)
    }

    func test_givenRequestType_whenSearchPathIsCalled_thenThePathIsEqual() {
        let endpoint = StandartSongListRepository(apiRepo: .getFilteredSongList(term: "", offset: 0))
        
        XCTAssertEqual(endpoint.path, "search")
    }

    func test_givenRequestType_whenSearchPathIsCalled_thenTheParamIsEqual() {
        let endpoint = StandartSongListRepository(apiRepo: .getFilteredSongList(term: "tarkan", offset: 0))
        
        let queryItems = [
            URLQueryItem(name: "limit", value: "20"),
            URLQueryItem(name: "types", value: "songs"),
            URLQueryItem(name: "term", value: "tarkan"),
            URLQueryItem(name: "offset", value: "\(0)")
        ]
        
        XCTAssertEqual(endpoint.params, queryItems)
    }

    func test_givenRequestType_whenSearchPathIsCalled_thenTheParamIsNotEqual() {
        let endpoint = StandartSongListRepository(apiRepo: .getFilteredSongList(term: "sezen", offset: 0))
        
        let queryItems = [
            URLQueryItem(name: "limit", value: "20"),
            URLQueryItem(name: "types", value: "songs"),
            URLQueryItem(name: "term", value: "tarkan"),
            URLQueryItem(name: "offset", value: "\(0)")
        ]
        
        XCTAssertNotEqual(endpoint.params, queryItems)
    }

    func test_givenResponseData_whenResetDataSource_thenTheDataSourceIsEmpty() {

        sut.resetResponseData()
        
        XCTAssertTrue(sut.dataSource.isEmpty)
    }
    
    func test_givenSongList_whenUpdateDataSource_thenTheCurrentPageIsZero() {

        sut.updateSongList(with: "")
        
        XCTAssertEqual(sut.currentPage, 0)
    }
}
