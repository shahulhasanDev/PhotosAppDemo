//
//  SearchView.swift
//  AirtelTask
//
//  Created by Shahul on 21/06/20.
//  Copyright © 2020 Shahul. All rights reserved.
//

import Foundation
import UIKit

typealias SelectSearchCompletion = (SearchSuggestionModel) -> Void

class SearchSuggestionsView: UIView {
    
    //MARK: PROPERTIES
    static var cellID:String  = Constants.SuggestionCell
    private let tableView:UITableView = UITableView()
    private var didSelect:SelectSearchCompletion?
    private lazy var suggestions:[SearchSuggestionModel] = [SearchSuggestionModel]()
    let cellHeight:CGFloat = 25
    var tableHeigt:CGFloat {
        return CGFloat(suggestions.count) * cellHeight
    }
    
    //MARK: LIFE CYCLE METHODS
    init(didSelectSearchItem:@escaping SelectSearchCompletion) {
        super.init(frame: .zero)
        self.didSelect = didSelectSearchItem
        self.backgroundColor = UIColor.clear
        setupTableView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: GENERAL METHODS
    private func setupTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier:SearchSuggestionsView.cellID)
        tableView.delegate = self
        tableView.dataSource = self
        self.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        populateData()
    }
    
    func populateData() {
        suggestions.removeAll()
        suggestions.append(contentsOf: SearchManager.shared.getSuggestions())
        tableView.reloadData()
    }
}

//MARK: TABLEVIEW DATASOURCE & DELEGATES
extension SearchSuggestionsView:UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return suggestions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchSuggestionsView.cellID, for: indexPath)
        cell.textLabel?.text = suggestions[indexPath.row].text
        cell.textLabel?.font = UIFont.systemFont(ofSize: 12.0)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.didSelect?(suggestions[indexPath.row])
    }
}

