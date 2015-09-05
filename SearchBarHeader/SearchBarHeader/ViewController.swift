//
//  ViewController.swift
//  SearchBarHeader
//
//  Created by Alvi Jonathan Sait on 5/09/2015.
//  Copyright (c) 2015 Alvi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var searchContainerView: UIView!

  private var headerView: HeaderView!
  private var refreshControl: UIRefreshControl!

  override func viewDidLoad() {
    super.viewDidLoad()
    self.automaticallyAdjustsScrollViewInsets = false

    headerView = NSBundle.mainBundle().loadNibNamed("HeaderView", owner: self, options: nil)[0] as? HeaderView
    headerView.frame = CGRectMake(0, 0, CGRectGetWidth(self.tableView.frame), 144)
    
    
    self.searchContainerView.hidden = true

    let headerContainerView = UIView(frame: headerView.frame)
    headerContainerView.backgroundColor = UIColor.clearColor()
    headerContainerView.addSubview(headerView)
    headerView.clipsToBounds = false

    self.tableView.tableHeaderView = headerContainerView

    self.refreshControl = UIRefreshControl()
    self.refreshControl?.addTarget(self, action: "refresh", forControlEvents: UIControlEvents.ValueChanged)
    self.tableView.addSubview(refreshControl)

    refreshControl?.bounds = CGRectMake(
      refreshControl!.bounds.origin.x,
      -CGRectGetHeight(headerView.frame),
      refreshControl!.bounds.size.width,
      refreshControl!.bounds.size.height)
  }

  func refresh() {
    sleep(3)

    if self.refreshControl!.refreshing {
      self.refreshControl?.endRefreshing()
    }
  }

}

extension ViewController: UITableViewDelegate {
  func scrollViewDidScroll(scrollView: UIScrollView) {
    var offset = scrollView.contentOffset.y

    if let headerView = self.headerView {
      let maximumHeaderOffset = CGRectGetHeight(headerView.frame) - CGRectGetHeight(headerView.searchBar.frame)
        
      if offset >= maximumHeaderOffset {
        
        println("nuninuninuu \(offset - maximumHeaderOffset) offset \(offset)")
        
        self.searchContainerView.hidden = false
        headerView.transform = CGAffineTransformMakeTranslation(0, offset - maximumHeaderOffset)
        if let searchBar = self.headerView.searchBar {
            searchContainerView.addSubview(searchBar)
            searchBar.frame = CGRectMake(0, 0, CGRectGetWidth(searchContainerView.frame), CGRectGetHeight(searchContainerView.frame))
            
            println("search bar \(searchBar) frame \(searchBar.frame)")
            
        }
      } else if (offset <= 0){
        
        println("ladidadida \(offset - maximumHeaderOffset) offset \(offset)")
        headerView.transform = CGAffineTransformMakeTranslation(0, min(offset, 0))
      } else {
        self.searchContainerView.hidden = true
        headerView.addSubview(self.headerView.searchBar)
        headerView.searchBar.frame = CGRectMake(0, 100, CGRectGetWidth(searchContainerView.frame), CGRectGetHeight(searchContainerView.frame))
//        println("search bar \(self.headerView.searchBar) frame \(self.headerView.searchBar.frame)")
        println("hello helo \(offset - maximumHeaderOffset) offset \(offset)")
      }
        
        
    }
  }
}


extension ViewController: UITableViewDataSource {
  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }

  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    // #warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 100
  }


  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = UITableViewCell()
    cell.textLabel?.text = "CELL \(indexPath.row)"
    cell.backgroundColor = UIColor.yellowColor()
    return cell
  }
}

