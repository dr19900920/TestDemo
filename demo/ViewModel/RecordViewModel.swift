import Foundation
import Action
import NSObject_Rx
import RxSwift
import RxCocoa
import RealmSwift

public protocol RecordViewModelType {
    var dataSource: Observable<Results<Item>> { get }

}

public class RecordViewModel: NSObject, RecordViewModelType {
    public let dataSource: Observable<Results<Item>>
    
    init(service: ItemServiceType) {
        self.dataSource = service.datas().asObservable()
        super.init()
    }

}
