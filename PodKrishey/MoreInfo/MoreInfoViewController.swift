import UIKit

class MoreInfoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemPink
    }
    
    private func setupNavigationBar() {
        let edit = UIBarButtonItem(title: "Править", style: .done, target: self, action: #selector())
        navigationItem.rightBarButtonItem = edit
    }
    
    @objc func editTouched() {
        
    }
}
