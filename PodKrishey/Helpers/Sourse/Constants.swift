import UIKit

enum Constants {
    enum Global {
        static let collectionID = "UICollectionViewCell"
        static let heightScreen = UIScreen.main.bounds.height
        static let widthScreen = UIScreen.main.bounds.width
    }
    enum Home {
        static let heightForCell = Constants.Global.heightScreen / 2
        static let heightImageInCell = Constants.Home.heightForCell * 0.8
//        static let widthForCe
    }
    
    enum Profile {
        static let notificationHeight: CGFloat = 80
        static let notificationWidth: CGFloat = UIScreen.main.bounds.width - 20
    }
}
