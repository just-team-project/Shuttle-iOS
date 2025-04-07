import UIKit
import SnapKit
import MapKit
import CoreLocation
import Combine

final class UserViewController: UIViewController {
    private var viewModel : UserViewModel
    private let input = PassthroughSubject<UserViewModel.Input, Never>()
    private var cancellables : Set<AnyCancellable> = .init()
    
    private let locationManager: CLLocationManager = .init()
    private let mapView: MKMapView = .init()
    
    private let busCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumInteritemSpacing = 12
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    private lazy var leftStackView : UIStackView = {
        let sv = UIStackView(arrangedSubviews: [logoutButton, faqButton])
        sv.axis = .vertical
        sv.spacing = 10
        sv.alignment = .fill
        sv.distribution = .fillEqually
        return sv
    }()
    
    private lazy var rightStackView : UIStackView = {
        let sv = UIStackView(arrangedSubviews: [alarmButton, notificationButton])
        sv.axis = .vertical
        sv.spacing = 10
        sv.alignment = .fill
        sv.distribution = .fillEqually
        return sv
    }()
    
    private let logoutButton: CustomUserButton = .init(
        image: UIImage(named: "logout")
    )
    private let faqButton: CustomUserButton = .init(
        image: UIImage(named: "faq")
    )
    private let alarmButton: CustomUserButton = .init(
        image: UIImage(named: "alarm")
    )
    private let notificationButton: CustomUserButton = .init(
        image: UIImage(named: "notification")
    )
    
    init(viewModel: UserViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("UserViewController - fatalError Init")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        bind()
        configureAddSubViews()
        configureConstraints()
        configureAddActions()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        checkLocationAuthorization()
    }
    
    private func setup() {
        view.backgroundColor = .white
        
        navigationController?.setNavigationBarHidden(true, animated: false)
        
        mapView.delegate = self
        mapView.preferredConfiguration = MKStandardMapConfiguration() // 기본 지도
        mapView.isZoomEnabled = true // 줌 가능 여부
        mapView.isScrollEnabled = true // 이동 가능 여부
        mapView.showsUserLocation = true // 현재 위치 표시
        mapView.setUserTrackingMode(.followWithHeading, animated: true) // 사용자 위치 추적
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        busCollectionView.delegate = self
        busCollectionView.dataSource = self
        busCollectionView.register(BusCollectionViewCell.self, forCellWithReuseIdentifier: BusCollectionViewCell.identifier)
    }
    
    private func bind() {
        let output = viewModel.transform(input: input.eraseToAnyPublisher())
            
        output.sink { [weak self] event in
            switch event {
            case .userLogout:
                self?.userLogout()
            case .presentFAQ:
                self?.presentFAQ()
            case .presentAlarm:
                self?.presentAlarm()
            case .presentNotification:
                self?.presentNotification()
            }
        }.store(in: &cancellables)
    }
    
    private func configureAddSubViews() {
        view.addSubview(mapView)
        mapView.addSubview(busCollectionView)
        mapView.addSubview(leftStackView)
        mapView.addSubview(rightStackView)
    }
    
    private func configureConstraints() {
        mapView.layoutMargins.bottom = -100
        mapView.layoutMargins.top = -100
        
        mapView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        busCollectionView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.top.equalToSuperview().inset(70)
            $0.height.equalTo(24)
        }
        
        leftStackView.snp.makeConstraints {
            $0.height.equalTo(130)
            $0.width.equalTo(60)
            $0.leading.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview().inset(60)
        }
        
        rightStackView.snp.makeConstraints {
            $0.height.equalTo(130)
            $0.width.equalTo(60)
            $0.trailing.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview().inset(60)
        }
    }
    
    private func configureAddActions() {
        addTappedEventToUserlogoutButton()
        addTappedEventToUserFAQButton()
        addTappedEventToUserAlarmButton()
        addTappedEventToUserNotificationButton()
    }
    
    private func addTappedEventToUserlogoutButton() {
        logoutButton.addAction(
            UIAction { [weak self] _ in
                self?.input.send(.logoutTapped)
            }, for: .touchUpInside)
    }
    
    private func addTappedEventToUserFAQButton() {
        faqButton.addAction(
            UIAction { [weak self] _ in
                self?.input.send(.faqTapped)
            }, for: .touchUpInside)
    }
    
    private func addTappedEventToUserAlarmButton() {
        alarmButton.addAction(
            UIAction { [weak self] _ in
                self?.input.send(.alarmTapped)
            }, for: .touchUpInside)
    }
    
    private func addTappedEventToUserNotificationButton() {
        notificationButton.addAction(
            UIAction { [weak self] _ in
                self?.input.send(.notificationTapped)
            }, for: .touchUpInside)
    }
}

private extension UserViewController {
    private func userLogout() {
        present(UIAlertController.alert(
            title: "로그이웃",
            message: "정말로 로그아웃하시겠습니까?") { [weak self] in
                self?.navigationController?.popViewController(animated: true)
        }, animated: true)
    }
    
    private func presentFAQ() {
        // TODO: - 화면 전환
        print("presentFAQ")
    }
    
    private func presentAlarm() {
        // TODO: - 화면 전환
        print("presentAlarm")
    }
    
    private func presentNotification() {
        // TODO: - 화면 전환
        print("presentNotification")
    }
}

extension UserViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BusCollectionViewCell.identifier, for: indexPath) as? BusCollectionViewCell else {
            return UICollectionViewCell()
        }
        return cell
    }
}

extension UserViewController : @preconcurrency CLLocationManagerDelegate, MKMapViewDelegate {
    // 위치 권한 메소드
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }
    
    func checkLocationAuthorization() {
        switch locationManager.authorizationStatus {
            case .authorizedWhenInUse: // 앱이 사용될 때 허용
                break
            case .restricted, .denied: // 위치 사용 권한 X
                break
            case .notDetermined: // 아직 결정되지 않았음.
                locationManager.requestWhenInUseAuthorization()
                break
            default:
                break
        }
    }
}
