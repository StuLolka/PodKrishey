import UIKit

final class ApartamentCell: UICollectionViewCell {
    static let id = "ApartamentCell"
    
    var likeAction: ((ApartmentModel) -> ())?
    var loadImage: ((String, (@escaping (UIImage?) -> ()))  -> ())?
    
    private var model: ApartmentModel?
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 18)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var likeButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(.Home.heart, for: .normal)
        button.tintColor = .red
        button.addTarget(self, action: #selector(likeButtonTouched), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.groupingSeparator = " "
        formatter.numberStyle = .decimal
        return formatter
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addData(model: ApartmentModel) {
        self.model = model
        model.isFavorite ? likeButton.setBackgroundImage(.Home.heartFill, for: .normal) : likeButton.setBackgroundImage(.Home.heart, for: .normal)
        descriptionLabel.text = model.shortDescription
        if let firstImage = model.imageNames.first {
            loadImage?(firstImage) { image in
                self.imageView.image = image
            }
        }
        priceLabel.text = (formatter.string(from: NSNumber(value: model.price)) ?? "") + " ₽"
    }
    
    @objc private func likeButtonTouched() {
        guard let model = model else { return }
        likeAction?(model)
        !model.isFavorite ? likeButton.setBackgroundImage(.Home.heartFill, for: .normal) : likeButton.setBackgroundImage(.Home.heart, for: .normal)
    }
    
    private func setupView() {
        addSubviews(imageView, descriptionLabel, priceLabel, likeButton)
        
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            imageView.heightAnchor.constraint(equalToConstant: Constants.Global.heightScreen / 2.5),
            
            descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            descriptionLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8),
            
            priceLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            priceLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 8),
            
            likeButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            likeButton.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 13),
            likeButton.heightAnchor.constraint(equalToConstant: 30),
            likeButton.widthAnchor.constraint(equalToConstant: 30),
        ])
    }
}
