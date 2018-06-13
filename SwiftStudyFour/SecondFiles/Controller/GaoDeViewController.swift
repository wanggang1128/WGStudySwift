//
//  GaoDeViewController.swift
//  SwiftStudyFour
//
//  Created by wanggang on 2018/1/15.
//  Copyright © 2018年 wg. All rights reserved.
//

import UIKit

class GaoDeViewController: WGMainViewController {

    lazy var locationManager = AMapLocationManager()
    var mapView: MAMapView!
    let defaultLocationTimeout = 6
    let defaultRegecodeTimeout = 3
    var completionBlock: AMapLocatingCompletionBlock!
    
    //控制状态栏颜色
    fileprivate var statusBarShouldLight = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBaseView()
        setNavView()
        setToolBarView()
        initAmap()
        initCompletionBlock()
        initAmapConfigure()
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.setToolbarHidden(false, animated: false)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        navigationController?.setToolbarHidden(true, animated: false)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        if statusBarShouldLight {
            return .lightContent
        }else{
            return .default
        }
    }
    
    func setBaseView() {
        self.view.backgroundColor = UIColor.white
        self.title = "高德地图定位"
        navBarBgAlpha = 0
        navBarTintColor = .black
    }
    
    func setToolBarView() {
        let filexble = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let reGeocodeItem = UIBarButtonItem(title: "带逆地理定位", style: .plain, target: self, action: #selector(reGeocodeAction))
        let locationTtem = UIBarButtonItem(title: "不使用逆地理定位", style: .plain, target: self, action: #selector(locationAction))
        setToolbarItems([filexble,reGeocodeItem,filexble,locationTtem,filexble], animated: false)
    }
    
    func setNavView() {
        navigationItem.setRightBarButton(UIBarButtonItem(title: "clean", style: .plain, target: self, action: #selector(cleanClicked)), animated: true)
    }
    
    func initAmap() {
        mapView = MAMapView(frame: WgRect)
        mapView.delegate = self
        view.addSubview(mapView)
    }
    
    func initAmapConfigure() {
//        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
//        locationManager.pausesLocationUpdatesAutomatically = false
//        locationManager.allowsBackgroundLocationUpdates = true
        locationManager.locationTimeout = defaultLocationTimeout
        locationManager.reGeocodeTimeout = defaultRegecodeTimeout
    }
    
    @objc func reGeocodeAction() {
        navBarBgAlpha = 1
        navBarTintColor = .white
        statusBarShouldLight = false
        setNeedsStatusBarAppearanceUpdate()
        mapView.removeAnnotations(mapView.annotations)
        locationManager.requestLocation(withReGeocode: true, completionBlock: completionBlock)
    }
    
    @objc func locationAction() {
        navBarBgAlpha = 0
        navBarTintColor = .blue
        statusBarShouldLight = true
        setNeedsStatusBarAppearanceUpdate()
        mapView.removeAnnotations(mapView.annotations)
        locationManager.requestLocation(withReGeocode: false, completionBlock: completionBlock)
    }
    
    @objc func cleanClicked() {
        locationManager.stopUpdatingLocation()
        locationManager.delegate = nil
        mapView.removeAnnotations(mapView.annotations)
    }
    
    func initCompletionBlock() {
        completionBlock = { [weak self] (location: CLLocation?, regeocode: AMapLocationReGeocode?, error: Error?) in
            if let error = error {
                let error = error as NSError
                if error.code == AMapLocationErrorCode.locateFailed.rawValue {
                    //定位错误：此时location和regeocode没有返回值，不进行annotation的添加
                    NSLog("定位错误:{\(error.code) - \(error.localizedDescription)};")
                    return
                }else if error.code == AMapLocationErrorCode.reGeocodeFailed.rawValue
                    || error.code == AMapLocationErrorCode.timeOut.rawValue
                    || error.code == AMapLocationErrorCode.cannotFindHost.rawValue
                    || error.code == AMapLocationErrorCode.badURL.rawValue
                    || error.code == AMapLocationErrorCode.notConnectedToInternet.rawValue
                    || error.code == AMapLocationErrorCode.cannotConnectToHost.rawValue {
                    
                    //逆地理错误：在带逆地理的单次定位中，逆地理过程可能发生错误，此时location有返回值，regeocode无返回值，进行annotation的添加
                    NSLog("逆地理错误:{\(error.code) - \(error.localizedDescription)};")
                }else {
                    //没有错误：location有返回值，regeocode是否有返回值取决于是否进行逆地理操作，进行annotation的添加
                }
            }
            
            //根据定位信息，添加annotation
            if let location = location {
                let annotation = MAPointAnnotation()
                annotation.coordinate = location.coordinate
                
                if let regeocode = regeocode {
                    annotation.title = regeocode.formattedAddress
                    annotation.subtitle = "\(regeocode.citycode!)-\(regeocode.adcode!)-\(location.horizontalAccuracy)m"
                }
                else {
                    annotation.title = String(format: "lat:%.6f;lon:%.6f;", arguments: [location.coordinate.latitude, location.coordinate.longitude])
                    annotation.subtitle = "accuracy:\(location.horizontalAccuracy)m"
                }
                self?.addAnnotationsToMapView(annotation)
            }
        }
    }
    
    func addAnnotationsToMapView(_ annotation: MAAnnotation) {
        mapView.addAnnotation(annotation)
        mapView.selectAnnotation(annotation, animated: true)
        mapView.setZoomLevel(15.1, animated: false)
        mapView.setCenter(annotation.coordinate, animated: true)
    }
}

extension GaoDeViewController: MAMapViewDelegate {
    func mapView(_ mapView: MAMapView!, viewFor annotation: MAAnnotation!) -> MAAnnotationView! {
        if annotation is MAPointAnnotation {
            let identifier = "pointReuseIndetifier"
            var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MAPinAnnotationView
            if annotationView == nil {
                annotationView = MAPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            }
            annotationView?.canShowCallout  = true
            annotationView?.animatesDrop    = true
            annotationView?.isDraggable     = false
            annotationView?.pinColor        = .purple
            return annotationView
        }
        return nil
    }
}














