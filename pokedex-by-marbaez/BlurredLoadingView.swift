//
//  BlurredLoadingView.swift
//  pokedex-by-marbaez
//
//  Created by Marcos Báez Gutiérrez on 9/8/16.
//  Copyright © 2016 marbaez. All rights reserved.
//

import UIKit

class BlurredLoadingView: UIVisualEffectView {
    
    @IBOutlet weak var loadImg: UIImageView!
    @IBOutlet weak var loadLbl: UILabel!

    
    init() {
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.Dark)
        super.init(effect: blurEffect)
        self.alpha = 1
        self.autoresizingMask = [.FlexibleWidth, .FlexibleHeight] // for supporting device rotation
    }
    
    override init(effect: UIVisualEffect?) {
        super.init(effect: effect)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func startLoadingAnimation() {
        loadImg.alpha = 0
        UIView.animateWithDuration(2.0, delay: 0, options: [.Repeat, .Autoreverse], animations: {
            self.loadImg.alpha = CGFloat(1)
        }, completion:nil)
    }
    
}
