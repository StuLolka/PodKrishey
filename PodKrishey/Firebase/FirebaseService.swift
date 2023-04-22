import Firebase
import FirebaseFirestore

enum ApartmentField: String {
    case id
    case shortDescription
    case fullDescription
    case numberOfRooms
    case phoneNumber
    case isFavorite
    case price
    case imageNames
}

enum FirebaseError: Error {
    case pasrseError
    case getDocumentsError(String)
}

extension FirebaseError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .pasrseError:
            return NSLocalizedString("Some of the fields does not exist", comment: "FirebaseError")
        case .getDocumentsError(let error):
            return NSLocalizedString("Firebase error: \(error)", comment: "FirebaseError")
        }
    }
}

class FirebaseService {
    private var documents: [String : String] = [:]
    
    static let shared = FirebaseService()
    
    private let db = Firestore.firestore()
    private let collection = "apartments"
    
    private var apartments: [ApartmentModel] = []
    private init() {}
    
    func downloadApartments(handler: @escaping (Result<[ApartmentModel], FirebaseError>) -> ()) {
        db.collection(collection).getDocuments() { (querySnapshot, error) in
            if let error = error {
                handler(.failure(.getDocumentsError(error.localizedDescription)))
                return
            }
            for document in querySnapshot!.documents {
                let data = document.data()
                guard let shortDescription = data[ApartmentField.shortDescription.rawValue] as? String,
                      let id = data[ApartmentField.id.rawValue] as? String,
                      let fullDescription = data[ApartmentField.fullDescription.rawValue] as? String,
                      let numberOfRooms = data[ApartmentField.numberOfRooms.rawValue] as? Int,
                      let phoneNumber = data[ApartmentField.phoneNumber.rawValue] as? String,
                      let isFavorite = data[ApartmentField.isFavorite.rawValue] as? Bool,
                      let price = data[ApartmentField.price.rawValue] as? Int,
                      let imageNames = data[ApartmentField.imageNames.rawValue] as? [String] else {
                    handler(.failure(.pasrseError))
                    continue
                }
                
                let model = ApartmentModel(id: id, imageNames: imageNames, shortDescription: shortDescription, fullDescription: fullDescription, price: price, phoneNumber: phoneNumber, numberOfRooms: numberOfRooms, isFavorite: isFavorite)
                self.documents[id] = document.documentID
                self.apartments.append(model)
            }
            handler(.success(self.apartments))
        }
    }
    
    func getApartments() -> [ApartmentModel] {
        apartments
    }
    
    func getFavoriteApartments() -> [ApartmentModel] {
        apartments.filter { apartment in
            apartment.isFavorite
        }
    }
    
    func updateApartment(_ apartment: ApartmentModel) {
        guard let id = documents[apartment.id] else { return }
        let ref = db.collection(collection).document(id)
        let update = [ApartmentField.isFavorite.rawValue : !apartment.isFavorite]
        ref.updateData(update)
        
        if let index = apartments.firstIndex(where: { apartmentModel in
            apartmentModel == apartment
        }) {
            apartments[index].isFavorite = !apartments[index].isFavorite
        }
    }
    
    func downloadImage(from urlString: String, handler: @escaping ((UIImage?) -> ())) {
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url, completionHandler: { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            handler(UIImage(data: data))
        }).resume()
    }
}
