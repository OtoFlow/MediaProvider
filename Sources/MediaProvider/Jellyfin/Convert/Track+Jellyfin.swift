//
//  Track+Jellyfin.swift
//  MediaProvider
//
//  Created by foyoodo on 2024/9/13.
//

import JellyfinAPI

extension Track {

    static func convertFromJellyfin(
        server: JellyfinServer,
        item: BaseItemDto
    ) -> Track {
        let artists = item.artistItems?.compactMap { artist -> ReducedArtist? in
            guard let id = artist.id else {
                return nil
            }
            return .init(id: id, name: artist.name ?? "???")
        } ?? []

        var artwork: Artwork?

        if item.imageTags?["Primary"] != nil {
            artwork = .convertFromJellyfin(server: server, itemID: item.id ?? "")
        } else if item.albumPrimaryImageTag != nil {
            artwork = .convertFromJellyfin(server: server, itemID: item.albumID ?? "")
        }

        let track = Track(
            id: item.id ?? "",
            name: item.name ?? "",
            artwork: artwork,
            isFavorite: item.userData?.isFavorite ?? false,
            type: item.type == .audio ? .audio : .video,
            album: .init(id: item.albumID ?? "", name: item.album ?? ""),
            artists: artists,
            index: .init(idx: item.indexNumber, disk: item.parentIndexNumber ?? -1),
            duration: Double(item.runTimeTicks ?? 0) / 10_000_000,
            releaseDate: item.premiereDate,
            recentPlayed: item.userData?.lastPlayedDate,
            playCount: item.userData?.playCount ?? 0
        )

        track.service = .jellyfin

        return track
    }
}
