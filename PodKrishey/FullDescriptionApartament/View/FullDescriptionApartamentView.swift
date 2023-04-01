import UIKit

protocol FullDescriptionApartamentViewProtocol: UIView {
    func setModel(model: HomeDataModel)
    func setScrollViewContentSize()
}

final class FullDescriptionApartamentView: UIView, FullDescriptionApartamentViewProtocol {
    private var model: HomeDataModel?
    private var imageNames: [String] = []
    
    private lazy var imagesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .Global.blueGray
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ImagesApartamentCell.self, forCellWithReuseIdentifier: ImagesApartamentCell.id)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "UICollectionViewCell")
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private lazy var shortDescriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var phoneNumberLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 16)
//        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var phoneButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(systemName: "phone.fill"), for: .normal)
        button.tintColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var likeButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(.Home.heart, for: .normal)
        button.tintColor = .red
//        button.addTarget(self, action: #selector(likeButtonTouched), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.backgroundColor = .Global.blueGray
        stackView.spacing = 10
        stackView.addArrangedSubviews(phoneNumberLabel, phoneButton, likeButton)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var fullDescriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.groupingSeparator = " "
        formatter.numberStyle = .decimal
        return formatter
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
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
    
    func setModel(model: HomeDataModel) {
        imageNames = model.imageNames
        shortDescriptionLabel.text = model.shortDescription
        priceLabel.text = (formatter.string(from: NSNumber(value: model.price)) ?? "") + " ₽"
        phoneNumberLabel.text = model.phoneNumber
        fullDescriptionLabel.text = model.fullDescription
        model.isLiked ? likeButton.setBackgroundImage(.Home.heartFill, for: .normal) : likeButton.setBackgroundImage(.Home.heart, for: .normal)
        imagesCollectionView.reloadData()
    }
    
    func setScrollViewContentSize() {
        scrollView.contentSize = CGSize(width: contentView.bounds.width, height: contentView.bounds.height)
    }
    
    private func setupView() {
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubviews(imagesCollectionView,
                    shortDescriptionLabel,
                    priceLabel,
                    stackView,
                    fullDescriptionLabel)
                
        layoutSubviews()
        layoutIfNeeded()
        scrollView.contentSize.width = bounds.width
        
        NSLayoutConstraint.activate([
            
            scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            
            contentView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
//            contentView.heightAnchor.constraint(equalToConstant: 1300),
//            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            
            imagesCollectionView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            imagesCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            imagesCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            imagesCollectionView.heightAnchor.constraint(equalToConstant: Constants.Global.heightScreen / 2.5),
            
            shortDescriptionLabel.topAnchor.constraint(equalTo: imagesCollectionView.bottomAnchor, constant: 8),
            shortDescriptionLabel.leadingAnchor.constraint(equalTo: imagesCollectionView.leadingAnchor),
            shortDescriptionLabel.trailingAnchor.constraint(equalTo: imagesCollectionView.trailingAnchor),
            
            priceLabel.topAnchor.constraint(equalTo: shortDescriptionLabel.bottomAnchor, constant: 8),
            priceLabel.leadingAnchor.constraint(equalTo: imagesCollectionView.leadingAnchor),
            priceLabel.trailingAnchor.constraint(equalTo: imagesCollectionView.trailingAnchor),
            
            stackView.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 16),
//            stackView.heightAnchor.constraint(equalToConstant: 80),
            stackView.leadingAnchor.constraint(equalTo: imagesCollectionView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: imagesCollectionView.trailingAnchor),
            
            phoneButton.heightAnchor.constraint(equalToConstant: 50),
            phoneButton.widthAnchor.constraint(equalToConstant: 50),
            
            likeButton.heightAnchor.constraint(equalTo: phoneButton.heightAnchor),
            likeButton.widthAnchor.constraint(equalTo: phoneButton.widthAnchor),
            
            fullDescriptionLabel.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 8),
            fullDescriptionLabel.leadingAnchor.constraint(equalTo: imagesCollectionView.leadingAnchor),
            fullDescriptionLabel.trailingAnchor.constraint(equalTo: imagesCollectionView.trailingAnchor),
            fullDescriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
}

extension FullDescriptionApartamentView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: Constants.Global.widthScreen - 16, height: Constants.Global.heightScreen / 2.5)
    }
}


extension FullDescriptionApartamentView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        imageNames.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImagesApartamentCell.id, for: indexPath) as? ImagesApartamentCell else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UICollectionViewCell", for: indexPath) as UICollectionViewCell
            return cell
        }
        cell.imageView.image = UIImage(named: imageNames[indexPath.row])
//        cell.largeContentImage = UIImage(named: imageNames[indexPath.row])
        return cell
    }

}
