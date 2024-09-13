//
//  Album.swift
//  MediaProvider
//
//  Created by foyoodo on 2024/9/13.
//

import Foundation
import JellyfinAPI

public final class Album: Item {

    public let overview: String?

    public let genres: [String]?

    public let artists: [ReducedArtist]

    public let releaseDate: Date?

    public var recentPlayed: Date?

    public var playCount: Int

    public init(
        id: String,
        name: String,
        artwork: Artwork? = nil,
        isFavorite: Bool,
        overview: String?,
        genres: [String]? = nil,
        artists: [ReducedArtist] = [],
        releaseDate: Date? = nil,
        recentPlayed: Date? = nil,
        playCount: Int = 0
    ) {
        self.overview = overview
        self.genres = genres
        self.artists = artists
        self.releaseDate = releaseDate
        self.recentPlayed = recentPlayed
        self.playCount = playCount

        super.init(id: id, name: name, artwork: artwork, isFavorite: isFavorite)
    }

    private enum CodingKeys: String, CodingKey {
        case overview
        case genres
        case artists
        case releaseDate
        case recentPlayed
        case playCount
    }

    public required init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.overview = try container.decodeIfPresent(String.self, forKey: .overview)
        self.genres = try container.decodeIfPresent([String].self, forKey: .genres)
        self.artists = try container.decode([ReducedArtist].self, forKey: .artists)
        self.releaseDate = try container.decodeIfPresent(Date.self, forKey: .releaseDate)
        self.recentPlayed = try container.decodeIfPresent(Date.self, forKey: .recentPlayed)
        self.playCount = try container.decode(Int.self, forKey: .playCount)

        try super.init(from: decoder)
    }

    public override func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(self.overview, forKey: .overview)
        try container.encodeIfPresent(self.genres, forKey: .genres)
        try container.encode(self.artists, forKey: .artists)
        try container.encodeIfPresent(self.releaseDate, forKey: .releaseDate)
        try container.encodeIfPresent(self.recentPlayed, forKey: .recentPlayed)
        try container.encode(self.playCount, forKey: .playCount)

        try super.encode(to: encoder)
    }
}

