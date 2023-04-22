import UIKit
import SnapKit


final class ApartamentCell: UICollectionViewCell {
    static let id = "ApartamentCell"
    
    var addToFavoriteAction: ((ApartmentModel) -> ())?
    var loadImage: ((String, String, (@escaping (UIImage?) -> ()))  -> ())?
    
    private var model: ApartmentModel?
    
    private lazy var imageView = UIImageView()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        return label
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 18)
        label.textColor = .black
        return label
    }()
    
    private lazy var addToFavoriteButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(.Home.heart, for: .normal)
        button.tintColor = .red
        button.addTarget(self, action: #selector(addToFavoriteButtonTouched), for: .touchUpInside)
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
        model.isFavorite ? addToFavoriteButton.setBackgroundImage(.Home.heartFill, for: .normal) : addToFavoriteButton.setBackgroundImage(.Home.heart, for: .normal)
        descriptionLabel.text = model.shortDescription
        if let firstImage = model.imageNames.first {
            loadImage?(firstImage, model.id) { image in
                self.imageView.image = image
            }
        }
        priceLabel.text = (formatter.string(from: NSNumber(value: model.price)) ?? "") + " ₽"
    }
    
    @objc private func addToFavoriteButtonTouched() {
        guard let model = model else { return }
        addToFavoriteAction?(model)
        !model.isFavorite ? addToFavoriteButton.setBackgroundImage(.Home.heartFill, for: .normal) : addToFavoriteButton.setBackgroundImage(.Home.heart, for: .normal)
    }
    
    private func setupView() {
        addSubviews(imageView, descriptionLabel, priceLabel, addToFavoriteButton)
        
        imageView.snp.makeConstraints { make in
            make.top.equalTo(snp_topMargin).inset(8)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(Constants.Global.heightScreen / 2.5)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp_bottomMargin).offset(8)
            make.leading.equalToSuperview()
        }
        
        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp_bottomMargin).offset(8)
            make.leading.equalToSuperview()
        }
        
        addToFavoriteButton.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp_bottomMargin).offset(13)
            make.trailing.equalToSuperview().inset(8)
            make.height.width.equalTo(30)
        }
 
    }
}
