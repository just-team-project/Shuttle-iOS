import UIKit
import SnapKit

@MainActor
protocol UserDelegate: AnyObject {
    func tappedCellRow(_ idx: Int)
    func tappedDismissButton()
}

final class CustomStationView: UIView {
    private var viewModel: UserViewModel
    weak var delegate: UserDelegate?
    private var viewModel: UserViewModel
    private var isSyncingScroll: Bool = false
    private let titleView = UIView()
    
    private let sliderBar: UIView = {
        let v = UIView()
        v.backgroundColor = .hsDarkGray
        v.clipsToBounds = true
        return v
    }()
    
    private let titleLabel: UILabel = {
        let l = UILabel()
        l.font = .pretendardBold(size: 18.0)
        l.textColor = .hsBlack
        l.addCharecterString()
        l.textAlignment = .center
        return l
    }()
    
    private let refreshButton: UIButton = {
        let b = UIButton()
        b.setTitle("새로고침", for: .normal)
        b.setTitleColor(.hsDarkGray, for: .normal)
        b.titleLabel?.font = .pretendardMedium(size: 15.0)
        return b
    }()
    
    private let stationTableView = UITableView()

    private let routeScrollView: UIScrollView = {
        let sc = UIScrollView()
        sc.translatesAutoresizingMaskIntoConstraints = false
        sc.backgroundColor = .white
        sc.showsVerticalScrollIndicator = false // 세로 스크롤 표시 여부
        return sc
    }()

    private let busRouteView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .red
        return v
    }()

    init(viewModel: UserViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        setup()
        configureAddSubViews()
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        stationTableView.delegate = self
        stationTableView.dataSource = self
        stationTableView.rowHeight = 50
        stationTableView.separatorStyle = .none
        stationTableView.backgroundColor = .white
        stationTableView.showsVerticalScrollIndicator = false
        stationTableView.register(StationTableViewCell.self, forCellReuseIdentifier: StationTableViewCell.identifier)
        routeScrollView.delegate = self
    }
    
    private func configureAddSubViews() {
        addSubview(titleView)
        addSubview(stationTableView)
        addSubview(routeScrollView)

        routeScrollView.addSubview(busRouteView)

        titleView.addSubview(sliderBar)
        titleView.addSubview(titleLabel)
        titleView.addSubview(refreshButton)
    }
    
    private func configureConstraints() {
        titleView.snp.makeConstraints {
            $0.height.equalTo(50)
            $0.leading.trailing.top.equalToSuperview()
        }
        
        sliderBar.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(150)
            $0.height.equalTo(3)
            $0.top.equalToSuperview().inset(5)
        }
        
        titleLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        refreshButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(10)
            $0.centerY.equalToSuperview()
        }
        
        stationTableView.snp.makeConstraints {
            $0.bottom.leading.equalToSuperview()
            $0.trailing.equalToSuperview().inset(50)
            $0.top.equalTo(titleView.snp.bottom)
        }

        routeScrollView.snp.makeConstraints {
            $0.leading.equalTo(stationTableView.snp.trailing)
            $0.top.equalTo(stationTableView.snp.top)
            $0.bottom.trailing.equalToSuperview()
        }

        busRouteView.snp.makeConstraints {
            $0.leading.trailing.top.bottom.equalToSuperview()
            $0.width.equalTo(routeScrollView.snp.width)
        }
    }

    func configure(viewModel: UserViewModel, busName: String) {
        self.viewModel = viewModel
        titleLabel.text = busName
        stationTableView.reloadData()

        // MARK: - 정류장 개수에 맞는 busRouteView 높이 계산
        busRouteView.snp.remakeConstraints {
            $0.leading.trailing.top.bottom.equalToSuperview()
            $0.height.equalTo(stationTableView.contentSize.height)
            $0.width.equalTo(routeScrollView.snp.width)
        }
    }
    
    func fetchBusLocations(_ busLocations: [BusLocation]) {
        // TODO: - 테이블뷰와 스크롤이 동기화된 ScrollView를 사용해야 함.
    }
}

extension CustomStationView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.busStations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: StationTableViewCell.identifier, for: indexPath) as? StationTableViewCell else { return UITableViewCell() }
        cell.configure(stationEntity: viewModel.busStations[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.tappedCellRow(indexPath.row)
    }
}

extension CustomStationView: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard !isSyncingScroll else { return }
        let offSetY = scrollView.contentOffset.y

        isSyncingScroll = true

        if scrollView == stationTableView {
            routeScrollView.setContentOffset(CGPoint(x: 0, y: offSetY), animated: false)
        } else if scrollView == routeScrollView {
            stationTableView.setContentOffset(CGPoint(x: 0, y: offSetY), animated: false)
        }

        isSyncingScroll = false
    }
}
