
import Foundation

enum PlayerEndPoint {
    case getDeviceData
    case getPlayerData
}

extension PlayerEndPoint: Endpoint {
    var path: String {
        switch self {
        case .getDeviceData:
            return "/heos_app/code_test/devices.json"
        case .getPlayerData:
            return "/heos_app/code_test/nowplaying.json"
        }
    }
    
    var method: RequestMethod {
        switch self {
        case .getDeviceData:
            return .get
        case .getPlayerData:
            return .get
        }
    }
    
    var header: [String: String]? {
        switch self {
        case .getDeviceData, .getPlayerData:
            return [
                "Content-Type": "application/json;charset=utf-8"
            ]
        }
    }
    
    var body: [String: String]? {
        switch self {
        case .getDeviceData, .getPlayerData:
            return nil
        }
    }
}
