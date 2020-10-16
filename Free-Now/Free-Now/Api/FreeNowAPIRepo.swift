//
//  FreeNowAPIRepo.swift
//  Free-Now
//
//  Created by Hasan on 16.10.20.
//

import Alamofire
import RxSwift

class FreeNowAPIRepo: FreeNowAPI {
    
    // SINGLETON
    static let sharedInstance = FreeNowAPIRepo()
    
    private init() {}
    
    static let BASE_URL = "https://poi-api.mytaxi.com/PoiService/poi/v1?"
    static let DEFAULT_PAGE_SIZE = 20
    static let UNLIMITED_PAGE_SIZE = 10000
    
    private func getAuthenticatedHeader() -> HTTPHeaders {
        let headers: HTTPHeaders = [
            "Authorization": "Token",
            "Accept-Language": Locale.current.languageCode ?? "",
            "Accept": "application/json",
            "Content-Type": "application/json"
        ]
        return headers
    }
    
    private func createSingleRequest<T: Decodable>(url: String, method: HTTPMethod, parameters: Parameters? = nil,
                                                  headers: HTTPHeaders? = nil) -> Single<T> {
        let reqHeaders = headers ?? getAuthenticatedHeader()
        let encoding: ParameterEncoding = (method == .post || method == .put || method == .patch)
            ? JSONEncoding.default : URLEncoding.default
        return Single.create { single in
            let request = AF.request(url, method: method, parameters: parameters,
                                     encoding: encoding, headers: reqHeaders)
                .validate()
                .responseJSON { responseJSON in
                    switch responseJSON.result {
                    case .success:
                        guard let data = responseJSON.data else { return }
                        do {
                            let decoder = JSONDecoder()
                            let loginRequest = try decoder.decode(T.self, from: data)
                            single(.success(loginRequest))
                        } catch let error {
                            print(error)
                        }
                    case .failure(let error):
                        single(.error(error.getAsAPIError(responseData: responseJSON.data)))
                    }
                }
            return Disposables.create { request.cancel() }
        }
    }

    // TODO: There is also pagination property, we can use it for paging system.
    func getVehicleList(page: Int = 1, searchString: String) -> Single<Vehicle> {
        // TODO: We can use the searchString to search for vehicles. Just The Api should be updated
        // let parameters: Parameters = ["page": page, "pagesize": pageSize]
        let hamburgLocation = "p2Lat=53.394655&p1Lon=9.757589&p1Lat=53.694865&p2Lon=10.099891"
        return createSingleRequest(url: FreeNowAPIRepo.BASE_URL + hamburgLocation, method: .get)
    }
}
