//
//  ViewController.swift
//  Board
//
//  Created by min seok Kim on 5/3/24.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

class NavigationViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
//        setupNavigationBar()
    }

    func setupNavigationBar() {
        // 네비게이션 바 배경색 설정
        navigationBar.barTintColor = UIColor(red: 255/255.0, green: 255/255.0, blue: 255/255.0, alpha: 1.0)

        // 네비게이션 바 높이 조정을 위한 더미 뷰 생성
        let dummyView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 60))
        dummyView.backgroundColor = UIColor.clear
        navigationBar.addSubview(dummyView)

        // 네비게이션 바 텍스트 속성 설정
        navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.black,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 22, weight: .medium)
        ]

        // 네비게이션 바 그림자 제거
        navigationBar.shadowImage = UIImage()
        navigationBar.setBackgroundImage(UIImage(), for: .default)
    }
}
