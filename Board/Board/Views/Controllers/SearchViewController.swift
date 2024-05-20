import UIKit
import RxSwift
import RxCocoa
import SnapKit
import Moya

class SearchViewController: UIViewController {
    
    private let searchBar = UISearchBar()
    private var currentBoard: Board!
    private let disposeBag = DisposeBag()
    private let tableView = UITableView()
    private let searchResults = BehaviorRelay<[String]>(value: [])
    private var postViewModel: ViewModel<Post, PostService>!
    private let postProvider = MoyaProvider<PostService>()

    private var resultsViewController: SearchResultsViewController!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchBar()
        setupTableView()
        view.backgroundColor = .white
    }
    
    init(board: Board) {
        super.init(nibName: nil, bundle: nil)
        currentBoard = board
        postViewModel = ViewModel<Post, PostService>(provider: postProvider)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSearchBar() {
        searchBar.placeholder = "\(currentBoard.name)에서 검색"
        searchBar.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        searchBar.showsCancelButton = true
        view.addSubview(searchBar)
        
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
        }
        
        // 취소 버튼 텍스트 변경 및 색상 변경
        DispatchQueue.main.async {
            if let cancelButton = self.searchBar.value(forKey: "cancelButton") as? UIButton {
                cancelButton.setTitle("취소", for: .normal)
                cancelButton.setTitleColor(.gray, for: .normal)
            }
        }
        
        // 취소 버튼 활성화될 때 텍스트 색상 변경
        searchBar.rx.textDidBeginEditing
            .subscribe(onNext: { [weak self] in
                if let cancelButton = self?.searchBar.value(forKey: "cancelButton") as? UIButton {
                    cancelButton.setTitleColor(.gray, for: .normal)
                }
            })
            .disposed(by: disposeBag)
        
        // 텍스트 입력시 검색 결과 업데이트
        searchBar.rx.text.orEmpty
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] query in
                self?.updateSearchResults(for: query)
            })
            .disposed(by: disposeBag)
        
        searchBar.rx.cancelButtonClicked
            .subscribe(onNext: { [weak self] in
                self?.navigationController?.popViewController(animated: true)

            })
            .disposed(by: disposeBag)
        
        definesPresentationContext = true
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        tableView.register(DefaultSearchCell.self, forCellReuseIdentifier: "DefaultSearchCell")
        tableView.register(SearchCell.self, forCellReuseIdentifier: "SearchCell")
        tableView.rowHeight = 56
        
        searchResults.asObservable()
            .subscribe(onNext: { [weak self] results in
                self?.tableView.reloadData()
            })
            .disposed(by: disposeBag)
        
        // 데이터 소스 설정
        searchResults
            .bind(to: tableView.rx.items) { tableView, row, element in
                if element.isEmpty {
                    let cell = tableView.dequeueReusableCell(withIdentifier: "DefaultSearchCell", for: IndexPath(row: row, section: 0)) as! DefaultSearchCell
                    cell.configure()
                    cell.snp.makeConstraints { make in
                        make.width.equalTo(tableView.frame.width)
                        make.height.equalTo(tableView.frame.height)
                    }
                    return cell
                } else {
                    let cell = tableView.dequeueReusableCell(withIdentifier: "SearchCell", for: IndexPath(row: row, section: 0)) as! SearchCell
                    let components = element.split(separator: ":")
                    let fixedText = String(components.first ?? "") + ":"
                    let queryText = String(components.last ?? "")
                    cell.configure(fixedText: fixedText, queryText: queryText)
                    return cell
                }
            }
            .disposed(by: disposeBag)
        
        // 셀 선택 처리
        tableView.rx.modelSelected(String.self)
            .subscribe(onNext: { model in
                print("Selected: \(model)")
                // 선택된 셀의 텍스트를 사용하여 검색 수행
                let components = model.split(separator: ":")
                let target = String(components.first ?? "")
                let query = String(components.last ?? "").trimmingCharacters(in: .whitespaces)
                
                // SearchTarget 설정
                let searchTarget: SearchTarget
                switch target {
                case "전체":
                    searchTarget = SearchTarget.All
                case "제목":
                    searchTarget = SearchTarget.Subject
                case "내용":
                    searchTarget = SearchTarget.Content
                case "작성자":
                    searchTarget = SearchTarget.Writer
                default:
                    searchTarget = SearchTarget.All
                }
                
                let postRequest = PostService.searchPosts(boardId: self.currentBoard.id, keyword: query, target: searchTarget)
                self.postViewModel.loadData(request: postRequest, sampleData: PostService.searchPosts(boardId: 28478, keyword: query, target: searchTarget).sampleData)
                // 결과를 보여줄 새로운 뷰 컨트롤러로 이동
                let resultsVC = SearchResultsViewController()
                resultsVC.viewModel = self.postViewModel
                self.navigationController?.pushViewController(resultsVC, animated: true)
            })
            .disposed(by: disposeBag)
    }
    
    private func updateSearchResults(for query: String) {
        guard !query.isEmpty else {
            searchResults.accept([""]) // DefaultSearchCell을 표시하기 위해 빈 문자열 사용
            return
        }
        let results = [
            "전체: \(query)",
            "제목: \(query)",
            "내용: \(query)",
            "작성자: \(query)"
        ]
        searchResults.accept(results)
    }
}
