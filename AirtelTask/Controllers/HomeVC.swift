//
//  HomeVC.swift
//  Copyright © 2020 Shahul. All rights reserved.
//

import UIKit

class HomeVC: UIViewController {
    private var isAPIInProgress:Bool = true
    private let spinner = UIActivityIndicatorView(style: .medium)
    let vm = ViewModel()
    var searchView:SearchSuggestionsView?
    private var searchHeightCons:NSLayoutConstraint?
    @IBOutlet weak var tblView:UITableView!
    @IBOutlet weak var searchBar:UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addVMListners()
        addLoader()
        addSearchView()
    }
    
    private func addVMListners() {
        vm.didGetResponse = { [unowned self] in
            self.updateSearchHeight()
            self.updateAfterGettingResponse()
            if self.vm.arrData.count == 0 {
                self.showAlert(message: Messgaes.NoResultsFound)
            }
            self.tblView.reloadData()
        }
        vm.didGetError = { [unowned self] error in
            self.updateAfterGettingResponse()
            self.showAlert(message: error )
        }    
    }
    
    private func hitAPI(text:String) -> Void {
        self.isAPIInProgress = true
        vm.fetchData(text: text)
    }
    
    private func updateAfterGettingResponse() {
        self.isAPIInProgress = false
        self.spinner.stopAnimating()
    }
    
    private func addLoader() {
        spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tblView.bounds.width, height: CGFloat(44))
        spinner.hidesWhenStopped = true
        spinner.isHidden = true
        tblView.tableFooterView = spinner
        tblView.tableFooterView?.isHidden = true
    }
    
    private func clearConents() {
        vm.removeAllContents()
        vm.setInitialValues()
        tblView.reloadData()
    }
    
    private func addSearchView() -> Void {
        if searchView == nil {
            searchView = SearchSuggestionsView(didSelectSearchItem: { [unowned self](searchSuggestionModel) in
                self.searchView?.isHidden = true
                self.clearConents()
                self.searchBar.text = searchSuggestionModel.text
                self.hitAPI(text: searchSuggestionModel.text)
            })
            self.view.addSubview(searchView ?? UIView())
            searchView?.translatesAutoresizingMaskIntoConstraints = false
            searchView?.topAnchor.constraint(equalTo: self.searchBar.bottomAnchor, constant: 0).isActive = true
            searchView?.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
            searchView?.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
            searchHeightCons = searchView?.heightAnchor.constraint(equalToConstant: searchView?.tableHeigt ?? 0)
            searchHeightCons?.isActive = true
            searchView?.isHidden = true
        }
    }
    
    private func updateSearchHeight() -> Void {
        searchHeightCons?.constant = searchView?.tableHeigt ?? 0
    }
    
    private func updateSearchView() {
        searchView?.populateData()
        updateSearchHeight()
    }
    
    @objc func ferhAfterDelay(_ searchBar: UISearchBar) {
        guard let query = searchBar.text, query.trimmingCharacters(in: .whitespaces) != "" else {
            print("nothing to search")
            return
        }
        hitAPI(text: query)
    }
}

//MARK: Tableview Delegate & Datasource
extension HomeVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vm.arrData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell =  tableView.dequeueReusableCell(withIdentifier: Constants.ImageCell, for: indexPath) as? ImageCell {
            cell.selectionStyle = .none
            cell.model = vm.arrData[indexPath.row]
            cell.updateCell()
            return cell
        }
        return UITableViewCell() //preventing crash If cell identifier changed
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if !isAPIInProgress && indexPath.row == vm.arrData.count - 1 && vm.arrData.count != 0 && !vm.isHalted() {
            let lastSectionIndex = tableView.numberOfSections - 1
            let lastRowIndex = tableView.numberOfRows(inSection: lastSectionIndex) - 1
            if indexPath.section ==  lastSectionIndex && indexPath.row == lastRowIndex {
                if let searchedText = searchBar.text {
                    tblView.tableFooterView?.isHidden = true
                    spinner.startAnimating()
                    hitAPI(text: searchedText)
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let photosVC = PhotosViewerVC.getInstance(arrData: vm.arrData, currentIndex: indexPath.row) {
            let nav = UINavigationController(rootViewController: photosVC)
            self.present(nav, animated: true, completion: nil)
        }
    }
}

//MARK: SEARCHBAR DELEGATES & METHODS
extension HomeVC:UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchView?.isHidden = false
        updateSearchView()
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchView?.isHidden = true
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            clearConents()
        } else {
            searchView?.isHidden = true
            // Below code delaying the frequent API calls while searching
            NSObject.cancelPreviousPerformRequests(withTarget: self, selector:
                #selector(self.ferhAfterDelay(_:)), object: searchBar)
            perform(#selector(self.ferhAfterDelay(_:)), with: searchBar, afterDelay: 0.75)
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        self.view.endEditing(true)
        searchView?.isHidden = true
    }
}
