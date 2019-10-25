//
//  ViewController.swift
//  ImageZoomInPagingView
//
//  Created by Harut Mikichyan on 10/25/19.
//  Copyright © 2019 Harut Mikichyan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    private var scrollView: UIScrollView!
    private var pageControl: UIPageControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupScrollView()
        setupPageControl()
        
        var x = 0
        let y = 0
        let width = self.scrollView.frame.size.width
        let height = self.scrollView.frame.size.height
        for _ in 1...10 {
            let imageScrollView = ImageZoomScrollView(frame: CGRect(x: CGFloat(x), y: CGFloat(y), width: width, height: height))
            scrollView.addSubview(imageScrollView)
            x = x + Int(width)
        }
    }
    
    @objc func changePage(sender:UIPageControl) {
        let offsetX = CGFloat(sender.currentPage) * CGFloat(scrollView.frame.size.width)
        scrollView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: true)
    }
    
    //MARK: - Private Interface
    private func setupScrollView() {
        scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: view.bounds.size.width, height: view.bounds.size.height - 50.0))
        scrollView.delegate = self
        scrollView.isPagingEnabled = true
        scrollView.minimumZoomScale = 0.05
        scrollView.maximumZoomScale = 2
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.contentSize = CGSize(width: 10.0*scrollView.bounds.size.width, height: 0)
        self.view.addSubview(scrollView)
    }
    
    private func setupPageControl() {
        pageControl = UIPageControl(frame: CGRect(x: 0, y: view.bounds.size.height - CGFloat(50), width: self.view.bounds.size.width, height: 50.0))
        pageControl.numberOfPages = 10
        pageControl.addTarget(self, action: #selector(changePage(sender:)), for: .valueChanged)
        pageControl.pageIndicatorTintColor = UIColor.red
        pageControl.currentPageIndicatorTintColor = UIColor.blue
        self.view.addSubview(pageControl)
    }
}

extension ViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let page = scrollView.contentOffset.x / self.scrollView.frame.size.width
        pageControl.currentPage = Int(page)
    }
}


