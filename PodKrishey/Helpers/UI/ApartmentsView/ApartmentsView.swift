import UIKit
import SnapKit

protocol HomeViewProtocol: UIView {
    var loadImage: ((String, String, (@escaping (UIImage?) -> ()))  -> ())? { get set }
    var addToFavoriteAction: ((ApartmentModel) -> ())? { get set }
    var didSelectApartment: ((ApartmentModel) -> ())? { get set }
    
    func updateCollectionView(with data: [ApartmentModel], scrollToTop: Bool)
//    func deleteItemAt(indexPath: IndexPath)
}

final class ApartmentsView: UIView, HomeViewProtocol {
    var loadImage: ((String, String, (@escaping (UIImage?) -> ()))  -> ())?
    var addToFavoriteAction: ((ApartmentModel) -> ())?
    var didSelectApartment: ((ApartmentModel) -> ())?
    
    private var apartaments: [ApartmentModel] = []
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: Constants.Global.collectionID)
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
    
    private func setupView() {
        addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.bottom.equalTo(safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview()
        }
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
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.Global.collectionID, for: indexPath) as UICollectionViewCell
            return cell
        }
        cell.loadImage = loadImage
        cell.addToFavoriteAction = addToFavoriteAction
        cell.addData(model: apartaments[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        didSelectApartment?(apartaments[indexPath.row])
    }
}
