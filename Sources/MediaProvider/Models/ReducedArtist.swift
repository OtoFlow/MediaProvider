//
//  ReducedArtist.swift
//  MediaProvider
//
//  Created by foyoodo on 2024/9/13.
//

extension Item {

    public struct ReducedArtist: Identifiable, Codable {

        public let id: String

        public let name: String
    }
}

extension Array where Element == Item.ReducedArtist {

    public func toString(splitBy separator: String = ", ", limit: Int? = nil) -> String {
        let slice: any Sequence<Item.ReducedArtist>
        if let limit { slice = prefix(limit) } else { slice = self }
        return slice.map(\.name).enumerated().reduce("") { partialResult, info in
            partialResult + (info.offset > 0 ? separator : "") + info.element
        }
    }
}
