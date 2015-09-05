//
//  HeaderView.swift
//  SearchBarHeader
//
//  Created by Alvi Jonathan Sait on 5/09/2015.
//  Copyright (c) 2015 Alvi. All rights reserved.
//

import UIKit

class HeaderView: UIView {

  @IBOutlet weak var searchBar: UISearchBar! {
    didSet {
      searchBar.delegate = self
    }
  }
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}

extension HeaderView: UISearchBarDelegate {

  func searchBarCancelButtonClicked(searchBar: UISearchBar) {
    searchBar.resignFirstResponder()
  }

}
