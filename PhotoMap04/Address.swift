import Foundation

struct AddressResponse: Codable {
    let response: AddressCollection
}

struct AddressCollection: Codable {
    let location: [Address]
}

struct Address: Codable, Identifiable {
    var id: UUID = UUID()
    let city: String
    let city_kana: String
    let town: String
    let town_kana: String
    let x: String
    let y: String
    let postal: String
    let distance: Double
    let prefecture: String
    private enum CodingKeys: String, CodingKey {
            case city, city_kana, town, town_kana, x, y, postal, distance, prefecture
        }
}
