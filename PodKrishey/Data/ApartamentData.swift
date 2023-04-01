import Foundation

enum ApartamentData {
    static var apartaments = [
        HomeDataModel(imageNames: ["apart1", "apart2", "apart3"], shortDescription: "numberOfRooms: 1", fullDescription: .ApartamentsData.apart1, price: 11_000_000, phoneNumber: "+ 7 999 222 44 22", numberOfRooms: 1, isLiked: false),
        
        HomeDataModel(imageNames: ["apart4", "apart5", "apart6"], shortDescription: "numberOfRooms: 2", fullDescription: .ApartamentsData.apart2, price: 22_000_000, phoneNumber: "+ 7 999 222 44 22", numberOfRooms: 2, isLiked: false),
        
        HomeDataModel(imageNames: ["apart7", "apart8", "apart9"], shortDescription: "numberOfRooms: 3", fullDescription: .ApartamentsData.apart3, price: 113_000_000, phoneNumber: "+ 7 999 222 44 22", numberOfRooms: 3, isLiked: false),
        
        HomeDataModel(imageNames: ["apart10", "apart11", "apart12"], shortDescription: "numberOfRooms: 4", fullDescription: .ApartamentsData.apart5, price: 444_000_000, phoneNumber: "+ 7 999 222 44 22", numberOfRooms: 4, isLiked: false),
        
        HomeDataModel(imageNames: ["apart13", "apart14", "apart15"], shortDescription: "numberOfRooms: 5", fullDescription: .ApartamentsData.apart1, price: 555_000_000, phoneNumber: "+ 7 999 222 44 22", numberOfRooms: 5, isLiked: false),
        
        HomeDataModel(imageNames: ["apart3", "apart2", "apart1"], shortDescription: "numberOfRooms: 6", fullDescription: .ApartamentsData.apart2, price: 555_000_000, phoneNumber: "+ 7 999 222 44 22", numberOfRooms: 6, isLiked: false),
        
        HomeDataModel(imageNames: ["apart6", "apart5", "apart4"], shortDescription: "numberOfRooms: 7", fullDescription: .ApartamentsData.apart3, price: 444_000_000, phoneNumber: "+ 7 999 222 44 22", numberOfRooms: 7, isLiked: false),
        
        HomeDataModel(imageNames: ["apart9", "apart8", "apart7"], shortDescription: "numberOfRooms: 3", fullDescription: .ApartamentsData.apart4, price: 333_000_000, phoneNumber: "+ 7 999 222 44 22", numberOfRooms: 3, isLiked: false),
        
        HomeDataModel(imageNames: ["apart12", "apart11", "apart10"], shortDescription: "numberOfRooms: 4", fullDescription: .ApartamentsData.apart5, price: 222_000_000, phoneNumber: "+ 7 999 222 44 22", numberOfRooms: 4, isLiked: false),
        
        HomeDataModel(imageNames: ["apart15", "apart14", "apart13"], shortDescription: "numberOfRooms: 5", fullDescription: .ApartamentsData.apart1, price: 111_000_000, phoneNumber: "+ 7 999 222 44 22", numberOfRooms: 5, isLiked: false)
    ]
    
    static var likedApartaments: [HomeDataModel] = []
    
    static func apartamentWasLiked(apartament: HomeDataModel) {
        var i = 0
        while i < ApartamentData.apartaments.count {
            if ApartamentData.apartaments[i] == apartament {
                ApartamentData.apartaments[i].isLiked.toggle()
                break
            }
            i += 1
        }
    }
}
