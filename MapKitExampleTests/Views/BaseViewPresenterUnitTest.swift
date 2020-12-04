//
//  BaseViewPresenterUnitTest.swift
//
//  Created by Hasan on 17.10.20.
//

@testable import MapKitExample
import XCTest

class BaseViewPresenterUnitTest: XCTestCase {
    
    var presenter: BaseViewPresenter<BaseViewMock>!
    let viewMock = BaseViewMock()
    let shareAPIMock = MapKitExampleAPIMock()
    
    override func setUp() {
        super.setUp()
        
        presenter = BaseViewPresenter(view: viewMock,
                                      apiInstance: shareAPIMock)
    }
    
    override func tearDown() {
        super.tearDown()
    }
}
