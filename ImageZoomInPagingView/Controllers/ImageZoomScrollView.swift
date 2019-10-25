//
//  ImageZoomScrollView.swift
//  ImageZoomInPagingView
//
//  Created by Harut Mikichyan on 10/25/19.
//  Copyright © 2019 Harut Mikichyan. All rights reserved.
//

import UIKit

class ImageZoomScrollView: UIScrollView {

    private var imageView: UIImageView!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        showsVerticalScrollIndicator = false
        showsHorizontalScrollIndicator = false
        delegate = self
        minimumZoomScale = 0.05
        maximumZoomScale = 2
        imageView = UIImageView(image: UIImage(named: "image.jpg"))
        imageView.contentMode = .scaleAspectFit
        imageView.frame = CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height)
        addSubview(imageView)
        
        setupDoubleTapGestureRecognizer()
    }
    
    @objc func handleDoubleTap(tap:UITapGestureRecognizer){
        if zoomScale > minimumZoomScale {
            setZoomScale(minimumZoomScale, animated: true)
        } else {
            let location = tap.location(in: imageView)
            let rect = CGRect(x: location.x, y: location.y, width: 1, height: 1)
            zoom(to: rect, animated: true)
        }
    }

    private func setupDoubleTapGestureRecognizer() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleDoubleTap(tap:)))
        tap.numberOfTapsRequired = 2
        addGestureRecognizer(tap)
    }
    
    private func centerContent() {
        let imageViewSize = imageView.frame.size
        var vertical:CGFloat = 0, horizontal:CGFloat = 0
        
        if imageViewSize.width < bounds.size.width  {
            vertical = (bounds.size.width - imageViewSize.width) / 2.0
        }

        if imageViewSize.height < bounds.size.height  {
            horizontal = (bounds.size.height - imageViewSize.height) / 2.0
        }

        contentInset = UIEdgeInsets(top: horizontal, left: vertical, bottom: horizontal, right: vertical)
    }
}

extension ImageZoomScrollView: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        centerContent()
    }
}

