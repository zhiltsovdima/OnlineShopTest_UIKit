//
//  SearchResultController.swift
//  OnlineShopTest_UIKit
//
//  Created by Dima Zhiltsov on 17.03.2023.
//

import UIKit

class SearchResultsController: UITableViewController {
    
    private var searchResults: [String] = []
    private let sourceView: UISearchBar
        
    init(_ sourceView: UISearchBar, _ searchResults: [String]) {
        self.searchResults = searchResults
        self.sourceView = sourceView
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        preferredContentSize.height = tableView.contentSize.height
    }
    
    private func setupTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: Resources.CellIdentifier.search)
        tableView.isScrollEnabled = false
        tableView.separatorStyle = .none
        tableView.backgroundColor = Resources.Colors.searchBarBackground
        let inset = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
        tableView.contentInset = inset
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Resources.CellIdentifier.search, for: indexPath)
        cell.textLabel?.text = searchResults[indexPath.row]
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        sourceView.searchTextField.text = tableView.cellForRow(at: indexPath)?.textLabel?.text
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
