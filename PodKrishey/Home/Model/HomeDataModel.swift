import Foundation

struct HomeDataModel {
    let imageNames: [String]
    let shortDescription: String
    let fullDescription: String
    let price: Int
    let phoneNumber: String
    let numberOfRooms: Int
    var isLiked: Bool
}


extension HomeDataModel: Equatable {
    static func == (lhs: HomeDataModel, rhs: HomeDataModel) -> Bool {
        return lhs.imageNames == rhs.imageNames &&
        lhs.shortDescription == rhs.shortDescription &&
        lhs.fullDescription == rhs.fullDescription &&
        lhs.price == rhs.price &&
        lhs.phoneNumber == rhs.phoneNumber &&
        lhs.numberOfRooms == rhs.numberOfRooms
    }
}
