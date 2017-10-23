import Foundation
import UIKit

final class SecondViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var items: [String]!
    private var filteredItems: [String]!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.title = "SecondViewController"
        filteredItems = items

        edgesForExtendedLayout = [] //This is key when hidesNavigationBarDuringPresentation is true; without it the view controller's view overlaps the navigation bar
    }
}

extension SecondViewController: UITableViewDelegate, UITableViewDataSource {

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredItems.count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.textLabel!.text = filteredItems[indexPath.row]
        return cell
    }
}

extension SecondViewController: UISearchResultsUpdating {

    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text, searchText.count > 0 else { return }
        filteredItems = items.filter { $0.range(of: searchText) != nil }
        print("update search results for \(searchText) - items are now: \(filteredItems)")
        tableView.reloadData()
    }
}
