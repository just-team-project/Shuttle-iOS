import UIKit
import SnapKit
import MapKit
import CoreLocation


final class UserViewController: UIViewController {
    private let locationManager = CLLocationManager()
    private let mapView = MKMapView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        bind()
        configureAddSubViews()
        configureConstraints()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        checkLocationAuthorization()
    }
    
    private func setup() {
        view.backgroundColor = .white
        
        mapView.delegate = self
        mapView.preferredConfiguration = MKStandardMapConfiguration() // 기본 지도
        mapView.isZoomEnabled = true // 줌 가능 여부
        mapView.isScrollEnabled = true // 이동 가능 여부
        mapView.showsUserLocation = true // 현재 위치 표시
        mapView.setUserTrackingMode(.followWithHeading, animated: true) // 사용자 위치 추적
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    private func bind() {
        
    }
    
    private func configureAddSubViews() {
        view.addSubview(mapView)
    }
    
    private func configureConstraints() {
        mapView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

extension UserViewController : CLLocationManagerDelegate, MKMapViewDelegate {
    // 위치 권한 메소드
    nonisolated func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        Task { @MainActor in
            checkLocationAuthorization()
        }
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
