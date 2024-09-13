//
//  Paths+Filter.swift
//  MediaProvider
//
//  Created by foyoodo on 2024/9/13.
//

import JellyfinAPI

extension Paths.GetItemsParameters {

    mutating func withFilter(_ filter: ItemFilter?) -> Self {
        guard let filter else {
            return self
        }

        switch filter {
        case .recentlyAdded:
            sortBy = [.dateLastContentAdded, .dateCreated]
            sortOrder = [.descending]
        case .recentlyPlayed:
            isPlayed = true
            sortBy = [.datePlayed]
            sortOrder = [.descending]
        case .frequentlyPlayed:
            isPlayed = true
            sortBy = [.playCount]
            sortOrder = [.descending]
        }

        return self
    }
}
