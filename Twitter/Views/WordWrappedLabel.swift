//
//  WordWrappedLabel.swift
//  Twitter
//
//  Created by Randy Ting on 10/3/15.
//  Copyright © 2015 Randy Ting. All rights reserved.
//

import UIKit

class WordWrappedLabel: UILabel {

  override func layoutSubviews() {
    super.layoutSubviews()
    
    let availableLabelWidth = self.frame.size.width
    self.preferredMaxLayoutWidth = availableLabelWidth
    
    super.layoutSubviews()
  }
  
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
