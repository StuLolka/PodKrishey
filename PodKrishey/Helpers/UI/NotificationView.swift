import UIKit
import SnapKit

final class NotificationView: UIView {
    private lazy var label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    init(title: String) {
        super.init(frame: .zero)
        setupView()
        label.text = title
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubview(label)
        label.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(8)
//            make.top.leading.trailing.bottom.equalToSuperview().offset(8)
        }
    }
}
