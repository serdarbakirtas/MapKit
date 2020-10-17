//
//  BaseViewPresenterUnitTest.swift
//  Free-NowTests
//
//  Created by Hasan on 17.10.20.
//

@testable import Free_Now
import XCTest

class BaseViewPresenterUnitTest: XCTestCase {
    
    var presenter: BaseViewPresenter<BaseViewMock>!
    let viewMock = BaseViewMock()
    let shareAPIMock = FreeNowAPIMock()
    
    override func setUp() {
        super.setUp()
        
        presenter = BaseViewPresenter(view: viewMock,
                                      apiInstance: shareAPIMock)
    }
    
    override func tearDown() {
        super.tearDown()
    }
}
