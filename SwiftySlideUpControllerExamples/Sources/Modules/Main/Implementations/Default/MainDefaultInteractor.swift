//
//  MainDefaultInteractor.swift
//  Main
//
//  Created by David Moreno on 17/4/19.
//

import Foundation

class MainDefaultInteractor {

    weak var presenter: MainPresenter?
    let commentsService: CommentsService
    
    init(commentsService: CommentsService) {
        self.commentsService = commentsService
    }
    
}

extension MainDefaultInteractor: MainInteractor {
    
    func comments() -> [Comment] {
        return commentsService.comments()
    }
    
}
