//
//  TableViewController.swift
//  SearchBarHeader
//
//  Created by Alvi Jonathan Sait on 5/09/2015.
//  Copyright (c) 2015 Alvi. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {

  private var headerView: HeaderView!

  override func viewDidLoad() {
    super.viewDidLoad()

    headerView = NSBundle.mainBundle().loadNibNamed("HeaderView", owner: self, options: nil)[0] as? HeaderView
    headerView.frame = CGRectMake(0, 0, CGRectGetWidth(self.tableView.frame), 144)

    let headerContainerView = UIView(frame: headerView.frame)
    headerContainerView.backgroundColor = UIColor.clearColor()
    headerContainerView.addSubview(headerView)

    self.tableView.tableHeaderView = headerContainerView

    self.refreshControl?.addTarget(self, action: "refresh", forControlEvents: UIControlEvents.ValueChanged)

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

  override func scrollViewDidScroll(scrollView: UIScrollView) {
    var offset = scrollView.contentOffset.y

    if let headerView = self.headerView {
      let maximumHeaderOffset = CGRectGetHeight(headerView.frame) - CGRectGetHeight(headerView.searchBar.frame)
      if offset >= maximumHeaderOffset {
        headerView.transform = CGAffineTransformMakeTranslation(0, offset - maximumHeaderOffset)
      } else if (offset <= 0){
        headerView.transform = CGAffineTransformMakeTranslation(0, min(offset, 0))
      }
    }
  }

  // MARK: - Table view data source

  override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }

  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    // #warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 100
  }


  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = UITableViewCell()
    cell.textLabel?.text = "CELL \(indexPath.row)"
    return cell
  }

  /*
  // Override to support conditional editing of the table view.
  override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
  // Return NO if you do not want the specified item to be editable.
  return true
  }
  */

  /*
  // Override to support editing the table view.
  override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
  if editingStyle == .Delete {
  // Delete the row from the data source
  tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
  } else if editingStyle == .Insert {
  // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
  }
  }
  */

  /*
  // Override to support rearranging the table view.
  override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

  }
  */

  /*
  // Override to support conditional rearranging of the table view.
  override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
  // Return NO if you do not want the item to be re-orderable.
  return true
  }
  */

  /*
  // MARK: - Navigation

  // In a storyboard-based application, you will often want to do a little preparation before navigation
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
  // Get the new view controller using [segue destinationViewController].
  // Pass the selected object to the new view controller.
  }
  */

}
