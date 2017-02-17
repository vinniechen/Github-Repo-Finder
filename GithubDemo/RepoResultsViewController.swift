//
//  ViewController.swift
//  GithubDemo
//
//  Created by Nhan Nguyen on 5/12/15.
//  Copyright (c) 2015 codepath. All rights reserved.
//

import UIKit
import MBProgressHUD

// Main ViewController

class RepoResultsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var repoResultsTableView: UITableView!
    
    var searchBar: UISearchBar!
    var searchSettings = GithubRepoSearchSettings()

    var repos: [GithubRepo]!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        repoResultsTableView.estimatedRowHeight = 300
        repoResultsTableView.rowHeight = UITableViewAutomaticDimension
        
       
        // Initialize the UISearchBar
        searchBar = UISearchBar()
        searchBar.delegate = self
        
        // Add SearchBar to the NavigationBar
        searchBar.sizeToFit()
        navigationItem.titleView = searchBar

        

        // Initialize the UITableView
        repoResultsTableView.dataSource = self
        //repoResultsTableView.dataSource = repos as! UITableViewDataSource?
        repoResultsTableView.delegate = self
        
        
        // Perform the first search when the view controller first loads
        doSearch()
        
        
        
        
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let repos = repos {
            return repos.count
        }
        else {
            return 0
        }
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GithubRepoCell", for: indexPath) as! GithubRepoCell
        
        let repo = repos![indexPath.row]
        
        
        cell.nameLabel.text = repo.name
        cell.ownerLabel.text = repo.ownerHandle
        let imageURL = NSURL(string: repo.ownerAvatarURL!)
        cell.ownerImage.setImageWith(imageURL as! URL)
        cell.descriptionLabel.text = repo.description
        cell.starLabel.text = "\(repo.stars)"
        cell.forkLabel.text = "\(repo.forks)"
        cell.starImage.image = UIImage(named: "star")
        cell.forkImage.image = UIImage(named: "fork")
        
        
        
        return cell
    }
    
    

    // Perform the search.
    fileprivate func doSearch() {

        MBProgressHUD.showAdded(to: self.view, animated: true)

        // Perform request to GitHub API to get the list of repositories
        GithubRepo.fetchRepos(searchSettings, successCallback: { (newRepos) -> Void in

            // Print the returned repositories to the output window
            for repo in newRepos {
                print(repo)
            }
            self.repos = newRepos
            self.repoResultsTableView.reloadData()

            MBProgressHUD.hide(for: self.view, animated: true)
            }, error: { (error) -> Void in
                print(error)
        })
    }
}

// SearchBar methods
extension RepoResultsViewController: UISearchBarDelegate {

    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.setShowsCancelButton(true, animated: true)
        return true
    }

    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.setShowsCancelButton(false, animated: true)
        return true
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.resignFirstResponder()
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchSettings.searchString = searchBar.text
        searchBar.resignFirstResponder()
        doSearch()
    }
}
