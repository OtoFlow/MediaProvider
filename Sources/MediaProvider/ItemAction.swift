//
//  ItemAction.swift
//  MediaProvider
//
//  Created by foyoodo on 2024/9/13.
//

public enum ItemAction: CustomStringConvertible {

    case like
    case dislike

    public var description: String {
        switch self {
        case .like: "Like"
        case .dislike: "Dislike"
        }
    }
}

extension ItemAction {

    public enum Status {
        case success
        case failure
    }
}
