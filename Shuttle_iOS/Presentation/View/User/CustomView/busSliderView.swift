import UIKit
import SnapKit

@MainActor
protocol UserCellDelegate: AnyObject {
    func tappedCellRow(_ idx: Int)
}

final class BusSliderView: UIView {
    private var viewModel: UserViewModel
    weak var delegate: UserCellDelegate?
    
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
        stationTableView.register(StationTableViewCell.self, forCellReuseIdentifier: StationTableViewCell.identifier)
    }
    
    private func configureAddSubViews() {
        addSubview(titleView)
        addSubview(stationTableView)
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
            $0.bottom.leading.trailing.equalToSuperview()
            $0.top.equalTo(titleView.snp.bottom)
        }
    }
    
    func configure(viewModel: UserViewModel) {
        self.viewModel = viewModel
        stationTableView.reloadData()
    }
}

extension BusSliderView: UITableViewDelegate, UITableViewDataSource {
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
