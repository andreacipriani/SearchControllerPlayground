import UIKit

class FirstViewController: UIViewController {

    var uiSearchController: UISearchController!
    var secondViewController: SecondViewController!
    var items: [String]!

    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        automaticallyAdjustsScrollViewInsets = false
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.title = "FirstViewController"
        setupDataSource()
        setupSearch()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    private func setupDataSource() {
        items = Array(0...1000).map{ String($0) }
        secondViewController = storyboard!.instantiateViewController(withIdentifier: "SecondViewController") as! SecondViewController
        secondViewController.items = items
    }

    private func setupSearch() {
        uiSearchController = UISearchController(searchResultsController: secondViewController)
        uiSearchController.searchResultsUpdater = secondViewController
        uiSearchController.dimsBackgroundDuringPresentation = false
        uiSearchController.definesPresentationContext = true

        let searchBar = uiSearchController!.searchBar
        searchBar.searchBarStyle = .minimal

        if #available(iOS 11, *) {
            navigationItem.searchController = uiSearchController
            uiSearchController.hidesNavigationBarDuringPresentation = true
            navigationItem.hidesSearchBarWhenScrolling = false
        } else {
            navigationItem.titleView = uiSearchController.searchBar
            uiSearchController.hidesNavigationBarDuringPresentation = false // Can't hide the navigation bar if the search bar is in the title view because it would disappear
        }
    }
}

extension FirstViewController: UITableViewDelegate, UITableViewDataSource {

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.textLabel!.text = items[indexPath.row]
        return cell
    }
}
