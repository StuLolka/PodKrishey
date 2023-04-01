import UIKit

final class NumberOfRoomsButton: UIButton {
    var action: (() -> ())?
    private var buttonWasSelected = false
    
    init(title: String, size: CGFloat, color: UIColor) {
        super.init(frame: .zero)
        setupButton(title: title, size: size, color: color)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupButton(title: String, size: CGFloat, color: UIColor) {
        setTitle(title, for: .normal)
        setTitleColor(color, for: .normal)
        addTarget(self, action: #selector(buttonTouched), for: .touchUpInside)
        translatesAutoresizingMaskIntoConstraints = false
        
        widthAnchor.constraint(equalToConstant: size).isActive = true
        heightAnchor.constraint(equalToConstant: size).isActive = true
        
        layer.cornerRadius = size / 2
        layer.borderColor = color.cgColor
        layer.borderWidth = 1.5
        clipsToBounds = true
    }
    
    @objc func buttonTouched() {
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
