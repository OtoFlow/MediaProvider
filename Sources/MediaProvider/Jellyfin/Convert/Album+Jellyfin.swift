//
//  Album+Jellyfin.swift
//  MediaProvider
//
//  Created by foyoodo on 2024/9/13.
//

import JellyfinAPI

extension Album {

    static func convertFromJellyfin(
        server: JellyfinServer,
        item: BaseItemDto
    ) -> Album {
        let artists = item.albumArtists?.compactMap { artist -> ReducedArtist? in
            guard let id = artist.id else {
                return nil
            }
            return .init(id: id, name: artist.name ?? "???")
        } ?? []

        let album = Album(
            id: item.id ?? "",
            name: item.name ?? "",
            artwork: .convertFromJellyfin(server: server, itemID: item.id ?? ""),
            isFavorite: item.userData?.isFavorite ?? false,
            overview: item.overview,
            genres: item.genres,
            artists: artists,
            releaseDate: item.premiereDate,
            recentPlayed: item.userData?.lastPlayedDate,
            playCount: item.userData?.playCount ?? 0
        )

        album.service = .jellyfin

        return album
    }
}
