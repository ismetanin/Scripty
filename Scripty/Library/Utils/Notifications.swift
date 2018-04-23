//
//  Notifications.swift
//  Scripty
//
//  Created by Ivan Smetanin on 24/04/2018.
//  Copyright © 2018 Ivan Smetanin. All rights reserved.
//

struct Notifications {

    private init() {}

    public static var shared = Notifications()

    var commandsListChanged: BaseEvent<Void> = BaseEvent<Void>()

}
