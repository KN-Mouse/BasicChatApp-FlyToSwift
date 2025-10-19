//
//  MessageCellBubble.swift
//  Fly To
//
//  Created by Nguyen Khang on 14/10/25.
//

import SwiftUI

struct MessageCellBubble: Shape {
    let fromCurrentUser: Bool
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect,
                               byRoundingCorners: [.topLeft, .topRight, fromCurrentUser ? .bottomLeft : .bottomRight ],
                               cornerRadii: CGSize(width: 16, height: 16))
        
        return(Path(path.cgPath))
    }
}

#Preview {
    MessageCellBubble(fromCurrentUser: true)
}
