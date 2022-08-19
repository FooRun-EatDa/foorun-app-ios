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
            guard let restaurantId = self.bookmarks[indexPath.row].id else { return }
            self.deleteCache.insert(restaurantId)
            self.bookmarks.remove(at: indexPath.row)
            tableView.reloadData()
        }
        
        delete.image = UIImage(systemName: "trash")
        delete.backgroundColor = UIColor.red
        
        let swipeAction = UISwipeActionsConfiguration(actions: [delete])

        return swipeAction
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let id = bookmarks[indexPath.row].id else { return }
        
        // TODO: - 화면전환
    }
}
