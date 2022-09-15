//
//  MyPageViewController.CollectionView.swift
//  Foorun
//
//  Created by 김지훈 on 2022/09/14.
//

import UIKit
import SwiftUI
extension MyPageViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section != 1 {
            return
        }
        guard let nextVC = viewModel.getDetailViewController(index: indexPath.row) else {
            self.navigationController?.pushViewController(viewModel.getWebViewController(index: indexPath.row), animated: true)
            return
            
        }
        self.navigationController?.pushViewController(nextVC, animated: true)
        
    }
    
}

// 레아이웃
extension MyPageViewController {
    /// 컴포지셔널 레이아웃 그려주는 함수
    func createLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { (sectionNumber, env) -> NSCollectionLayoutSection? in
            
            if sectionNumber == 0 {
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(130/347.0)))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(130/347.0)), subitems: [item])
                group.contentInsets = .init(top: 10, leading: 14, bottom: 0, trailing: 14)
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .groupPaging
                return section
            } else {
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(0.14)))
                item.contentInsets = .init(top: 16.5, leading: 21, bottom: 16.5, trailing: 22)
                let group = NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(1)), subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .none
                section.contentInsets = .init(top: 8.5, leading: 0, bottom: 0, trailing: 0)
                return section
            }
        }
    }
}

// 데이터소스
extension MyPageViewController {
    enum MyPageSection: Hashable {
        case main, menu
    }
    
    enum MyPageItem: Hashable {
        case main(MyPageViewModel)
        case menu(String)
    }
    
    func configurationDataSource() {
        let mainRegistration = UICollectionView.CellRegistration<MyPageMainCell, MyPageItem> { _,_,_ in}
        let menuRegistration = UICollectionView.CellRegistration<MyPageMenuCell, MyPageItem> { _,_,_ in}
        
        dataSource = UICollectionViewDiffableDataSource(collectionView: myPageCollectionVeiw, cellProvider: { collectionView, indexPath, itemIdentifier in
            switch itemIdentifier {
            case .main(let item):
                let cell = collectionView.dequeueConfiguredReusableCell(using: mainRegistration, for: indexPath, item: itemIdentifier)
                cell.configureCell(with: item)
                cell.delegate = self
                return cell
            case .menu(let item):
                let cell = collectionView.dequeueConfiguredReusableCell(using: menuRegistration, for: indexPath, item: itemIdentifier)
                cell.configureCell(with: item)
                return cell
            }
        })
        
        performSnapshot()

    }
    func performSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<MyPageSection, MyPageItem>()
        snapshot.appendSections([.main])
        snapshot.appendItems([.main(viewModel)])
        snapshot.appendSections([.menu])
        snapshot.appendItems(viewModel.menus.map { .menu($0) })
        dataSource.apply(snapshot, animatingDifferences: false)
    }
    
}

extension MyPageViewController: MyPageMainCellDelegate {
    func goToCertificationView() {
        self.navigationController?.pushViewController(UIHostingController(rootView: CertificationView()), animated: true)
    }
    @objc
    func updateToken() {
        viewModel.updateName()
        performSnapshot()
    }
}


