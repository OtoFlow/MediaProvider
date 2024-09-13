//
//  Enums.swift
//  MediaProvider
//
//  Created by foyoodo on 2024/9/13.
//

public enum ItemFilter: CustomStringConvertible {

    case recentlyAdded
    case recentlyPlayed
    case frequentlyPlayed

    public var description: String {
        switch self {
        case .recentlyAdded:
            return "Recently Added"
        case .recentlyPlayed:
            return "Recently Played"
        case .frequentlyPlayed:
            return "Frequently Played"
        }
    }
}

public enum ItemType: CustomStringConvertible {

    case album
    case music
    case musicVideo

    public var description: String {
        switch self {
        case .album:
            "Albums"
        case .music:
            "Music"
        case .musicVideo:
            "Music Video"
        }
    }
}
