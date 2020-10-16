//
//  RxObservableExtension.swift
//  Free-Now
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
    
    func doOnSuccess(page: Int, section: Int = 0,
                     _ method: @escaping (Int, Int, Element) -> Void) -> PrimitiveSequence {
        return self.do(onSuccess: { element in method(page, section, element) })
    }
    
    func doOnFirstPageSuccess(page: Int, _ method: @escaping () -> Void) -> PrimitiveSequence {
        if page == 1 {
            return self.do(onSuccess: { _ in method() })
        }
        return self
    }
    
    func doOnFirstPageSuccess(page: Int, section: Int, _ method: @escaping (Int) -> Void) -> PrimitiveSequence {
        if page == 1 {
            return self.do(onSuccess: { _ in method(section) })
        }
        return self
    }
}
