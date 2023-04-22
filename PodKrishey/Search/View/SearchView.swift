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
        button.setTitle(.Favorite.city, for: .normal)
        button.backgroundColor = .Global.blueGray
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    private lazy var numberOfRoomsLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = .Favorite.numberOfRooms
        return label
    }()
    
    private lazy var oneRoomButton = NumberOfRoomsButton(title: "1")
    private lazy var twoRoomButton = NumberOfRoomsButton(title: "2")
    private lazy var threeRoomButton = NumberOfRoomsButton(title: "3")
    private lazy var fourRoomButton = NumberOfRoomsButton(title: "4")
    private lazy var fiveRoomButton = NumberOfRoomsButton(title: "5+")
    
    private lazy var roomsButtonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .equalCentering
        stackView.alignment = .center
        stackView.addArrangedSubviews(oneRoomButton, twoRoomButton, threeRoomButton, fourRoomButton, fiveRoomButton)
        return stackView
    }()
    
    private lazy var roomsView: UIView = {
        let view = UIView()
        view.addSubviews(numberOfRoomsLabel, roomsButtonStackView)
        view.backgroundColor = .Global.blueGray
        return view
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = .Favorite.price
        return label
    }()
    
    private lazy var fromPriceView = PriceTextFieldView(title: .Favorite.from)
    private lazy var toPriceView = PriceTextFieldView(title: .Favorite.to)
    
    private lazy var priceStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .equalCentering
        stackView.alignment = .center
        stackView.addArrangedSubviews(fromPriceView, toPriceView)
        return stackView
    }()
    
    private lazy var priceView: UIView = {
        let view = UIView()
        view.addSubviews(priceLabel, priceStackView)
        view.backgroundColor = .Global.blueGray
        return view
    }()
    
    private lazy var searchButton: UIButton = {
        let button = UIButton()
        button.setTitle(.Favorite.show, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 17)
        button.backgroundColor = .Global.blueButton
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 17
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(searchButtonTouched), for: .touchUpInside)
        return button
    }()
    
    private lazy var resetButton: UIButton = {
        let button = UIButton()
        button.setTitle(.Favorite.reset, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 17)
        button.backgroundColor = .Global.blueButton
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 17
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(resetButtonTouched), for: .touchUpInside)
        return button
    }()
    
    private lazy var buttonsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .equalCentering
        stackView.alignment = .center
        stackView.addArrangedSubviews(searchButton, resetButton)
        return stackView
    }()
    
    private lazy var notificationView: NotificationView = {
        let notificationView = NotificationView(title: .Favorite.priceError)
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
    
    @objc private func resetButtonTouched() {
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
        addSubviews(pickCityButton, roomsView, priceView, buttonsStackView)
    
        pickCityButton.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(50)
        }
        
        roomsView.snp.makeConstraints { make in
            make.top.equalTo(pickCityButton.snp_bottomMargin)
            make.leading.trailing.equalToSuperview()
        }
        
        numberOfRoomsLabel.snp.makeConstraints { make in
            make.top.equalTo(roomsView.snp_topMargin).inset(8)
            make.centerX.equalTo(roomsView.snp_centerXWithinMargins)
        }
        
        roomsButtonStackView.snp.makeConstraints { make in
            make.top.equalTo(numberOfRoomsLabel.snp_bottomMargin).offset(18)
            make.leading.trailing.equalTo(roomsView).inset(18)
            make.bottom.equalTo(roomsView.snp_bottomMargin).inset(18)
        }
        
        priceView.snp.makeConstraints { make in
            make.top.equalTo(roomsView.snp_bottomMargin).offset(18)
            make.leading.trailing.equalToSuperview()
        }
        
        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(priceView).inset(8)
            make.centerX.equalTo(priceView)
        }
        
        priceStackView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalTo(priceView).inset(18)
        }
        
        buttonsStackView.snp.makeConstraints { make in
            make.top.equalTo(priceView.snp_bottomMargin).offset(24)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        searchButton.snp.makeConstraints { make in
            make.height.equalTo(35)
            make.width.equalTo(150)
        }
        
        resetButton.snp.makeConstraints { make in
            make.height.width.equalTo(searchButton)
        }
        
        addTapToHideKeyboard()
        addRoomsButtonsActions()
    }
    
    private func addRoomsButtonsActions() {
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
    }
    
    private func addTapToHideKeyboard() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        addGestureRecognizer(tap)
    }
    
    @objc private func hideKeyboard() {
        endEditing(true)
    }
}
