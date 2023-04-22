import UIKit
import SnapKit

final class PriceTextFieldView: UIStackView {
    private lazy var title: UILabel = {
        let label = UILabel()
        label.textColor = .black
        return label
    }()
    
    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.keyboardType = .numberPad
        textField.borderStyle = .none
        textField.delegate = self
        textField.adjustsFontSizeToFitWidth = true
        return textField
    }()
    
    private lazy var rubleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "₽"
        return label
    }()
    
    private lazy var bottomLine: UIView = {
        let view = UIView()
        view.backgroundColor = .darkGray
        return view
    }()
    
    private lazy var formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.groupingSeparator = " "
        formatter.numberStyle = .decimal
        return formatter
    }()
    
    init(title: String) {
        super.init(frame: .zero)
        setupView(title: title)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func getText() -> String {
        return textField.text?.replacingOccurrences(of: formatter.groupingSeparator, with: "") ?? ""
    }
    
    func reset() {
        textField.text = ""
    }
    
    private func setupView(title: String) {
        self.title.text = title
        axis = .horizontal
        spacing = 10
        addSubview(bottomLine)
        addArrangedSubviews(self.title, textField, rubleLabel)
        
        textField.snp.makeConstraints { make in
            make.width.equalTo(90)
        }
        
        bottomLine.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(1.5)
        }
    }
}


extension PriceTextFieldView: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text,
              let rangeOfTextToReplace = Range(range, in: text) else {
            return false
        }
        
        let substringToReplace = text[rangeOfTextToReplace]
        let count = text.count - substringToReplace.count + string.count
        
        let completeString = textField.text!.replacingOccurrences(of: formatter.groupingSeparator, with: "") + string
        if let number = Int(completeString), count <= Constants.maxLenTextField, !string.isEmpty {
            textField.text = formatter.string(from: NSNumber(value: number))
            return false
        }
        
        if text.count >= 3, string.isEmpty {
            textField.text?.removeLast()
            if text[text.index(before: text.endIndex)] == " " {
                textField.text?.removeLast()
            }
            guard let text = textField.text?.replacingOccurrences(of: formatter.groupingSeparator, with: ""), let number = Int(text) else { return false }
            textField.text = formatter.string(from: NSNumber(value: number))
            return false
        }
        return count <= Constants.maxLenTextField
    }
}


private extension PriceTextFieldView {
    enum Constants {
        static let maxLenTextField = 11
    }
}
