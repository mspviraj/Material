/*
* Copyright (C) 2015 - 2016, Daniel Dahan and CosmicMind, Inc. <http://cosmicmind.io>.
* All rights reserved.
*
* Redistribution and use in source and binary forms, with or without
* modification, are permitted provided that the following conditions are met:
*
*	*	Redistributions of source code must retain the above copyright notice, this
*		list of conditions and the following disclaimer.
*
*	*	Redistributions in binary form must reproduce the above copyright notice,
*		this list of conditions and the following disclaimer in the documentation
*		and/or other materials provided with the distribution.
*
*	*	Neither the name of Material nor the names of its
*		contributors may be used to endorse or promote products derived from
*		this software without specific prior written permission.
*
* THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
* AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
* IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
* DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
* FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
* DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
* SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
* CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
* OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
* OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

import UIKit
import Material

class FeedViewController: UIViewController {
	/// NavigationBar title label.
	private var titleLabel: UILabel!
	
	/// NavigationBar menu button.
	private var menuButton: FlatButton!
	
	/// NavigationBar switch control.
	private var switchControl: MaterialSwitch!
	
	/// NavigationBar search button.
	private var searchButton: FlatButton!

	/// MaterialCollectionView.
	private var collectionView: MaterialCollectionView!
	
	/// Image thumbnail height.
	private var thumbnailHieght: CGFloat = 300
	
	override func viewDidLoad() {
		super.viewDidLoad()
		prepareView()
		prepareTitleLabel()
		prepareMenuButton()
		prepareSwitchControl()
		prepareSearchButton()
		prepareNavigationBar()
		prepareCollectionView()
	}
	
	override func viewWillAppear(animated: Bool) {
		super.viewWillAppear(animated)
		
		// Ensure that the SideNavigation is enabled.
		sideNavigationViewController?.enabled = true
		
		// Ensure that the NavigationBar is styled correctly.
		if let navigationbar: NavigationBar = navigationController?.navigationBar as? NavigationBar {
			navigationbar.statusBarStyle = .LightContent
			navigationbar.backgroundColor = MaterialColor.blue.base
			navigationbar.backButton.tintColor = MaterialColor.white
		}
	}
	
	override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
		super.viewWillTransitionToSize(size, withTransitionCoordinator: coordinator)
		collectionView.reloadData()
	}
	
	/// Handler for menuButton.
	internal func handleMenuButton() {
		sideNavigationViewController?.toggleLeftView()
	}
	
	/// Handler for searchButton.
	internal func handleSearchButton() {
		navigationController?.presentViewController(AppSearchBarViewController(mainViewController: SearchListViewController()), animated: true, completion: nil)
	}
	
	private func prepareView() {
		view.backgroundColor = MaterialColor.grey.lighten4
	}
	
	/// Prepares view.
	private func prepareNavigationBar() {
		navigationItem.titleLabel = titleLabel
		navigationItem.leftControls = [menuButton]
		navigationItem.rightControls = [switchControl, searchButton]
	}
	
	/// Prepares the titleLabel.
	private func prepareTitleLabel() {
		titleLabel = UILabel()
		titleLabel.text = "Recipes"
		titleLabel.textAlignment = .Left
		titleLabel.textColor = MaterialColor.white
	}
	
	/// Prepares the menuButton.
	private func prepareMenuButton() {
		let image: UIImage? = MaterialIcon.menu
		menuButton = FlatButton()
		menuButton.pulseScale = false
		menuButton.pulseColor = MaterialColor.white
		menuButton.setImage(image, forState: .Normal)
		menuButton.setImage(image, forState: .Highlighted)
		menuButton.addTarget(self, action: "handleMenuButton", forControlEvents: .TouchUpInside)
	}
	
	/// Prepares the switchControl.
	private func prepareSwitchControl() {
		switchControl = MaterialSwitch(state: .Off, style: .LightContent, size: .Small)
	}
	
	/// Prepares the searchButton.
	private func prepareSearchButton() {
		let image: UIImage? = MaterialIcon.search
		searchButton = FlatButton()
		searchButton.pulseScale = false
		searchButton.pulseColor = MaterialColor.white
		searchButton.setImage(image, forState: .Normal)
		searchButton.setImage(image, forState: .Highlighted)
		searchButton.addTarget(self, action: "handleSearchButton", forControlEvents: .TouchUpInside)
	}
	
	/// Prepares the collectionView.
	private func prepareCollectionView() {
		collectionView = MaterialCollectionView()
		collectionView.dataSource = self
		collectionView.delegate = self
		collectionView.spacingPreset = .Spacing2
		collectionView.contentInsetPreset = .Square1
		collectionView.registerClass(MaterialCollectionViewCell.self, forCellWithReuseIdentifier: "MaterialCollectionViewCell")
		
		// Layout the collectionView.
		view.addSubview(collectionView)
		collectionView.translatesAutoresizingMaskIntoConstraints = false
		MaterialLayout.alignToParent(view, child: collectionView)
	}
}

extension FeedViewController: MaterialCollectionViewDataSource {
	/// Retrieves the items for the collectionView.
	func items() -> Array<MaterialDataSourceItem> {
		return [
			MaterialDataSourceItem(
				data: [
					"title": "Summer BBQ",
					"detail": "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
					"date": "February 26, 2016",
					"image": "AssortmentOfDessert"
				],
				height: thumbnailHieght
			),
			MaterialDataSourceItem(
				data: [
					"title": "Birthday gift",
					"detail": "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
					"date": "February 26, 2016",
					"image": "AssortmentOfFood"
				],
				height: thumbnailHieght
			),
			MaterialDataSourceItem(
				data: [
					"title": "Brunch this weekend?",
					"detail": "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
					"date": "February 26, 2016",
					"image": "AvocadoIceCream"
				],
				height: thumbnailHieght
			),
			MaterialDataSourceItem(
				data: [
					"title": "Giants game",
					"detail": "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
					"date": "February 26, 2016",
					"image": "HeartCookies"
				],
				height: thumbnailHieght
			),
			MaterialDataSourceItem(
				data: [
					"title": "Recipe to try",
					"detail": "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
					"date": "February 26, 2016",
					"image": "VeganHempBalls"
				],
				height: thumbnailHieght
			),
			MaterialDataSourceItem(
				data: [
					"title": "Interview",
					"detail": "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
					"date": "February 26, 2016",
					"image": "VeganPieAbove"
				],
				height: thumbnailHieght
			)
		]
	}
	
	/// Number of sections.
	func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
		return 1
	}
	
	/// Number of cells in each section.
	func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return items().count
	}
	
	/// Retrieves a UICollectionViewCell.
	func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
		let cell: MaterialCollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier("MaterialCollectionViewCell", forIndexPath: indexPath) as! MaterialCollectionViewCell
		
		let item: MaterialDataSourceItem = items()[indexPath.item]
		
		if let data: Dictionary<String, AnyObject> =  item.data as? Dictionary<String, AnyObject> {
			
			var cardView: ImageCardView? = cell.contentView.subviews.first as? ImageCardView
			
			// Only build the template if the CardView doesn't exist.
			if nil == cardView {
				cardView = ImageCardView()
				
				cell.backgroundColor = nil
				cell.pulseColor = nil
				cell.contentView.addSubview(cardView!)
				
				
				cardView!.pulseScale = false
				cardView!.divider = false
				cardView!.depth = .None
				cardView!.contentInsetPreset = .Square2
				cardView!.contentInset.bottom /= 2
				cardView!.cornerRadius = 2
				
				let titleLabel: UILabel = UILabel()
				titleLabel.textColor = MaterialColor.grey.darken4
				titleLabel.font = RobotoFont.regularWithSize(18)
				
				cardView!.titleLabel = titleLabel
				
				let detailLabel: UILabel = UILabel()
				detailLabel.textColor = MaterialColor.grey.darken2
				detailLabel.font = RobotoFont.regular
				detailLabel.numberOfLines = 0
				
				cardView!.detailView = detailLabel
				
				cell.contentView.addSubview(cardView!)
			}
			
			// Add the data to the cardView.
			cardView?.titleLabel?.text = data["title"] as? String
			(cardView?.detailView as? UILabel)?.text = data["detail"] as? String
			
			// Asynchronously the load image.
			let height: CGFloat = 200
			dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0)) {
				let image: UIImage? = UIImage(named: data["image"] as! String)?.resize(toWidth: cell.bounds.width)?.crop(toWidth: cell.bounds.width, toHeight: height)
				dispatch_sync(dispatch_get_main_queue()) {
					cardView?.image = image
				}
			}
			
			// Adjust the cardView size.
			cardView?.frame = cell.bounds
		}
		
		return cell
	}
}

/// MaterialCollectionViewDelegate methods.
extension FeedViewController: MaterialCollectionViewDelegate {
	/// Executed when an item is selected.
	func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
		navigationController?.pushViewController(RecipesViewController(), animated: true)
	}
}