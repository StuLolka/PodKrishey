import UIKit

protocol HomeViewProtocol: UIView {
    var likeAction: ((HomeDataModel) -> ())? { get set }
    var dislikeAction: ((HomeDataModel) -> ())? { get set }
    var didSelectApartament: ((HomeDataModel) -> ())? { get set }
    
//    func updateModel(model: [HomeDataModel])
    func updateCollectionView(with data: [HomeDataModel], reloadData: Bool)
}

final class HomeView: UIView, HomeViewProtocol {
    var likeAction: ((HomeDataModel) -> ())?
    var dislikeAction: ((HomeDataModel) -> ())?
    var didSelectApartament: ((HomeDataModel) -> ())?
    
    private var apartaments: [HomeDataModel] = []
    
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
    
    func updateCollectionView(with data: [HomeDataModel], reloadData: Bool = true) {
        apartaments = data
        if reloadData{
            collectionView.setContentOffset(.zero, animated: true)
            collectionView.reloadData()
        }
    }
    
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

extension HomeView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: Constants.Global.widthScreen - 16, height: Constants.Global.heightScreen / 1.8)
    }
}

extension HomeView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        apartaments.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ApartamentCell.id, for: indexPath) as? ApartamentCell else {
            return UICollectionViewCell()
        }
        cell.likeAction = likeAction
        cell.dislikeAction = dislikeAction
        cell.addData(model: apartaments[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        didSelectApartament?(apartaments[indexPath.row])
    }
}
