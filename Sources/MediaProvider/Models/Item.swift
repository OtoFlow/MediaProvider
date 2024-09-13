//
//  Item.swift
//  MediaProvider
//
//  Created by foyoodo on 2024/9/13.
//

import Foundation

public class Item: Identifiable, Codable {

    public let id: String

    public let name: String

    public var artwork: Artwork?

    public var isFavorite: Bool

    public var service: Service? = nil

    public init(
        id: String,
        name: String,
        artwork: Artwork? = nil,
        isFavorite: Bool
    ) {
        self.id = id
        self.name = name
        self.artwork = artwork
        self.isFavorite = isFavorite
    }

    private enum CodingKeys: CodingKey {
        case id
        case name
        case artwork
        case isFavorite
        case service
    }

    public required init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.id = try container.decode(String.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.artwork = try container.decodeIfPresent(Artwork.self, forKey: .artwork)
        self.isFavorite = try container.decode(Bool.self, forKey: .isFavorite)
        self.service = try container.decodeIfPresent(Service.self, forKey: .service)
    }

    public func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(self.id, forKey: .id)
        try container.encode(self.name, forKey: .name)
        try container.encodeIfPresent(self.artwork, forKey: .artwork)
        try container.encode(self.isFavorite, forKey: .isFavorite)
        try container.encodeIfPresent(self.service, forKey: .service)
    }
}

extension Item: Hashable {

    public static func == (lhs: Item, rhs: Item) -> Bool {
        lhs.id == rhs.id
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

// MARK: - Service

extension Item {

    public enum Service: Codable {
        case jellyfin
    }
}
