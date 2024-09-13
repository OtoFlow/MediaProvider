//
//  Artist+Jellyfin.swift
//  MediaProvider
//
//  Created by foyoodo on 2024/9/13.
//

import JellyfinAPI

extension Artist {

    static func convertFromJellyfin(
        server: JellyfinServer,
        item: BaseItemDto
    ) -> Artist {
        .init(
            id: item.id ?? "",
            name: item.name ?? "",
            artwork: .convertFromJellyfin(server: server, itemID: item.id ?? ""),
            isFavorite: item.userData?.isFavorite ?? false,
            overview: item.overview
        )
    }
}
