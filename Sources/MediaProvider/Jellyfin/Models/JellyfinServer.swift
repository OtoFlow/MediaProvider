//
//  JellyfinServer.swift
//  MediaProvider
//
//  Created by foyoodo on 2024/9/13.
//

import Foundation

public struct JellyfinServer: Hashable, Identifiable {

    public let urls: Set<URL>
    public let currentURL: URL
    public let name: String
    public let id: String
    public let os: String
    public let version: String
    public let userIDs: [String]
    public let currentUserID: String

    public init(
        urls: Set<URL>,
        currentURL: URL,
        name: String,
        id: String,
        os: String,
        version: String,
        usersIDs: [String],
        currentUserID: String
    ) {
        self.urls = urls
        self.currentURL = currentURL
        self.name = name
        self.id = id
        self.os = os
        self.version = version
        self.userIDs = usersIDs
        self.currentUserID = currentUserID
    }
}
