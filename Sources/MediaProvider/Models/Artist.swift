//
//  Artist.swift
//  MediaProvider
//
//  Created by foyoodo on 2024/9/13.
//

import Foundation
import JellyfinAPI

public final class Artist: Item {

    public let overview: String?

    public init(
        id: String,
        name: String,
        artwork: Artwork? = nil,
        isFavorite: Bool = false,
        overview: String? = nil
    ) {
        self.overview = overview

        super.init(id: id, name: name, artwork: artwork, isFavorite: isFavorite)
    }

    private enum CodingKeys: String, CodingKey {
        case overview
    }

    public required init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.overview = try container.decodeIfPresent(String.self, forKey: .overview)

        try super.init(from: decoder)
    }

    public override func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(self.overview, forKey: .overview)

        try super.encode(to: encoder)
    }
}

extension Artist {

    static func reduced(_ artist: Item.ReducedArtist) -> Artist {
        Artist(id: artist.id, name: artist.name)
    }
}
