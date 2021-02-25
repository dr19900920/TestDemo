import Foundation
import Action
import NSObject_Rx
import RxSwift
import RxCocoa

public protocol ViewControllerViewModelType {
    var lastData: Observable<Item?> { get }
    var data: Observable<String> { get }
    var refresh: Action<(), String> { get }

}

public class ViewControllerViewModel: NSObject, ViewControllerViewModelType {

    
    public typealias Networking = ViewControllerNetworkingType
    public let lastData: Observable<Item?>
    public let data: Observable<String>
    public let refresh: Action<(), String>
    
    private let _data = PublishSubject<String>()

    init(service: ItemServiceType, networking: Networking = ViewControllerNetworking()) {
        self.data = _data.asObservable()
        self.refresh = Action { networking.request() }
        self.lastData = service.lastData()
        super.init()

        refresh.elements.subscribe(_data).disposed(by: rx.disposeBag)
        
        refresh.underlyingError.subscribe { print($0) }.disposed(by: rx.disposeBag)
        
    }
    
}
