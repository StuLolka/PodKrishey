import UIKit
import SnapKit

final class FullDescriptionApartmentView: UIView, FullDescriptionApartmentViewProtocol {
    var addToFavoriteAction: (() -> ())?
    var loadImage: ((String, (@escaping (UIImage?) -> ()))  -> ())?
    private var model: ApartmentModel?
    private var imageNames: [String] = []
    
    private lazy var imagesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .Global.blueGray
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ImagesApartmentCell.self, forCellWithReuseIdentifier: ImagesApartmentCell.id)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: Constants.Global.collectionID)
        return collectionView
    }()
    
    private lazy var shortDescriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .italicSystemFont(ofSize: 16)
        label.textColor = .black
        return label
    }()

    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 18)
        return label
    }()
    
    private lazy var phoneNumberLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 16)
        return label
    }()
    
    private lazy var phoneButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(systemName: "phone.fill"), for: .normal)
        button.tintColor = .black
        return button
    }()
    
    private lazy var addToFavoriteButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(.Home.heart, for: .normal)
        button.tintColor = .red
        button.addTarget(self, action: #selector(addToFavoriteButtonTouched), for: .touchUpInside)
        return button
    }()
    
    private lazy var blueView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        view.backgroundColor = .Global.blueGray
        return view
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.addArrangedSubviews(phoneNumberLabel, phoneButton, addToFavoriteButton)
        return stackView
    }()
    
    private lazy var fullDescriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    private lazy var formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.groupingSeparator = " "
        formatter.numberStyle = .decimal
        return formatter
    }()
    
    private lazy var scrollView = UIScrollView()

    private lazy var contentView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setModel(model: ApartmentModel) {
        self.model = model
        imageNames = model.imageNames
        shortDescriptionLabel.text = model.shortDescription
        priceLabel.text = (formatter.string(from: NSNumber(value: model.price)) ?? "") + " ₽"
        phoneNumberLabel.text = model.phoneNumber
        fullDescriptionLabel.text = model.fullDescription
        model.isFavorite ? addToFavoriteButton.setBackgroundImage(.Home.heartFill, for: .normal) : addToFavoriteButton.setBackgroundImage(.Home.heart, for: .normal)
        imagesCollectionView.reloadData()
    }
    
    func setScrollViewContentSize() {
        scrollView.contentSize = CGSize(width: contentView.bounds.width, height: contentView.bounds.height)
    }
    
    @objc private func addToFavoriteButtonTouched() {
        addToFavoriteAction?()
        guard let model = model else { return }
        !model.isFavorite ? addToFavoriteButton.setBackgroundImage(.Home.heartFill, for: .normal) : addToFavoriteButton.setBackgroundImage(.Home.heart, for: .normal)
    }
    
    private func setupView() {
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        blueView.addSubview(stackView)
        contentView.addSubviews(imagesCollectionView,
                                shortDescriptionLabel,
                                priceLabel,
                                blueView,
                                fullDescriptionLabel)
        
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
        
        contentView.snp.makeConstraints { make in
            make.top.equalTo(scrollView)
            make.width.equalTo(UIScreen.main.bounds.width)
        }
        
        imagesCollectionView.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(contentView).inset(8)
            make.height.equalTo( Constants.Global.heightScreen / 2.5)
        }
        
        shortDescriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(imagesCollectionView.snp_bottomMargin).offset(16)
            make.leading.trailing.equalTo(imagesCollectionView)
        }
        
        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(shortDescriptionLabel.snp_bottomMargin).offset(16)
            make.leading.trailing.equalTo(imagesCollectionView)
        }
        
        blueView.snp.makeConstraints { make in
            make.top.equalTo(priceLabel.snp_bottomMargin).offset(16)
            make.leading.trailing.equalTo(imagesCollectionView)
        }
        
        stackView.snp.makeConstraints { make in
            make.top.bottom.equalTo(blueView)
            make.leading.trailing.equalTo(blueView).inset(8)
        }
        
        phoneButton.snp.makeConstraints { make in
            make.width.height.equalTo(45)
        }
        
        addToFavoriteButton.snp.makeConstraints { make in
            make.width.height.equalTo(45)
        }
        
        fullDescriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(stackView.snp_bottomMargin).offset(8)
            make.leading.trailing.equalTo(imagesCollectionView)
            make.bottom.equalTo(contentView).inset(8)
        }
    }
}

extension FullDescriptionApartmentView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: Constants.Global.widthScreen - 16, height: Constants.Global.heightScreen / 2.5)
    }
}


extension FullDescriptionApartmentView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        imageNames.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImagesApartmentCell.id, for: indexPath) as? ImagesApartmentCell else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.Global.collectionID, for: indexPath) as UICollectionViewCell
            return cell
        }
        loadImage?(imageNames[indexPath.row]) { image in
            cell.imageView.image = image
        }
        return cell
    }
    
}
