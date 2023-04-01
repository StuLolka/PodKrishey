import UIKit

protocol MoreInfoViewProtocol: UIView {
    func addData(data: ProfileModel)
}

final class MoreInfoView: UIView, MoreInfoViewProtocol {
    private lazy var customView: CustomProfileView = {
        let view = CustomProfileView()
        view.backgroundColor = .Global.blueGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addData(data: ProfileModel) {
        customView.addData(avatarName: data.avatarName)
    }
    
    private func setupView() {
        addSubviews(customView)
        
        NSLayoutConstraint.activate([
            customView.topAnchor.constraint(equalTo: topAnchor),
            customView.leadingAnchor.constraint(equalTo: leadingAnchor),
            customView.trailingAnchor.constraint(equalTo: trailingAnchor),
            customView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height / 4)
        ])
    }
}


