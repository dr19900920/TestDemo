import Foundation
import RxSwift
import RealmSwift

enum ServiceError: Error {
    case creationFailed
    case updateFailed
}

protocol ItemServiceType {
    
    @discardableResult
    func create(by startTime: Int) -> Observable<Item>
    @discardableResult
    func update(by startTime: Int, endTime: Int, content: String) -> Observable<Item>
    
    func datas() -> Observable<Results<Item>> 
    
    func lastData() -> Observable<Item?>
}
