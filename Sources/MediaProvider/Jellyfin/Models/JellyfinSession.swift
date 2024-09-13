//
//  JellyfinSession.swift
//  MediaProvider
//
//  Created by foyoodo on 2024/9/13.
//

import Foundation
import JellyfinAPI

public final class JellyfinSession {

    public let configuration: Configuration

    public let client: JellyfinClient
    public let server: JellyfinServer
    public let user: JellyfinUser

    public let authenticated: Bool

    public init(
        configuration: Configuration,
        server: JellyfinServer,
        user: JellyfinUser,
        authenticated: Bool
    ) {
        self.configuration = configuration
        self.server = server
        self.user = user
        self.authenticated = authenticated

        let client = JellyfinClient(
            configuration: .jellyfinConfiguration(configuration, url: server.currentURL),
            accessToken: user.accessToken
        )

        self.client = client
    }
}

extension JellyfinSession {

    public struct Configuration {

        public let client: String

        public let deviceName: String

        public let deviceID: String

        public let version: String
    }
}

extension JellyfinClient.Configuration {

    fileprivate static func jellyfinConfiguration(_ configuration: JellyfinSession.Configuration, url: URL) -> Self  {
        .init(
            url: url,
            client: configuration.client,
            deviceName: configuration.deviceName,
            deviceID: configuration.deviceID,
            version: configuration.version
        )
    }
}
