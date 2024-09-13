//
//  JellyfinUser.swift
//  MediaProvider
//
//  Created by foyoodo on 2024/9/13.
//

import Foundation

public struct JellyfinUser: Hashable, Identifiable {

    public let accessToken: String
    public let id: String
    public let serverID: String
    public let username: String

    public init(
        accessToken: String,
        id: String,
        serverID: String,
        username: String
    ) {
        self.accessToken = accessToken
        self.id = id
        self.serverID = serverID
        self.username = username
    }
}
