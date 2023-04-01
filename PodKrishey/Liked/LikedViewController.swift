import UIKit

final class LikedViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .Global.backgroundViewController
        navigationItem.titleView = CustomNavigationTitle(title: .Liked.title)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("\n\nLiked apartaments: \(ApartamentData.likedApartaments)")
    }
}
