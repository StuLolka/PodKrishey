import Foundation

struct ApartmentModel {
    let id: String
    let imageNames: [String]
    let shortDescription: String
    let fullDescription: String
    let price: Int
    let phoneNumber: String
    let numberOfRooms: Int
    var isFavorite: Bool
}


extension ApartmentModel: Equatable {
    static func == (lhs: ApartmentModel, rhs: ApartmentModel) -> Bool {
        return lhs.id == rhs.id
    }
}
