//
//  BoardListViewController.swift
//  Board
//
//  Created by Minseok Brady Kim on 5/17/24.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

class BoardListViewController: UIViewController {
    private var tableView: UITableView!
    private var disposeBag = DisposeBag()
    
    var boardViewModel: BoardViewModel!
    var onBoardSelected: ((Board) -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        setupNavigationBar()
        bindBoardViewModel()
    }
    
    func setupNavigationBar() {
        
        let boardListLeftButton = UIButton()
        boardListLeftButton.setImage(UIImage(named: "close"), for: .normal)
        boardListLeftButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        
        let boardListCloseButton = UIBarButtonItem(customView: boardListLeftButton)
        navigationItem.leftBarButtonItem = boardListCloseButton
        boardListLeftButton.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 24, height: 24))
        }
    }
    
    
    func setupTableView() {
        self.view.backgroundColor = .white
        tableView = UITableView(frame: self.view.bounds, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
    
        tableView.register(BoardCell.self, forCellReuseIdentifier: "BoardCell")
        tableView.separatorStyle = .none
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    @objc private func closeButtonTapped() {
        dismiss(animated: true, completion: nil)
    }

    
    func bindBoardViewModel() {
        boardViewModel.dataObservable
            .bind(to: tableView.rx.items(cellIdentifier: "BoardCell", cellType: BoardCell.self)) { (row, board, cell) in
                cell.configure(with: board.name)
            }
            .disposed(by: disposeBag)

        tableView.rx.modelSelected(Board.self)
            .subscribe(onNext: { [weak self] board in
                self?.dismiss(animated: true) {
                    self?.onBoardSelected?(board)
                }
            })
            .disposed(by: disposeBag)
    }
}
