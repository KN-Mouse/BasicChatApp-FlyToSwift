//
//  RecentMessage.swift
//  Fly To
//
//  Created by Nguyen Khang on 28/10/25.
//

import Foundation

struct RecentMessage: Identifiable, Hashable {
    var id: String { message.id }
    let message: Message
    let user: User
}
