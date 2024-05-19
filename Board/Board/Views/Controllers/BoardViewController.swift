import UIKit
import RxSwift
import RxCocoa
import SnapKit

class BoardViewController: UIViewController {
    
    private var tableView: UITableView!
    
    private var boardViewModel = BoardViewModel()
    private var postViewModel = PostViewModel()
    
    private var disposeBag = DisposeBag()
    private var searchController: UISearchController!
    private var refreshControl = UIRefreshControl()
    
    private var currentBoard: Board? // 현재 선택된 게시판 정보를 저장할 변수
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupRefreshControl() // Refresh Control 설정 추가
        setupNavigationBar()
        bindPostViewModel()
        setupInitialBoard()
    }
    
    func setupInitialBoard() {
        // 초기 게시판 설정 및 게시글 로드
        boardViewModel.loadBoards()
        boardViewModel.dataObservable
            .compactMap { $0.first }
            .take(1)
            .subscribe(onNext: { [weak self] board in
                self?.updateBoard(board)
            })
            .disposed(by: disposeBag)
    }
    
    func updateBoard(_ board: Board) {
        currentBoard = board // 현재 선택된 게시판 정보를 업데이트
        // 게시판 이름을 네비게이션 타이틀로 설정
        let titleLabel = UILabel()
        titleLabel.textColor = .black
        titleLabel.font = UIFont.systemFont(ofSize: 22, weight: .medium)
        let width = view.frame.size.width - 120  // 좌우 여유 공간을 주어 왼쪽 정렬 효과를 내기
        titleLabel.frame = CGRect(x: 0, y: 0, width: width, height: 60)
        titleLabel.text = board.name
        navigationItem.titleView = titleLabel
        
        // 해당 게시판의 게시글 로드
        postViewModel.loadPosts(boardId: board.id)
    }
    
    func setupNavigationBar() {
        let boardButtonImage = UIImage(named: "Group 731")
        let boardLeftButton = UIButton()
        boardLeftButton.setImage(boardButtonImage, for: .normal)
        boardLeftButton.addTarget(self, action: #selector(showBoardList), for: .touchUpInside)
        let boardListButton = UIBarButtonItem(customView: boardLeftButton)
        navigationItem.leftBarButtonItem = boardListButton
        boardLeftButton.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 24, height: 24))
        }
        
        let searchButtonImage = UIImage(named: "search")
        let boardRightButton = UIButton()
        boardRightButton.setImage(searchButtonImage, for: .normal)
        boardRightButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        let searchButton = UIBarButtonItem(customView: boardRightButton)
        navigationItem.rightBarButtonItem = searchButton
        boardRightButton.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 24, height: 24))
        }
    }
    
    @objc func showBoardList() {
        let boardListVC = BoardListViewController()
        boardListVC.boardViewModel = self.boardViewModel
        boardListVC.onBoardSelected = { [weak self] board in
            self?.updateBoard(board)
        }
        
        let navigationController = UINavigationController(rootViewController: boardListVC)
        navigationController.modalPresentationStyle = .formSheet
        self.present(navigationController, animated: true, completion: nil)
    }
    
    @objc func buttonTapped() {
        guard let currentBoard = currentBoard else { return }
        let searchVC = SearchViewController(board: currentBoard)
        navigationController?.pushViewController(searchVC, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    func setupTableView() {
        tableView = UITableView(frame: self.view.bounds, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(PostCell.self, forCellReuseIdentifier: "PostCell")
        tableView.separatorStyle = .none
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setupRefreshControl() {
        // Refresh Control을 테이블 뷰에 추가
        tableView.refreshControl = refreshControl
        // 리프레시 동작 설정
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
    }
    
    @objc private func refreshData() {
        // 현재 선택된 게시판의 ID를 사용하여 데이터 로드
        guard let currentBoard = currentBoard else { return }
        postViewModel.loadPosts(boardId: currentBoard.id)
    }
    
    func bindPostViewModel() {
        // 게시글 데이터를 테이블 뷰에 바인딩
        postViewModel.dataObservable
            .observe(on: MainScheduler.instance)
            .bind(to: tableView.rx.items(cellIdentifier: "PostCell", cellType: PostCell.self)) { (row, post, cell) in
                cell.configure(with: post)
            }
            .disposed(by: disposeBag)
        
        // 에러 메시지 처리
        postViewModel.errorMessageObservable
            .subscribe(onNext: { [weak self] message in
                guard let self = self, let message = message else { return }
                let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default))
                self.present(alert, animated: true)
            })
            .disposed(by: disposeBag)
        
        // 데이터 로드 완료 후 리프레시 컨트롤 종료
        postViewModel.dataObservable
            .subscribe(onNext: { [weak self] _ in
                self?.refreshControl.endRefreshing()
            })
            .disposed(by: disposeBag)
    }
}
