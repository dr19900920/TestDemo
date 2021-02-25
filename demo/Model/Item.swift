import Foundation
import RealmSwift

public class Item: Object {
    @objc dynamic var content: String = ""
    @objc dynamic var responseTime: Int = 0
    @objc dynamic var requestTime: Int = 0
    
}

