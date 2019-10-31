// SPDX-License-Identifier: MPL-2.0
// Copyright © 2019 Mozilla Corporation. All Rights Reserved.

import UIKit

class CityVPNCell: UITableViewCell {

    static let height: CGFloat = 55.0

    @IBOutlet var cityLabel: UILabel!
    @IBOutlet var radioImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        styleViews()
    }

    private func styleViews() {
        contentView.backgroundColor = UIColor.backgroundOffWhite
        cityLabel.font = UIFont.connectionCityCellFont
        cityLabel.textColor = UIColor.guardianBlack
    }
}
