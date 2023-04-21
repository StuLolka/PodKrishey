//import Foundation
//
//enum ApartmentData {
//    static var apartaments = [
//        
//        HomeDataModel(imageNames: ["apart10", "apart11", "apart12"], shortDescription: "numberOfRooms: 4", fullDescription: .ApartmentsData.apart5, price: 444_000_000, phoneNumber: "+ 7 999 222 44 22", numberOfRooms: 4, isLiked: false),
//        
//        HomeDataModel(imageNames: ["apart13", "apart14", "apart15"], shortDescription: "numberOfRooms: 5", fullDescription: .ApartmentsData.apart1, price: 555_000_000, phoneNumber: "+ 7 999 222 44 22", numberOfRooms: 5, isLiked: false),
//        
//        HomeDataModel(imageNames: ["apart3", "apart2", "apart1"], shortDescription: "numberOfRooms: 6", fullDescription: .ApartmentsData.apart2, price: 555_000_000, phoneNumber: "+ 7 999 222 44 22", numberOfRooms: 6, isLiked: false),
//        
//        HomeDataModel(imageNames: ["apart6", "apart5", "apart4"], shortDescription: "numberOfRooms: 7", fullDescription: .ApartmentsData.apart3, price: 444_000_000, phoneNumber: "+ 7 999 222 44 22", numberOfRooms: 7, isLiked: false),
//        
//        HomeDataModel(imageNames: ["apart9", "apart8", "apart7"], shortDescription: "numberOfRooms: 3", fullDescription: .ApartmentsData.apart4, price: 333_000_000, phoneNumber: "+ 7 999 222 44 22", numberOfRooms: 3, isLiked: false),
//        
//        HomeDataModel(imageNames: ["apart12", "apart11", "apart10"], shortDescription: "numberOfRooms: 4", fullDescription: .ApartmentsData.apart5, price: 222_000_000, phoneNumber: "+ 7 999 222 44 22", numberOfRooms: 4, isLiked: false),
//        
//        HomeDataModel(imageNames: ["apart15", "apart14", "apart13"], shortDescription: "numberOfRooms: 5", fullDescription: .ApartmentsData.apart1, price: 111_000_000, phoneNumber: "+ 7 999 222 44 22", numberOfRooms: 5, isLiked: false)
//    ]
//    
//    static var likedApartaments: [HomeDataModel] = []
//    
//    static func apartamentWasLiked(apartament: HomeDataModel) {
//        var i = 0
//        while i < ApartmentData.apartaments.count {
//            if ApartmentData.apartaments[i] == apartament {
//                ApartmentData.apartaments[i].isLiked.toggle()
//                break
//            }
//            i += 1
//        }
//    }
//}
