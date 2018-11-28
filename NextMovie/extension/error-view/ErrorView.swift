//
//  ErrorView.swift
//  EventGuideApp
//
//  Created by Luís Wolf on 18/11/2018.
//  Copyright © 2018 Luís Wolf. All rights reserved.
//

import UIKit

protocol ErrorViewDelegate {
    func didPressRetryButton()
}

@IBDesignable
class ErrorView: UIView {
    
    var delegate: ErrorViewDelegate?
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBInspectable var message: String! = NSLocalizedString("An unexpected error has occurred. Please try again later on.", comment: "Error view notice message") {
        didSet {
            messageLabel?.text = message
        }
    }
    var isOffline: Bool = false {
        didSet {
            if isOffline {
                iconImageView?.image = UIImage(named: "gear")
                titleLabel?.text = NSLocalizedString("No connection", comment: "Error view offline title")
                message = NSLocalizedString("You're offline. Please check your internet connection.", comment: "Error view offline message")
            } else {
                iconImageView?.image = UIImage(named: "gear")
                titleLabel?.text = NSLocalizedString("Notice", comment: "Error view notice title")
                message = NSLocalizedString("An unexpected error has occurred. Please try again later on.", comment: "Error view notice message")
            }
        }
    }
    
    private var contentView : UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetup()
    }
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        xibSetup()
        contentView?.prepareForInterfaceBuilder()
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    func xibSetup() {
        contentView = loadViewFromNib()
        contentView.frame = bounds
        contentView.autoresizingMask = [UIView.AutoresizingMask.flexibleWidth, UIView.AutoresizingMask.flexibleHeight]
        addSubview(contentView)
    }
    func loadViewFromNib() -> UIView! {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil).first as! UIView
        return view
    }
}

extension ErrorView {
    @IBAction func didPressRetryButton(_ sender: UIButton) {
        delegate?.didPressRetryButton()
    }
}
