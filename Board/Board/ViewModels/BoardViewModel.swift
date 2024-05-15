//
//  BoardViewModel.swift
//  Board
//
//  Created by min seok Kim on 5/4/24.
//

import Foundation
import Moya
import RxSwift
import RxCocoa

class BoardViewModel {
    
    private let provider = MoyaProvider<BoardService>()
//    private let provider = MoyaProvider<BoardService>(plugins: [NetworkLoggerPlugin()]) // 디버깅하고 싶을때 plugin 추가

    private let disposeBag = DisposeBag()

    private var BoardRealy: BehaviorRelay<[Board]> = BehaviorRelay<[Board]>(value: [])
    private var errorMessageSubject: PublishSubject<String?> = PublishSubject<String?>()
    
    var BoardObservable: Observable<[Board]> {
        return BoardRealy.asObservable()
    }
    
    var errorMessageObservable: Observable<String?> {
        return errorMessageSubject.asObservable()
    }
    
    func loadBoard() {
        provider.rx.request(.getBoard)
           .observe(on: MainScheduler.instance)
           .subscribe(onSuccess: { [weak self] response in
               self?.handleSuccess(response)
           }, onFailure: { [weak self] error in
               self?.handleError(error)
               self?.loadSampleData()
           })
           .disposed(by: disposeBag)
    }

    private func handleSuccess(_ response: Response) {
            do {
                let board = try JSONDecoder().decode(Board.self, from: response.data)
                BoardRealy.accept([board])
            } catch {
                print("Decoded boards: \(error)")
                errorMessageSubject.onNext("Error decoding response: \(error)")
                loadSampleData()
            }
    }

    private func handleError(_ error: Error) {
        errorMessageSubject.onNext("Network or decoding error: \(error.localizedDescription)")
    }

    private func loadSampleData() {
        do {
            let sampleData = try JSONDecoder().decode([Board].self, from: BoardService.getBoard.sampleData)
            BoardRealy.accept(sampleData)
        } catch {
            errorMessageSubject.onNext("Error decoding sample data: \(error)")
        }
    }
}

