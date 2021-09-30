//
//  ModelViewController.swift
//  3DCollection
//
//  Created by João Pedro Picolo on 30/09/21.
//

import UIKit

class ModelViewController: UIViewController {
    private let width = UIScreen.main.bounds.size.width
    private let height = UIScreen.main.bounds.size.height
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
    }
    
    private func setupLayout() {
        view.insetsLayoutMarginsFromSafeArea = false
        
        placeModelImage()
        placeModelInformation()
    }
    
    private func placeModelImage() {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: width, height: height / 3.5))
        imageView.image = UIImage(named: "saturn")
        imageView.layer.cornerRadius = imageView.frame.height / 5.5
        imageView.layer.masksToBounds = true
        
        view.addSubview(imageView)
    }
    
    private func placeModelInformation() {
        let screenHalfWidth = width / 2
        let initialY = height / 3.5
        let verticalPadding: CGFloat = 25
        let horizontalPadding: CGFloat = 20
        
        let informationView = UIView(frame: CGRect(x: 0, y: initialY + verticalPadding, width: width, height: 60))
        
        let nameView = UITextView(frame: CGRect(x: horizontalPadding, y: 0, width: screenHalfWidth, height: informationView.frame.height))
        nameView.text = "Saturn"
        nameView.font = .systemFont(ofSize: 34, weight: .bold)
        
        let button = UIButton(frame: CGRect(x: screenHalfWidth, y: 0, width: screenHalfWidth, height: informationView.frame.height))
        button.setTitle("Open Model >", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(openARView), for: .touchUpInside)
        
        informationView.addSubview(nameView)
        informationView.addSubview(button)
        view.addSubview(informationView)
    }
    
    @objc
    func openARView() {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let arViewController = storyBoard.instantiateViewController(withIdentifier: "ARViewController") as! ARViewController
        arViewController.modalPresentationStyle = .fullScreen
        arViewController.modalTransitionStyle = .flipHorizontal
        self.present(arViewController, animated: true, completion: nil)
    }
}

