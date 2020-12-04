//
//  RxObservableExtension.swift
//
//  Created by Hasan on 16.10.20.
//

import RxSwift

extension PrimitiveSequence {
    
    func applySchedulers() -> PrimitiveSequence {
        return self.subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
                   .observeOn(MainScheduler.instance)
    }
}

extension PrimitiveSequence where Trait == SingleTrait {
    
    func showFullScreenActivityIndicator(view: BaseView?) -> PrimitiveSequence {
        return self.do(onSubscribe: { view?.showFullScreenActivityIndicator(isShown: true) },
                       onDispose: { view?.showFullScreenActivityIndicator(isShown: false) })
    }
}
