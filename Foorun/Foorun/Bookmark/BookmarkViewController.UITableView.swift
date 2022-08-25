import UIKit

extension BookmarkViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        bookmarks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: BookmarkTableViewCell.identifier,
            for: indexPath
        ) as? BookmarkTableViewCell else { return UITableViewCell() }
        
        cell.configure(bookmarks[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {

        let delete = UIContextualAction(style: .normal, title: nil) { _, _, _ in
            let restaurantId = self.bookmarks[indexPath.row].id
            self.deleteCache.append(restaurantId)
            self.delete()
            self.bookmarks.remove(at: indexPath.row)
            tableView.reloadData()
        }
        
        delete.image = UIImage(systemName: "trash")
        delete.backgroundColor = UIColor.red
        
        let swipeAction = UISwipeActionsConfiguration(actions: [delete])

        return swipeAction
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailViewController = DetailViewController(vm: DetailViewModel(id: bookmarks[indexPath.row].id))

        let nav = UINavigationController(rootViewController: detailViewController)
        nav.modalPresentationStyle = .pageSheet

        if let sheet = nav.sheetPresentationController {
           sheet.detents = [.medium(), .large()]
           present(nav, animated: true, completion: nil)
        }
        detailViewController.delegate = self
    }
}
