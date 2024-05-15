//
//  BoardViewController.swift
//  Board
//
//  Created by min seok Kim on 5/4/24.
//
import UIKit
import RxSwift
import RxCocoa

class BoardViewController: UIViewController {
    
    private var tableView: UITableView!
    private var viewModel: PostViewModel!
    private var boardViewModel: BoardViewModel!
    private var disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = PostViewModel()
        boardViewModel = BoardViewModel()
        setupTableView()
        setTableNavibar()
        bindPostViewModel()
        viewModel.loadPosts()
    }
    
    func setTableNavibar() {
        boardViewModel.loadBoard()
        boardViewModel.BoardObservable
            .map { boards in
                return boards.first?.name ?? "Default Title"
            }
            .bind(to: self.navigationItem.rx.title)
            .disposed(by: disposeBag)
    }
    
    func setupTableView() {
        tableView = UITableView(frame: self.view.bounds, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        view.addSubview(tableView)
    }
    
    func bindPostViewModel() {
        viewModel.postObservable
            .bind(to: tableView.rx.items(cellIdentifier: "cell", cellType: UITableViewCell.self)) { (row, post, cell) in
                cell.textLabel?.text = post.title
            }
            .disposed(by: disposeBag)

        viewModel.errorMessageObservable
            .subscribe(onNext: { [weak self] message in
                guard let self = self, let message = message else { return }
                let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default))
                self.present(alert, animated: true)
            })
            .disposed(by: disposeBag)
    }

}
