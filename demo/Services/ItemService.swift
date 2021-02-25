import Foundation
import RealmSwift
import RxSwift
import RxRealm

struct ItemService: ItemServiceType {

    init() {
        do {
            _ = try Realm()
        } catch _ {
        }
    }
    
    private func withRealm<T>(_ operation: String, action: (Realm) throws -> T) -> T? {
        do {
            let realm = try Realm()
            return try action(realm)
        } catch let err {
            print("Failed \(operation) realm with error: \(err)")
            return nil
        }
    }
    
    @discardableResult
    func create(by startTime: Int) -> Observable<Item> {
        let result = withRealm("creating") { realm -> Observable<Item> in
            let item = Item()
            item.requestTime = startTime
            try realm.write {
                realm.add(item)
            }
            return .just(item)
        }
        return result ?? .error(ServiceError.creationFailed)
    }
    
    @discardableResult
    func update(by startTime: Int, endTime: Int, content: String) -> Observable<Item> {
        let result = withRealm("updating content") { realm -> Observable<Item> in
            let items = realm.objects(Item.self)
            guard let item = items.filter({$0.requestTime == startTime}).first else {
                return .just(Item())
            }
            try realm.write {
                item.content = content
                let time = Date().timeIntervalSince1970
                item.responseTime = Int(time)
            }
            return .just(item)
        }
        return result ?? .error(ServiceError.updateFailed)
        
    }
    
    
    func datas() -> Observable<Results<Item>> {
        let result = withRealm("getting datas") { realm -> Observable<Results<Item>> in
            let items = realm.objects(Item.self)
            return Observable.collection(from: items)
        }
        return result ?? .empty()
    }
    
    func lastData() -> Observable<Item?> {
        let result = withRealm("lastItem") { (realm) -> Observable<Item?> in
            let item = realm.objects(Item.self).filter({$0.content != "请求失败"}).sorted(by: {$0.requestTime < $1.requestTime}).last
            return .just(item)
        }
        return result ?? .empty()
    }
    
}
