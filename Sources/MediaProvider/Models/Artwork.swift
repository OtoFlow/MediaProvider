//
//  Artwork.swift
//  MediaProvider
//
//  Created by foyoodo on 2024/9/13.
//

import Foundation

extension Item {

    public final class Artwork: Codable, Equatable {

        public var url: URL

        public init(url: URL) {
            self.url = url
        }

        public static func == (lhs: Artwork, rhs: Artwork) -> Bool {
            lhs.url == rhs.url
        }
    }
}
