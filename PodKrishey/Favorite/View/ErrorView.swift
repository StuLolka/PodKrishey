import UIKit

final class ErrorView: UIView {
    private lazy var label: UILabel = {
        let label = UILabel()
//        label.text = .Favorite.none
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    init(text: String) {
        super.init(frame: .zero)
        label.text = text
        setupView( )
    }
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        setupView()
//    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        backgroundColor = .white
        addSubviews(label)
        
        NSLayoutConstraint.activate([
            label.centerYAnchor.constraint(equalTo: centerYAnchor),
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8)
        ])
    }
}
