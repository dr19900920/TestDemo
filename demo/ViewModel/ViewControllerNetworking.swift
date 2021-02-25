import Foundation
import Alamofire
import RxSwift

public protocol ViewControllerNetworkingType {
    func request() -> Observable<String>
}

public struct ViewControllerNetworking: ViewControllerNetworkingType {
    private let networking = Environment.current.networking(ViewControllerAPI.self)
    
    public init() { }
    
    public func request() -> Observable<String> {
        let service = ItemService()
        let startTime = Int(Date().timeIntervalSince1970)
        service.create(by: startTime)
        return networking.requestData(.apiGithub)
            .asObservable()
            .flatMap { (data) -> Observable<String> in
                let endTime = Int(Date().timeIntervalSince1970)
                guard let str = String(data: data, encoding: String.Encoding.utf8) else {
                    service.update(by: startTime, endTime: endTime, content: "解析失败")
                    return Observable.just("解析失败")
                }
                service.update(by: startTime, endTime: endTime, content: str)
                return Observable.just(str)
            }
    }
}
