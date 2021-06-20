//
//  AppDelegate.swift
//  Supplements
//
//  Created by Nikolai Puchko on 18.06.2021.
//

import UIKit
import GoogleSignIn
import SwipeableTabBarController

@main
class AppDelegate: UIResponder, UIApplicationDelegate, GIDSignInDelegate {

	weak var symptomsModel: SymptomsModel!
	var window: UIWindow?
	let userNetworkService = UserNetworkService()
	var user: User!
	let tabBar = SwipeableTabBarController()
	private var isUserOld: Bool {
		if UserDefaults.standard.bool(forKey: "isUserOld") {
			return true
		} else {
			return false
		}
	}
	

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		GIDSignIn.sharedInstance().clientID = "14169133748-keukuh0ultekpscrahk14spl80gtsc1d.apps.googleusercontent.com"
		GIDSignIn.sharedInstance().delegate = self
		// Override point for customization after application launch.
		start()
		return true
	}

	func start() {
		window = UIWindow(frame: UIScreen.main.bounds)
		window?.backgroundColor = .white
		let rootViewController = LoginViewController()
		let navigationController = UINavigationController(rootViewController: rootViewController)
		navigationController.navigationBar.prefersLargeTitles = true
		window?.rootViewController = navigationController
		window?.makeKeyAndVisible()
	}

	@available(iOS 9.0, *)
	func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any]) -> Bool {
	  return GIDSignIn.sharedInstance().handle(url)
	}

	func application(_ application: UIApplication,
					 open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
	  return GIDSignIn.sharedInstance().handle(url)
	}

	func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!,
			  withError error: Error!) {
	  if let error = error {
		if (error as NSError).code == GIDSignInErrorCode.hasNoAuthInKeychain.rawValue {
		  print("The user has not signed in before or they have since signed out.")
		} else {
		  print("\(error.localizedDescription)")
		}
		return
	  }
		self.user = User(contract: GoogleUser(
							id: user.userID,
							fullname: user.profile.name,
							email: user.profile.email))
	    let imageURL = user.profile.imageURL(withDimension: 128)!
		if let imageData = try? Data(contentsOf: imageURL) {
			self.user.image = UIImage(data: imageData)
		}

		if isUserOld {
			launch(with: nil)
		} else {
			let welcomeScreen = FormViewController()
			(signIn.presentingViewController as? LoginViewController)?
			  .navigationController?
			  .pushViewController(welcomeScreen, animated: true)
		}
	}

	func launch(with deficits: [Deficit]?) {
		let todayViewController = TodayViewController()
		let blogViewController = BlogViewController()
		let deficitViewController = ConstructureViewController()
		let profileViewController = UIViewController()

		let todayItem = UITabBarItem(title: "Сегодня", image: UIImage(named: "today"), tag: 0)
		let blogItem = UITabBarItem(title: "Блог", image: UIImage(named: "blog"), tag: 1)
		let deficitItem = UITabBarItem(title: "Добавки", image: UIImage(named: "deficit"), tag: 2)
		let profileItem = UITabBarItem(title: "Профиль", image: UIImage(named: "profile"), tag: 3)

		todayViewController.tabBarItem = todayItem
		blogViewController.tabBarItem = blogItem
		deficitViewController.tabBarItem = deficitItem
		profileViewController.tabBarItem = profileItem
		tabBar.setViewControllers([todayViewController, blogViewController, deficitViewController, profileViewController], animated: true)
		tabBar.selectedViewController = deficitViewController
		tabBar.tabBar.tintColor = .systemYellow
		tabBar.tabBar.backgroundColor = UIColor.clear
		tabBar.tabBar.backgroundImage = UIImage()
		tabBar.tabBar.shadowImage = UIImage()
		window?.rootViewController = tabBar

		if let _ = deficits {
			let def = DeficitViewController()
			tabBar.present(def, animated: true, completion: nil)
		}

	}
}
