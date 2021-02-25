import UIKit
import Action
import NSObject_Rx
import RxCocoa
import RxSwift

public func applyWeakly<T>(_ instance: T, _ function: @escaping (T) -> () -> ())
    -> () -> () where T: AnyObject
{
    return { [weak instance] in
        guard let instance = instance else { return }
        function(instance)()
    }
}

public func applyWeakly<T, A>(_ instance: T, _ function: @escaping (T) -> (A) -> ())
    -> (A) -> () where T: AnyObject
{
    return { [weak instance] a in
        guard let instance = instance else { return }
        function(instance)(a)
    }
}

class ViewController: UIViewController {
    
    @IBOutlet weak var textView: UITextView!
    public var viewModel: ViewControllerViewModelType!

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = ViewControllerViewModel(service: ItemService())
        Observable<Int>.timer(5, period: 5, scheduler: MainScheduler.instance).subscribe {
            [weak self] (e) in
            guard let strongSelf = self else {
                return
            }
            strongSelf.viewModel.refresh.execute()
        }.disposed(by: rx.disposeBag)

        viewModel.lastData.map({$0?.content}).bind(to: textView.rx.text).disposed(by: rx.disposeBag)
        viewModel.data.bind(to: textView.rx.text).disposed(by: rx.disposeBag)
        
    }
}
