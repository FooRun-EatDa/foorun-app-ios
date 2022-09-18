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
        if indexPath.section != 1 { return }
        
        if let viewController = viewModel.makeDetailViewController(index: indexPath.row) {
            self.navigationController?.pushViewController(viewController, animated: true)
        } else {
            self.navigationController?.pushViewController(viewModel.makeWebViewController(index: indexPath.row), animated: true)
        }
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
                item.contentInsets = .init(top: 4.5, leading: 21, bottom: 4.5, trailing: 21)
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
        case profile, menu
    }
    
    enum MyPageItem: Hashable {
        case profile(MyPageViewModel)
        case menu(String)
    }
    
    func configurationDataSource() {
        let profileRegistration = UICollectionView.CellRegistration<MyPageProfileCell, MyPageItem> { _, _, _ in }
        let menuRegistration = UICollectionView.CellRegistration<MyPageMenuCell, MyPageItem> { _, _, _ in }
        
        dataSource = UICollectionViewDiffableDataSource(
            collectionView: myPageCollectionVeiw,
            cellProvider: { [weak self] collectionView, indexPath, itemIdentifier in
            switch itemIdentifier {
            case .profile(let item):
                let cell = collectionView.dequeueConfiguredReusableCell(using: profileRegistration, for: indexPath, item: itemIdentifier)
                cell.configureCell(with: item)
                cell.contentView.addGestureRecognizer(
                    UITapGestureRecognizer(
                        target: self,
                        action: #selector(self?.didTapProfileCell))
                )

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
        snapshot.appendSections([.profile])
        snapshot.appendItems([.profile(viewModel)])
        snapshot.appendSections([.menu])
        snapshot.appendItems(viewModel.menus.map { .menu($0) })
        dataSource?.apply(snapshot, animatingDifferences: false)
    }
}
