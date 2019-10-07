// SPDX-License-Identifier: MIT
// Copyright © 2018-2019 WireGuard LLC. All Rights Reserved.

import UIKit

class HomeVPNViewController: UIViewController {
    @IBOutlet var navigationTitleLabel: UILabel!
    @IBOutlet var vpnToggleView: VPNToggleView!
    @IBOutlet var selectConnectionLabel: UILabel!
    @IBOutlet var vpnSelectionView: CurrentVPNSelectorView!

    private let userManager: UserManagerProtocol
    private weak var coordinatorDelegate: NavigationProtocol?

    init(userManager: UserManagerProtocol, coordinatorDelegate: NavigationProtocol) {
        self.userManager = userManager
        self.coordinatorDelegate = coordinatorDelegate
        super.init(nibName: String(describing: HomeVPNViewController.self), bundle: Bundle.main)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
        applyLabelTexts()
        styleViews()
        addTapGesture()
    }

    private func setupTabBar() {
        tabBarItem = UITabBarItem(title: "VPN", image: UIImage(named: "tabbar_VPN"), tag: 0)
        tabBarController?.selectedIndex = 0
    }

    private func applyLabelTexts() {
        navigationTitleLabel.text = "Guardian VPN"
        selectConnectionLabel.text = "Select Connection"
    }

    private func styleViews() {
        view.backgroundColor = UIColor.backgroundOffWhite
        navigationTitleLabel.font = UIFont.navigationTitleFont
        navigationTitleLabel.textColor = UIColor.guardianBlack

        vpnToggleView.applyDropShadow()
        selectConnectionLabel.textColor = UIColor.guardianGrey
        selectConnectionLabel.font = UIFont.vpnSelectConnectionFont
    }

    private func addTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(selectVpn))
        vpnSelectionView.addGestureRecognizer(tapGesture)
    }

    // MARK: Tap Gesture
    @objc func selectVpn() {
        UIView.animate(withDuration: 0.3, animations: {
            self.vpnSelectionView.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        }, completion: { _ in
            self.coordinatorDelegate?.navigate(after: .vpnNewSelection)
            UIView.animate(withDuration: 0.7,
                           delay: 0,
                           usingSpringWithDamping: 0.4,
                           initialSpringVelocity: 6.0,
                           options: .allowUserInteraction,
                           animations: {
                            self.vpnSelectionView.transform = CGAffineTransform.identity
            }, completion: nil)
        })
    }
}
