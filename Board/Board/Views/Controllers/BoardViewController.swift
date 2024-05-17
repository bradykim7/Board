//
//  BoardViewController.swift
//  Board
//
//  Created by min seok Kim on 5/4/24.
//
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
    private lazy var postViewModel: PostViewModel = {
        return PostViewModel()
    }()
    
    private lazy var boardViewModel: BoardViewModel = {
        return BoardViewModel()
    }()
    
    private var disposeBag = DisposeBag()
    private var searchController: UISearchController!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        setTableNavibar()
        setupSearchController()
        bindPostViewModel()
        bindSearchController()
        postViewModel.loadPosts()
    }
    
    func setTableNavibar() {
        boardViewModel.loadBoards()
        boardViewModel.dataObservable
            .map { boards in
                return boards.first?.name ?? "Default Title"
            }
            .bind(to: self.navigationItem.rx.title)
            .disposed(by: disposeBag)
    }
    
    func setupTableView() {
        tableView = UITableView(frame: self.view.bounds, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(PostCell.self, forCellReuseIdentifier: "PostCell")
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func setupSearchController() {
        searchController = UISearchController(searchResultsController: nil)
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Posts"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    func bindPostViewModel() {
        postViewModel.dataObservable
            .bind(to: tableView.rx.items(cellIdentifier: "PostCell", cellType: PostCell.self)) { (row, post, cell) in
                cell.configure(with: post)
            }
            .disposed(by: disposeBag)

        postViewModel.errorMessageObservable
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
            .debounce(.milliseconds(300), scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] query in
                if query.isEmpty {
                    self?.postViewModel.loadPosts()
                } else {
                    self?.postViewModel.searchPosts(keyword: query, target: SearchTarget.All)
                }
            })
            .disposed(by: disposeBag)
    }
}
