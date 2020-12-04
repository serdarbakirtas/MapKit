//
//  MapKitExampleAPIRepo.swift
//
//  Created by Hasan on 16.10.20.
//

import Alamofire
import RxSwift

class MapKitExampleAPIRepo: MapKitExampleAPI {
    
    // SINGLETON
    static let sharedInstance = MapKitExampleAPIRepo()
    
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

    func getVehicleList() -> Single<Vehicle> {
        let hamburgLocation = "p2Lat=53.394655&p1Lon=9.757589&p1Lat=53.694865&p2Lon=10.099891"
        return createSingleRequest(url: MapKitExampleAPIRepo.BASE_URL + hamburgLocation, method: .get)
    }
    
    func getVehicleListWithLocation(p2latitude: Double, p1longitude: Double, p1latitude: Double, p2longitude: Double) -> Single<Vehicle> {
        let boundsLocation = "p2Lat=" + "\(p2latitude)" + "&p1Lon=" + "\(p1longitude)" + "&p1Lat=" + "\(p1latitude)" + "&p2Lon=" + "\(p2longitude)"
        return createSingleRequest(url: MapKitExampleAPIRepo.BASE_URL + boundsLocation, method: .get)
    }
}
