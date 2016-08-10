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
class RepoResultsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, SettingsViewControllerDelegate {

  var searchBar: UISearchBar!
  var searchSettings = GithubRepoSearchSettings()

  var repos: [GithubRepo]!

  var settings = Settings()

  @IBOutlet weak var tableView: UITableView!

  override func viewDidLoad() {
    super.viewDidLoad()

    // Initialize the UISearchBar
    searchBar = UISearchBar()
    searchBar.delegate = self

    tableView.delegate = self
    tableView.dataSource = self
    tableView.rowHeight = UITableViewAutomaticDimension
    tableView.estimatedRowHeight = 160

    // Add SearchBar to the NavigationBar
    searchBar.sizeToFit()
    navigationItem.titleView = searchBar

    // Perform the first search when the view controller first loads
    doSearch()
  }

  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return repos?.count ?? 0
  }

  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("ResultTableViewCell", forIndexPath: indexPath) as! ResultTableViewCell

    let repo = repos[indexPath.row]
    cell.repo = repo
    return cell
  }

  func settingsViewController(settingsViewController: SettingsViewController, valueToChange: Settings) {
    self.settings = valueToChange
    doSearch()
  }

  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {

    let navigationViewController = segue.destinationViewController as! UINavigationController
    let settingsViewController = navigationViewController.topViewController as! SettingsViewController
    settingsViewController.delegate = self
    settingsViewController.currentSettings = settings
    
  }

  // Perform the search.
  private func doSearch() {

    MBProgressHUD.showHUDAddedTo(self.view, animated: true)
    searchSettings.minStars = settings.minStars
    // Perform request to GitHub API to get the list of repositories
    GithubRepo.fetchRepos(searchSettings, successCallback: { (newRepos) -> Void in

      // Print the returned repositories to the output window
      for repo in newRepos {
        print(repo)
      }

      self.repos = newRepos
      self.tableView.reloadData()

      MBProgressHUD.hideHUDForView(self.view, animated: true)
      }, error: { (error) -> Void in
        print(error)
    })
  }
}

// SearchBar methods
extension RepoResultsViewController: UISearchBarDelegate {

  func searchBarShouldBeginEditing(searchBar: UISearchBar) -> Bool {
    searchBar.setShowsCancelButton(true, animated: true)
    return true;
  }

  func searchBarShouldEndEditing(searchBar: UISearchBar) -> Bool {
    searchBar.setShowsCancelButton(false, animated: true)
    return true;
  }

  func searchBarCancelButtonClicked(searchBar: UISearchBar) {
    searchBar.text = ""
    searchBar.resignFirstResponder()
  }

  func searchBarSearchButtonClicked(searchBar: UISearchBar) {
    searchSettings.searchString = searchBar.text
    searchBar.resignFirstResponder()
    doSearch()
  }

}