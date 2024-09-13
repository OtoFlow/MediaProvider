//
//  Track.swift
//  MediaProvider
//
//  Created by foyoodo on 2024/9/13.
//

import Foundation
import JellyfinAPI

public final class Track: Item {

    public let type: MediaType

    public let album: Album

    public let artists: [ReducedArtist]

    public let index: Index

    public let duration: TimeInterval

    public let releaseDate: Date?

    public let recentPlayed: Date?

    public let playCount: Int

    public init(
        id: String,
        name: String,
        artwork: Artwork? = nil,
        isFavorite: Bool,
        type: MediaType,
        album: Album,
        artists: [ReducedArtist] = [],
        index: Index,
        duration: TimeInterval,
        releaseDate: Date?,
        recentPlayed: Date? = nil,
        playCount: Int = 0
    ) {
        self.type = type
        self.album = album
        self.artists = artists
        self.index = index
        self.duration = duration
        self.releaseDate = releaseDate
        self.recentPlayed = recentPlayed
        self.playCount = playCount

        super.init(id: id, name: name, artwork: artwork, isFavorite: isFavorite)
    }

    private enum CodingKeys: String, CodingKey {
        case type
        case album
        case artists
        case index
        case duration
        case releaseDate
        case recentPlayed
        case playCount
    }

    public required init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.type = try container.decode(MediaType.self, forKey: .type)
        self.album = try container.decode(Album.self, forKey: .album)
        self.artists = try container.decode([ReducedArtist].self, forKey: .artists)
        self.index = try container.decode(Index.self, forKey: .index)
        self.duration = try container.decode(TimeInterval.self, forKey: .duration)
        self.releaseDate = try container.decodeIfPresent(Date.self, forKey: .releaseDate)
        self.recentPlayed = try container.decodeIfPresent(Date.self, forKey: .recentPlayed)
        self.playCount = try container.decode(Int.self, forKey: .playCount)

        try super.init(from: decoder)
    }

    public override func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(self.type, forKey: .type)
        try container.encode(self.album, forKey: .album)
        try container.encode(self.artists, forKey: .artists)
        try container.encode(self.index, forKey: .index)
        try container.encode(self.duration, forKey: .duration)
        try container.encodeIfPresent(self.releaseDate, forKey: .releaseDate)
        try container.encodeIfPresent(self.recentPlayed, forKey: .recentPlayed)
        try container.encode(self.playCount, forKey: .playCount)

        try super.encode(to: encoder)
    }
}

extension Track {

    public enum MediaType: Codable {
        case audio
        case video
    }

    public struct Album: Codable {
        let id: String
        let name: String
    }

    public struct Index: Comparable, Codable {

        let idx: Int?
        let disk: Int

        public static func < (lhs: Track.Index, rhs: Track.Index) -> Bool {
            if lhs.disk == rhs.disk {
                if let ldx = lhs.idx, let rdx = rhs.idx {
                    return ldx < rdx
                }
                return lhs.idx == nil
            } else {
                return lhs.disk < rhs.disk
            }
        }
    }
}
