import UIKit

protocol HomeViewProtocol: UIView {
    var loadImage: ((String, (@escaping (UIImage?) -> ()))  -> ())? { get set }
    var likeAction: ((ApartmentModel) -> ())? { get set }
    var didSelectApartment: ((ApartmentModel) -> ())? { get set }
    
    func updateCollectionView(with data: [ApartmentModel], scrollToTop: Bool)
//    func deleteItemAt(indexPath: IndexPath)
}

final class ApartmentsView: UIView, HomeViewProtocol {
    var loadImage: ((String, (@escaping (UIImage?) -> ()))  -> ())?
    var likeAction: ((ApartmentModel) -> ())?
    var didSelectApartment: ((ApartmentModel) -> ())?
    
    private var apartaments: [ApartmentModel] = []
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "default")
        collectionView.register(ApartamentCell.self, forCellWithReuseIdentifier: ApartamentCell.id)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = .Global.backgroundViewController
        return collectionView
    }()
    
    init() {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateCollectionView(with data: [ApartmentModel], scrollToTop: Bool = true) {
        apartaments = data
        collectionView.reloadData()
        if scrollToTop{
            collectionView.setContentOffset(.zero, animated: true)
        }
    }
    
//    func deleteItemAt(indexPath: IndexPath) {
//        collectionView.deleteItems(at: [indexPath])
//    }
    
    private func setupView() {
        addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}

extension ApartmentsView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: Constants.Global.widthScreen - 16, height: Constants.Global.heightScreen / 1.8)
    }
}

extension ApartmentsView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        apartaments.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ApartamentCell.id, for: indexPath) as? ApartamentCell else {
            return UICollectionViewCell()
        }
        cell.loadImage = loadImage
        cell.likeAction = likeAction
        cell.addData(model: apartaments[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        didSelectApartment?(apartaments[indexPath.row])
    }
}
