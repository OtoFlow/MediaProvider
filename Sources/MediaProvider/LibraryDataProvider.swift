//
//  LibraryDataProvider.swift
//  MediaProvider
//
//  Created by foyoodo on 2024/9/13.
//

import Foundation

public protocol LibraryDataProvider {

    func fetchTracks(type: [Track.MediaType], albumID: String?, artistID: String?, filter: ItemFilter?) async throws -> [Track]

    func fetchAlbums(artistID: String?, filter: ItemFilter?) async throws -> [Album]

    func fetchArtists() async throws -> [Artist]

    func fetchArtist(_ artistID: String) async throws -> Artist?

    func fetchLyrics(itemID: String) async throws -> [Double: String?]?

    func performAction(_ action: ItemAction, itemID: String) async throws -> ItemAction.Status
}

extension LibraryDataProvider {

    public func fetchTracks(
        type: [Track.MediaType] = [.audio],
        albumID: String? = nil,
        artistID: String? = nil,
        filter: ItemFilter? = nil
    ) async throws -> [Track] {
        try await fetchTracks(type: type, albumID: albumID, artistID: artistID, filter: filter)
    }

    public func fetchAlbums(
        artistID: String? = nil,
        filter: ItemFilter? = nil
    ) async throws -> [Album] {
        try await fetchAlbums(artistID: artistID, filter: filter)
    }
}
