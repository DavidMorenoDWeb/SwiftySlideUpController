//
//  CommentsService.swift
//  SwiftySlideUpControllerExamples
//
//  Created by David Moreno Lora on 23/04/2019.
//  Copyright © 2019 David Moreno Lora. All rights reserved.
//

import Foundation

class CommentsService {
    
    public func comments() -> [Comment] {
        
        let comments = [Comment(user: User(username: "John"), text: "Cool!"),
                        Comment(user: User(username: "Marie"), text: "These are graceful and delightful mate"),
                        Comment(user: User(username: "Peter Petrelli"), text: "This colours has navigated right into my heart."),
                        Comment(user: User(username: "Francesc"), text: "I think clients would love this. Such colours, many background, so magnificent. Blur, shade, illustration, atmosphere – revolutionary m8."), Comment(user: User(username: "Sarah"), text: "Mission accomplished. It's fabulous!!"),
                        Comment(user: User(username: "David"), text: "Truly minimal!")]
        return comments
    }
}
