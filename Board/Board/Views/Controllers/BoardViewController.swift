import UIKit
import RxSwift
import RxCocoa
import SnapKit

class BoardViewController: UIViewController {
    
    private var tableView: UITableView!
    
    private var boardViewModel: BoardViewModel!
    private var postViewModel: PostViewModel!
    
    private var disposeBag = DisposeBag()
    private var searchController: UISearchController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.boardViewModel = BoardViewModel()
        self.postViewModel = PostViewModel()
        setupTableView()
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
        bindPostViewModel()
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
        print("Button was tapped")
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
    }

    func bindSearchController() {
        searchController.searchBar.rx.text.orEmpty
            .distinctUntilChanged()
            .debounce(.milliseconds(300), scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] query in
                if query.isEmpty {
                    self?.postViewModel.loadPosts(boardId: 1234)
                } else {
                    self?.postViewModel.searchPosts(boardId: 1234, keyword: query, target: SearchTarget.All)
                }
            })
            .disposed(by: disposeBag)
    }
}
