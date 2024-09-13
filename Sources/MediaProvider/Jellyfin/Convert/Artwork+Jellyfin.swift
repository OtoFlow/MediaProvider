//
//  Artwork+Jellyfin.swift
//  MediaProvider
//
//  Created by foyoodo on 2024/9/13.
//

import Foundation

extension Item.Artwork {

    static func convertFromJellyfin(
        server: JellyfinServer,
        itemID: String
    ) -> Item.Artwork {

        let url = server.currentURL
            .appending(path: "Items")
            .appending(path: itemID)
            .appending(path: "Images")
            .appending(path: "Primary")

        return .init(url: url)
    }
}
