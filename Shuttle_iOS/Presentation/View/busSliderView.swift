import UIKit
import SnapKit

final class BusSliderView: UIView {
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        bind()
        configureAddSubViews()
        configureConstraints()
        configureAddActions()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        stationTableView.delegate = self
        stationTableView.dataSource = self
        stationTableView.register(StationTableViewCell.self, forCellReuseIdentifier: StationTableViewCell.identifier)
    }
    
    private func bind() {
        
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
            $0.leading.equalToSuperview().inset(10)
            $0.centerY.equalToSuperview()
        }
        
        stationTableView.snp.makeConstraints {
            $0.bottom.leading.trailing.equalToSuperview()
            $0.top.equalTo(titleView)
        }
    }
    
    private func configureAddActions() {
        
    }
}

extension BusSliderView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: StationTableViewCell.identifier, for: indexPath) as? StationTableViewCell else { return UITableViewCell() }
        
        return cell
    }
}
