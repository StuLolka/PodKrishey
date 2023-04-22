import UIKit
import SnapKit

final class NumberOfRoomsButton: UIButton {
    var action: (() -> ())?
    private var buttonWasSelected = false
    
    init(title: String) {
        super.init(frame: .zero)
        setupButton(title: title)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupButton(title: String) {
        setTitle(title, for: .normal)
        setTitleColor(.darkGray, for: .normal)
        addTarget(self, action: #selector(buttonTouched), for: .touchUpInside)
        
        snp.makeConstraints { make in
            make.width.height.equalTo(40)
        }
        
        layer.cornerRadius = 40 / 2
        layer.borderColor = UIColor.darkGray.cgColor
        layer.borderWidth = 1.5
        clipsToBounds = true
    }
    
    @objc private func buttonTouched() {
        buttonWasSelected.toggle()
        buttonWasSelected ? (buttonWasSelectedAction()) : (buttonWasUnselectedAction())
        action?()
    }
    
    func reset() {
        buttonWasUnselectedAction()
    }
    
    private func buttonWasSelectedAction() {
        backgroundColor = .systemGray6
        layer.borderWidth = 0.5
    }
    
    private func buttonWasUnselectedAction() {
        backgroundColor = nil
        layer.borderWidth = 1.5
    }
}
