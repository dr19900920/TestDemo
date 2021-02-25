import Foundation
import Alamofire

public enum ViewControllerAPI: BaseAPI {
    case apiGithub
}

extension ViewControllerAPI {
    public var path: String {
        switch self {
        case .apiGithub:
            return ""
        }
    }
    
    public var parameters: Parameters {
        switch self {
        case .apiGithub:
            return [:]
        }
    }
    
    public var method: HTTPMethod {
        switch self {
        case .apiGithub:
            return .get
        }
    }
    
    public var parameterEncoding: ParameterEncoding {
        return JSONEncoding.default
    }
}
