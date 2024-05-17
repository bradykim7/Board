//
//  BoardVeiwModel.swift
//  Board
//
//  Created by min seok Kim on 5/17/24.
//

import Foundation
import Moya
import RxSwift
import RxCocoa

class BoardViewModel: ViewModel<Board, BoardService> {
    
    func loadBoard(boardId: Int) {
        loadData(request: .fetchBoard(boardId: boardId), sampleData: BoardService.fetchBoard(boardId: boardId).sampleData)
    }
    
    func loadBoards() {
        loadData(request: .fetchBoards, sampleData: BoardService.fetchBoards.sampleData)
    }
}
