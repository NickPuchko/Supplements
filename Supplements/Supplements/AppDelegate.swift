//
//  AppDelegate.swift
//  Supplements
//
//  Created by Nikolai Puchko on 18.06.2021.
//

import UIKit
import GoogleSignIn

@main
class AppDelegate: UIResponder, UIApplicationDelegate, GIDSignInDelegate {

	var window: UIWindow?
	let userNetworkService = UserNetworkService()
	var user: User!

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		GIDSignIn.sharedInstance().clientID = "14169133748-keukuh0ultekpscrahk14spl80gtsc1d.apps.googleusercontent.com"
		GIDSignIn.sharedInstance().delegate = self
		// Override point for customization after application launch.
		window = UIWindow(frame: UIScreen.main.bounds)
		let rootViewController = LoginViewController()
		let navigationController = UINavigationController(rootViewController: rootViewController)
		navigationController.navigationBar.prefersLargeTitles = true
		window?.rootViewController = navigationController
		window?.makeKeyAndVisible()
		return true
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

//		userNetworkService.createUser(user: user.profile.name) { result in
//			print(result)
//		}
        let symptomsViewController = SymptomsViewController()
//        let vc2 = SecondViewController()
//        let vc3 = ThirdViewController()
//        let tabbarVC = UITabBarController()
//        tabbarVC.setViewControllers([symptomsViewController, vc2, vc3], animated: false)
//        
//        present(tabbarVC, animated: true)
	  (signIn.presentingViewController as? LoginViewController)?
		.navigationController?
		.pushViewController(symptomsViewController, animated: true)
        
	}
}

class SecondViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
        title = "vc2"
    }
}
class ThirdViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
        title = "vc3"
    }
}


