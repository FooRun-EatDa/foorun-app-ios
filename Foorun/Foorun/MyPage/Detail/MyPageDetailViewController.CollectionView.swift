//
//  MyPageDetailViewController.CollectionView.swift
//  Foorun
//
//  Created by 김지훈 on 2022/09/14.
//

import UIKit


extension MyPageDetailViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let nextVC = viewModel.getDetailViewController(index: indexPath.row) else {
            self.navigationController?.pushViewController(viewModel.getWebViewController(index: indexPath.row), animated: true)
            return
        }
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}

// 레아이웃
extension MyPageDetailViewController {
    /// 컴포지셔널 레이아웃 그려주는 함수
    func createLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { (sectionNumber, env) -> NSCollectionLayoutSection? in
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


// 데이터소스
extension MyPageDetailViewController {
    enum MyPageDetailSection: Hashable {
        case menu
    }
    
    enum MyPageDetailItem: Hashable {
        case menu(String)
    }
    
    func configurationDataSource() {
        let menuRegistration = UICollectionView.CellRegistration<MyPageMenuCell, MyPageDetailItem> { _,_,_ in}
        
        dataSource = UICollectionViewDiffableDataSource(collectionView: myPageDetailCollectionVeiw, cellProvider: { collectionView, indexPath, itemIdentifier in
            switch itemIdentifier {
            case .menu(let item):
                let cell = collectionView.dequeueConfiguredReusableCell(using: menuRegistration, for: indexPath, item: itemIdentifier)
                cell.configureCell(with: item)
                return cell
            }
        })
        var snapshot = NSDiffableDataSourceSnapshot<MyPageDetailSection, MyPageDetailItem>()
        snapshot.appendSections([.menu])
        snapshot.appendItems(viewModel.menus.map { .menu($0) })
        dataSource.apply(snapshot, animatingDifferences: false)
                                                        
    }
}

