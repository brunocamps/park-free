//
//  ImageView.swift
//  ParkFree
//
//  Created by Bruno Campos on 1/25/18.
//  Copyright © 2018 Bruno Campos. All rights reserved.
//

import UIKit
import MapKit

class ImageView: UIImageView {

    //Change default controls (awake from nib)
    override func awakeFromNib() {
        self.layer.cornerRadius = self.frame.height / 2
        self.layer.shadowRadius = 20
        self.layer.shadowOpacity = 0.5
        self.layer.shadowColor = UIColor.black.cgColor
    }

}
