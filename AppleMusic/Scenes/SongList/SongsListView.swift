//
//  SongsListView.swift
//  AppleMusic
//
//  Created by Hasan Bakirtas on 18.07.22.
//

import Combine
import SwiftUI

struct SongsListView: View {

    @StateObject private var viewState: SongsListViewState
    @State private var interactor: SongsListInteractor

    @State private var searchText = ""

    init(interactor: SongsListInteractor) {
        _interactor = State(initialValue: interactor)
        _viewState = StateObject(wrappedValue: interactor.viewState)
    }

    var body: some View {
        NavigationView {
            List {
                viewState.dataSource.isEmpty ? AnyView(emptySection) : AnyView(songListItemView)
                if viewState.songListFull == false { fetchDataWithPagination }
            }
            .background(ColorPallet.WHITE.ignoresSafeArea())
            .listStyle(.plain)
            .navigationTitle("Songs")
        }
        .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always))
        .disableAutocorrection(true)
        
        .modifier(NavigationBarModifier(backgroundColor: ColorPallet.UI_WHITE, textColor: ColorPallet.UI_DARK_GRAY))

        .onChange(of: searchText) { searchText in
            interactor.resetResponseData()
            searchText.isEmpty ? interactor.loadChartSongList() : interactor.updateSongList(with: searchText)
        }
        .alert(isPresented: $viewState.isShownError, content: { () -> Alert in
            makeAlert()
        })
        .sheet(isPresented: $viewState.goToNextScreen, content: {
            detailScreen
        })
    }
}


// MARK: - Child views

private extension SongsListView {

    var songListItemView: some View {
        ForEach(0 ..< viewState.dataSource.count, id: \.hashValue) { index in
            SongListItemView(songItem: viewState.dataSource[index])
                .onTapGesture {
                    viewState.selectedIndex = index
                    viewState.goToNextScreen = true
                }
        }
        .listRowBackground(ColorPallet.WHITE)
    }

    var detailScreen: some View {
        SongsDetailView(interactor: SongsDetailInteractor(item: viewState.dataSource[viewState.selectedIndex]))
    }

    var emptySection: some View {
        Text("No results")
            .foregroundColor(.gray)
    }

    func makeAlert() -> Alert {
        Alert(title: Text(":("), message: Text("Song not found"))
    }

    var fetchDataWithPagination: some View {
        ActivityIndicator(style: .medium, isAnimating: .constant(true))
            .onAppear { searchText.isEmpty ? interactor.loadChartSongList() : interactor.updateSongList(with: searchText) }
    }
}


// MARK: - Preview Provider

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SongsListView(interactor: SongsListInteractor())
    }
}
#endif
