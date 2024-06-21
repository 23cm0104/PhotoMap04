import Foundation

class AddressFetcher: ObservableObject {
    @Published var addressList: [Address] = []
    
    func fetchData(longitude: Double, latitude: Double) async
    throws {
        guard let url = URL(string: "https://geoapi.heartrails.com/api/json?method=searchByGeoLocation&x=\(longitude)&y=\(latitude)") else { throw FtetchError.badJSON }
        
        let (data, response) = try await URLSession.shared.data(for: URLRequest(url: url))
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else { throw FtetchError.badRequest }
        
        Task { @MainActor in
            addressList = try JSONDecoder().decode(AddressResponse.self, from: data).response.location
        }
    }
}

enum FtetchError: Error {
    case badRequest
    case badJSON
}
