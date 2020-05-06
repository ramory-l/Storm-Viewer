//
//  DetailViewController.swift
//  Project1
//
//  Created by Mikhail Strizhenov on 06.04.2020.
//  Copyright © 2020 Mikhail Strizhenov. All rights reserved.
//

import UIKit
import CoreGraphics

class DetailViewController: UIViewController {
    @IBOutlet var imageView: UIImageView!
    var selectedImage: String?
    var imageNumber: Int?
    var numberOfImages: Int?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let X = imageNumber, let Y = numberOfImages {
            title = "Picture \(X) of \(Y)"
        }
        navigationItem.largeTitleDisplayMode = .never
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
        
        if let imageToLoad = selectedImage {
            imageView.image = UIImage(named: imageToLoad)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = false
    }
    @objc func shareTapped() {
        guard let image = imageView.image else {
            print("No image found")
            return
        }
        let renderer = UIGraphicsImageRenderer(size: imageView.image!.size)
        let imageToRender = renderer.image { ctx in
            image.draw(at: .zero)
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .center
            
            let attrs: [NSAttributedString.Key: Any] = [
                .font: UIFont.systemFont(ofSize: 48),
                .paragraphStyle: paragraphStyle
            ]
            
            let string = "From Strom Viewer"
            
            let attributedString = NSAttributedString(string: string, attributes: attrs)
            
            let rectangle = CGRect(x: 0, y: 0, width: imageView.image!.size.width, height: 100)
            
            ctx.cgContext.setFillColor(UIColor.white.cgColor)
            ctx.cgContext.setStrokeColor(UIColor.black.cgColor)
            
            ctx.cgContext.setLineWidth(5)
            
            ctx.cgContext.addRect(rectangle)
            ctx.cgContext.drawPath(using: .fillStroke)
            
            attributedString.draw(with: CGRect(x: 0, y: 0, width: imageView.image!.size.width, height: 100), options: .usesLineFragmentOrigin, context: nil)
            
        }
        let vc = UIActivityViewController(activityItems: ["\(selectedImage!)", imageToRender], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }

}
