import UIKit
import SnapKit
import MapKit
import CoreLocation
import Combine

final class UserViewController: UIViewController, UserCellDelegate {
    private var viewModel : UserViewModel
    private let input = PassthroughSubject<UserViewModel.Input, Never>()
    private var cancellables : Set<AnyCancellable> = .init()
    
    private let locationManager: CLLocationManager = .init()
    private let mapView: MKMapView = .init()
    
    private var initialTouchPoint: CGPoint = .zero
    
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
    
    private lazy var stationView : CustomStationView = {
        let b = CustomStationView(viewModel: viewModel)
        b.backgroundColor = .white
        b.clipsToBounds = true
        b.layer.cornerRadius = 15
        return b
    }()
    
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
    
    deinit {
        print("UserViewController - Deinit")
    }
    
    private func setup() {
        view.backgroundColor = .white
        
        navigationController?.setNavigationBarHidden(true, animated: false)
        
        stationView.delegate = self
        
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
        
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(resignSliderView))
        stationView.addGestureRecognizer(gesture)
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
            case .busStationResponse(let busStations):
                self?.responseBusStations(busStations)
            case .failure(let errorString):
                self?.failure(errorString)
            }
        }.store(in: &cancellables)
    }
    
    private func configureAddSubViews() {
        view.addSubview(mapView)
        mapView.addSubview(busCollectionView)
        mapView.addSubview(leftStackView)
        mapView.addSubview(rightStackView)
        mapView.addSubview(stationView)
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
        
        stationView.snp.makeConstraints {
            $0.height.equalTo(400)
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(mapView.snp.bottom)
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
    
    @objc private func resignSliderView(_ sender: UIPanGestureRecognizer) {
        let touchPoint = sender.location(in: self.view.window)
        
        if sender.state == .began {
            initialTouchPoint = touchPoint
        }
        
        if sender.state == .ended || sender.state == .cancelled {
            if initialTouchPoint.y - touchPoint.y < -100 {
                animateDismissSliderView()
            }
        }
    }
    
    private func animatePresentSliderView() {
        stationView.snp.remakeConstraints {
            $0.height.equalTo(400)
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(mapView.snp.bottom).inset(400)
        }
        
        UIView.animate(withDuration: 0.3) { [weak self] in
            self?.view.layoutIfNeeded()
        }
    }
    
    private func animateDismissSliderView() {
        stationView.snp.remakeConstraints {
            $0.height.equalTo(400)
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(mapView.snp.bottom)
        }
        
        UIView.animate(withDuration: 0.3) { [weak self] in
            self?.view.layoutIfNeeded()
        }
    }
    
    // MARK: - Custom Delegate Method
    func tappedCellRow(_ idx: Int) {
        let stationName = viewModel.busStations[idx].name
        let lat = viewModel.busStations[idx].lat
        let lon = viewModel.busStations[idx].lon
        print(stationName, lat, lon)
        let center = CLLocationCoordinate2D(latitude: lat, longitude: lon)
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        mapView.setRegion(MKCoordinateRegion(center: center, span: span), animated: true)
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
    
    private func responseBusStations(_ busStations: [BusStation]) {
        stationView.configure(viewModel: viewModel)
    }
    
    private func failure(_ errorString: String) {
        present(UIAlertController.errorAlert(message: errorString), animated: true)
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        animatePresentSliderView()
        guard let selectedCell = collectionView.cellForItem(at: indexPath) as? BusCollectionViewCell else {
            return
        }
        input.send(.busStationRequest(selectedCell.busLabel.text))
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
