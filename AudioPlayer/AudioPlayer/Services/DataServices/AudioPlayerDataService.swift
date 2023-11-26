import Foundation

protocol AudioPlayerServiceAble {
    func getDeviceData() async -> Result<Device.Response, RequestError>
    func getPlayerData() async -> Result<Player.Response, RequestError>
}

struct AudioPlayerDataService: HTTPClient, AudioPlayerServiceAble {
    var httpClient: HTTPClient?
    func getDeviceData() async -> Result<Device.Response, RequestError> {
        return await sendRequest(endpoint: PlayerEndPoint.getDeviceData, responseModel: Device.Response.self)
    }
    func getPlayerData() async -> Result<Player.Response, RequestError> {
        return await sendRequest(endpoint: PlayerEndPoint.getPlayerData, responseModel: Player.Response.self)
    }
}

