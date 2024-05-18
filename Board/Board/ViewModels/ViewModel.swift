//
//  ViewModelImpl.swift
//  Board
//
//  Created by min seok Kim on 5/17/24.
//
import Foundation
import Moya
import RxSwift
import RxCocoa

class ViewModel<T: Decodable, Service: TargetType> {
    
    private let disposeBag = DisposeBag()
    private let provider = MoyaProvider<Service>(plugins: [NetworkLoggerPlugin(configuration: NetworkLoggerPlugin.Configuration(logOptions: .verbose))])
//    private let provider = MoyaProvider<Service>()

    private var dataRelay: BehaviorRelay<[T]> = BehaviorRelay<[T]>(value: [])
    private var errorMessageSubject: PublishSubject<String?> = PublishSubject<String?>()
    
    var dataObservable: Observable<[T]> {
        return dataRelay.asObservable()
    }
    
    var errorMessageObservable: Observable<String?> {
        return errorMessageSubject.asObservable()
    }
    
    func loadData(request: Service, sampleData: Data) {
            provider.rx.request(request)
               .observe(on: MainScheduler.instance)
               .subscribe(onSuccess: { [weak self] response in
                   self?.handleSuccess(response)
               }, onFailure: { [weak self] error in
                   self?.handleError(error)
                   self?.loadSampleData(sampleData: sampleData)
               })
               .disposed(by: disposeBag)
    }
    
    
    private func handleSuccess(_ response: Response) {
        do {
            let data = try JSONDecoder().decode(ApiResponse<T>.self, from: response.data)
            dataRelay.accept(data.value)
        } catch {
            print("Decoded data: \(error)")
            errorMessageSubject.onNext("Error decoding response: \(error)")
        }
    }

    private func handleError(_ error: Error) {
        errorMessageSubject.onNext("Network or decoding error: \(error.localizedDescription)")
    }

    private func loadSampleData(sampleData: Data) {
        do {
            let sampleData = try JSONDecoder().decode([T].self, from: sampleData)
            dataRelay.accept(sampleData)
        } catch {
            errorMessageSubject.onNext("Error decoding sample data: \(error)")
        }
    }
}
