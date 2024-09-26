//
//  JellyfinOnlineDataProvider.swift
//  MediaProvider
//
//  Created by foyoodo on 2024/9/13.
//

import Foundation
import JellyfinAPI

public class JellyfinOnlineDataProvider: LibraryDataProvider {

    public let userSession: JellyfinSession

    public init(userSession: JellyfinSession) {
        self.userSession = userSession
    }

    public func fetchTracks(
        type: [Track.MediaType],
        albumID: String?,
        artistID: String?,
        startIndex: Int?,
        limit: Int?,
        filter: ItemFilter?
    ) async throws -> [Track] {
        let client = userSession.client

        let itemTypes: [BaseItemKind] = type.map { mediaType in
            switch mediaType {
            case .audio:
                return .audio
            case .video:
                return .musicVideo
            }
        }

        var parameters = Paths.GetItemsParameters(
            userID: userSession.user.id,
            startIndex: startIndex,
            limit: limit,
            isRecursive: true,
            parentID: albumID,
            fields: [.parentID],
            includeItemTypes: itemTypes,
            filters: [.isNotFolder],
            enableUserData: true,
            enableImageTypes: [.primary],
            artistIDs: artistID.map { [$0] },
            enableImages: true
        )

        let request = Paths.getItems(parameters: parameters.withFilter(filter))

        let response = try await client.send(request)

        return response.value.items?.map {
            Track.convertFromJellyfin(server: userSession.server, item: $0)
        } ?? []
    }

    public func fetchAlbums(
        artistID: String?,
        startIndex: Int?,
        limit: Int?,
        filter: ItemFilter?
    ) async throws -> [Album] {
        let client = userSession.client

        var parameters = Paths.GetItemsParameters(
            userID: userSession.user.id,
            startIndex: startIndex,
            limit: limit,
            isRecursive: true,
            fields: [.genres, .overview, .dateCreated],
            includeItemTypes: [.musicAlbum],
            enableUserData: true,
            imageTypeLimit: 1,
            artistIDs: artistID.map { [$0] },
            enableImages: true
        )

        let request = Paths.getItems(parameters: parameters.withFilter(filter))
        let response = try await client.send(request)

        return response.value.items?.map {
            Album.convertFromJellyfin(server: userSession.server, item: $0)
        } ?? []
    }

    public func fetchArtists() async throws -> [Artist] {
        let client = userSession.client

        let parameters = Paths.GetArtistsParameters()

        let request = Paths.getArtists(parameters: parameters)
        let response = try await client.send(request)

        return response.value.items?.map {
            Artist.convertFromJellyfin(server: userSession.server, item: $0)
        } ?? []
    }

    public func fetchArtist(_ artistID: String) async throws -> Artist? {
        let client = userSession.client

        let request = Paths.getItem(itemID: artistID, userID: userSession.user.id)
        let response = try await client.send(request)

        guard response.value.id == artistID else {
            return nil
        }

        return .convertFromJellyfin(server: userSession.server, item: response.value)
    }

    public func fetchLyrics(itemID: String) async throws -> [Double : String?]? {
        let client = userSession.client

        let request = Paths.getLyrics(itemID: itemID)
        let response = try await client.send(request)

        return response.value.lyrics?
            .reduce(into: [:]) { lyrics, lyricLine in
                if let start = lyricLine.start {
                    lyrics[Double(start)] = lyricLine.text
                }
            }
    }

    public func performAction(_ action: ItemAction, itemID: String) async throws -> ItemAction.Status {
        switch action {
        case .like:
            try await like(itemID)
        case .dislike:
            try await dislike(itemID)
        }
    }
}

extension JellyfinOnlineDataProvider {

    public func like(_ itemID: String) async throws -> ItemAction.Status {
        let request = Paths.markFavoriteItem(itemID: itemID, userID: userSession.user.id)
        let response = try await userSession.client.send(request)
        return response.value.isFavorite == true ? .success : .failure
    }

    public func dislike(_ itemID: String) async throws -> ItemAction.Status {
        let request = Paths.unmarkFavoriteItem(itemID: itemID, userID: userSession.user.id)
        let response = try await userSession.client.send(request)
        return response.value.isFavorite == false ? .success : .failure
    }
}
