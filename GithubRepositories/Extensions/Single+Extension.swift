//
//  Single+Extension.swift
//  GihubRepositoriesDafleCardoso
//
//  Created by Dafle Cardoso on 16/05/20.
//  Copyright © 2020 Dafle Cardoso. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Moya

extension PrimitiveSequence where Trait == SingleTrait {
    
    func defaultLoading(_ isloading: PublishSubject<Bool>) -> PrimitiveSequence<SingleTrait, Element> {
        return self.do(onSuccess: { _ in
            isloading.onNext(false)
        }, onError: { _ in
            isloading.onNext(false)
        }, onSubscribe: {
            isloading.onNext(true)
        })
    }
}

public extension PrimitiveSequence where Trait == SingleTrait, Element == Response {
    
    func mapDefault<D: Decodable>(_ type: D.Type, atKeyPath keyPath: String? = nil) -> Single<D> {
        return flatMap { .just(try $0.map(type, atKeyPath: keyPath, using: JSONDecoder.default,
                                          failsOnEmptyData: true)) }
    }
}
