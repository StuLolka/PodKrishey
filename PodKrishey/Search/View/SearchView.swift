import UIKit

protocol SearchViewProtocol: UIView {
    var searchAction: ((_ minPrice: Int, _ maxPrice: Int, _ roomNumber: Set<Int>) -> ())? { get set}
    var resetAction: (() -> ())? { get set }
    var priceErrorAction: (() -> ())? { get set }
    
    func changeNotificationFrame(_ frame: CGRect)
}

final class SearchView: UIView, SearchViewProtocol {
    var searchAction: ((_ minPrice: Int, _ maxPrice: Int, _ roomNumber: Set<Int>) -> ())?
    var resetAction: (() -> ())?
    var priceErrorAction: (() -> ())?
    
    private var roomsSelected: Set<Int> = []
    
    private lazy var pickCityButton: UIButton = {
        let button = UIButton()
        button.setTitle("Город: Москва", for: .normal)
        button.backgroundColor = .Global.blueGray
        button.setTitleColor(.black, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var numberOfRoomsLabel: UILabel = {
        let label = UILabel()
        label.text = "Количество комнат"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var oneRoomButton = NumberOfRoomsButton(title: "1", size: 40, color: .black)
    private lazy var twoRoomButton = NumberOfRoomsButton(title: "2", size: 40, color: .black)
    private lazy var threeRoomButton = NumberOfRoomsButton(title: "3", size: 40, color: .black)
    private lazy var fourRoomButton = NumberOfRoomsButton(title: "4", size: 40, color: .black)
    private lazy var fiveRoomButton = NumberOfRoomsButton(title: "5+", size: 40, color: .black)
    
    private lazy var roomsButtonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .equalCentering
        stackView.alignment = .center
        stackView.addArrangedSubviews(oneRoomButton, twoRoomButton, threeRoomButton, fourRoomButton, fiveRoomButton)
        return stackView
    }()
    
    private lazy var roomsView: UIView = {
        let view = UIView()
        view.addSubviews(numberOfRoomsLabel, roomsButtonStackView)
        view.backgroundColor = .Global.blueGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.text = "Цена"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var fromPriceView = PriceTextFieldView(title: "от")
    private lazy var toPriceView = PriceTextFieldView(title: "до")
    
    private lazy var priceStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .equalCentering
        stackView.alignment = .center
        stackView.addArrangedSubviews(fromPriceView, toPriceView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var priceView: UIView = {
        let view = UIView()
        view.addSubviews(priceLabel, priceStackView)
        view.backgroundColor = .Global.blueGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var searchButton: UIButton = {
        let button = UIButton()
        button.setTitle("Показать", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 17)
        button.backgroundColor = .Global.blueButton
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 17
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(searchButtonTouched), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var resetButton: UIButton = {
        let button = UIButton()
        button.setTitle("Очистить", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 17)
        button.backgroundColor = .Global.blueButton
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 17
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(resetButtonTouched), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var buttonsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .equalCentering
        stackView.alignment = .center
        stackView.addArrangedSubviews(searchButton, resetButton)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var notificationView: NotificationView = {
        let notificationView = NotificationView(title: "Цена ДО не может быть меньше цены ОТ")
        notificationView.frame = CGRect(x: 10, y: -Constants.Profile.notificationHeight, width: Constants.Profile.notificationWidth, height: Constants.Profile.notificationHeight)
        notificationView.backgroundColor = .systemGray6
        notificationView.layer.cornerRadius = 10
        notificationView.clipsToBounds = true
        return notificationView
    }()
    
    init() {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func changeNotificationFrame(_ frame: CGRect) {
        notificationView.frame = frame
    }
    
    @objc private func searchButtonTouched() {
        let fromPrice = Int(fromPriceView.getText()) ?? 0
        let toPrice = Int(toPriceView.getText()) ?? Int.max
        
        if toPrice < fromPrice {
            priceErrorAction?()
            return
        }
        if roomsSelected.isEmpty {
            roomsSelected = [1, 2, 3, 4, 5]
        }
        searchAction?(fromPrice, toPrice, roomsSelected)
    }
    
    @objc func resetButtonTouched() {
        roomsSelected = []
        resetAction?()
        oneRoomButton.reset()
        twoRoomButton.reset()
        threeRoomButton.reset()
        fourRoomButton.reset()
        fiveRoomButton.reset()
        fromPriceView.reset()
        toPriceView.reset()
    }
    
    private func setupView() {
//        addSubviews(pickCityButton, roomsView, priceView, buttonsStackView, notificationView)
        addSubviews(pickCityButton, roomsView, priceView, buttonsStackView)
        oneRoomButton.action = {
            if self.roomsSelected.contains(1) {
                self.roomsSelected.remove(1)
            } else {
                self.roomsSelected.insert(1)
            }
        }
        
        twoRoomButton.action = {
            if self.roomsSelected.contains(2) {
                self.roomsSelected.remove(2)
            } else {
                self.roomsSelected.insert(2)
            }
        }
        
        threeRoomButton.action = {
            if self.roomsSelected.contains(3) {
                self.roomsSelected.remove(3)
            } else {
                self.roomsSelected.insert(3)
            }
        }
        
        fourRoomButton.action = {
            if self.roomsSelected.contains(4) {
                self.roomsSelected.remove(4)
            } else {
                self.roomsSelected.insert(4)
            }
        }
        
        fiveRoomButton.action = {
            if self.roomsSelected.contains(5) {
                self.roomsSelected.remove(5)
            } else {
                self.roomsSelected.insert(5)
            }
        }
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapAction))
        addGestureRecognizer(tap)
        
        NSLayoutConstraint.activate([
            pickCityButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            pickCityButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            pickCityButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            pickCityButton.heightAnchor.constraint(equalToConstant: 50),
            
            roomsView.topAnchor.constraint(equalTo: pickCityButton.bottomAnchor, constant: 18),
            roomsView.leadingAnchor.constraint(equalTo: leadingAnchor),
            roomsView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            numberOfRoomsLabel.centerXAnchor.constraint(equalTo: roomsView.centerXAnchor),
            numberOfRoomsLabel.topAnchor.constraint(equalTo: roomsView.topAnchor, constant: 8),
            
            roomsButtonStackView.leadingAnchor.constraint(equalTo: roomsView.leadingAnchor, constant: 18),
            roomsButtonStackView.trailingAnchor.constraint(equalTo: roomsView.trailingAnchor, constant: -18),
            roomsButtonStackView.topAnchor.constraint(equalTo: numberOfRoomsLabel.bottomAnchor, constant: 18),
            roomsButtonStackView.bottomAnchor.constraint(equalTo: roomsView.bottomAnchor, constant: -18),
            
            priceView.topAnchor.constraint(equalTo: roomsView.bottomAnchor, constant: 18),
            priceView.leadingAnchor.constraint(equalTo: leadingAnchor),
            priceView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            priceLabel.topAnchor.constraint(equalTo: priceView.topAnchor, constant: 8),
            priceLabel.centerXAnchor.constraint(equalTo: priceView.centerXAnchor),
            
            priceStackView.leadingAnchor.constraint(equalTo: priceView.leadingAnchor, constant: 18),
            priceStackView.trailingAnchor.constraint(equalTo: priceView.trailingAnchor, constant: -18),
            priceStackView.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 18),
            priceStackView.bottomAnchor.constraint(equalTo: priceView.bottomAnchor, constant: -18),
            
            buttonsStackView.topAnchor.constraint(equalTo: priceView.bottomAnchor, constant: 24),
            buttonsStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            buttonsStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            searchButton.widthAnchor.constraint(equalToConstant: 150),
            searchButton.heightAnchor.constraint(equalToConstant: 35),
            
            resetButton.widthAnchor.constraint(equalTo: searchButton.widthAnchor),
            resetButton.heightAnchor.constraint(equalTo: searchButton.heightAnchor),
        ])
    }
    
    @objc func tapAction() {
        endEditing(true)
    }
}
