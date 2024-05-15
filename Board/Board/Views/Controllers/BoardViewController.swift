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
    private var searchController: UISearchController!

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = PostViewModel()
        boardViewModel = BoardViewModel()
        setupTableView()
        setTableNavibar()
        setupSearchController()
        bindPostViewModel()
        bindSearchController()
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
    
    func setupSearchController() {
         searchController = UISearchController(searchResultsController: nil)
         searchController.obscuresBackgroundDuringPresentationsß = false
         searchController.searchBar.placeholder = "Search Posts"
         navigationItem.searchController = searchController
         definesPresentationContext = true
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
    
    func bindSearchController() {
        searchController.searchBar.rx.text.orEmpty
            .distinctUntilChanged()
            .debounce(RxTimeInterval.milliseconds(300), scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] query in
                if query.isEmpty {
                    self?.viewModel.loadPosts()
                } else {
                    self?.viewModel.searchPosts(keyword: query, searchTarget: SearchTarget.All)
                }
            })
            .disposed(by: disposeBag)
    }

}
