//
//  ViewController.swift
//  Gourmap
//
//  Created by hiro on 2021/06/26.
//

import UIKit
import MapKit
import CoreLocation
import NCMB
import SDWebImage

class ViewController: UIViewController {
    
    @IBOutlet var mapView: MKMapView!
    
    let viewModel: ViewModel = ViewModelImpl()
    let hottpepperModel: HotpepperModel = HotpepperModelImpl()
    let scaleRatio = 1.5
    var locationManager: CLLocationManager!
    var list: [Shop] = []
    
    let ImageHeadingUp :UIImage? = UIImage(named:"ImageHeadingUp")
    let ImageScrollMode :UIImage? = UIImage(named:"ImageScrollMode")
    let ImageNorthUp :UIImage? = UIImage(named:"ImageNorthUp")
    
    var latitudeNow: String? = ""
    var longitudeNow: String? = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.initialRealmData()
        self.navigationItem.hidesBackButton = true
        mapView.register(MKPinAnnotationView.self, forAnnotationViewWithReuseIdentifier: "custom")
        setupLocationManager()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        var region:MKCoordinateRegion = mapView.region
        region.span.latitudeDelta = 0.01
        region.span.longitudeDelta = 0.01
        mapView.setRegion(region,animated:true)
    }
    
    func setupLocationManager() {
        locationManager = CLLocationManager()
        guard let locationManager = locationManager else { return }
        locationManager.requestWhenInUseAuthorization()
        let status = CLLocationManager.authorizationStatus()
        if status == .authorizedWhenInUse {
            locationManager.delegate = self
            locationManager.distanceFilter = 10
            locationManager.startUpdatingLocation()
        }
    }
    //##########検索ボタン操作の定義##########
    @IBAction func startSearchShop(_ sender: Any) {
        
        guard let lat = latitudeNow,let lng = longitudeNow else {
            return
        }
        
        viewModel.createShopData(lat: lat,lng: lng){
            switch $0 {
            case .success(let shops):
                switch shops{
                case .start:
                    print("開始しました")
                case .shopDates(let shopPins):
                    self.mapView.addAnnotations(shopPins)
                    print("追加しました")
                case .close:
                    print("終了しました")
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
       
    // 表示スタイルの設定
    func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        // .noneを設定することで、設定したサイズでポップアップされる
        return .none
    }
}

extension ViewController: CLLocationManagerDelegate{
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.first
        latitudeNow = location?.coordinate.latitude.description
        longitudeNow = location?.coordinate.longitude.description
        guard let latNow = location?.coordinate.latitude, let lngNow = location?.coordinate.longitude else { return }
        mapView.region.center.latitude = latNow
        mapView.region.center.longitude = lngNow
        mapView.setCenter((locations.last?.coordinate)!, animated: true)
    }
    
}

extension ViewController: MKMapViewDelegate{
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        }
        
        var pinView: MKPinAnnotationView = MKPinAnnotationView()
        
        if annotation is ShopPinAnnotation{
            let pinAnnotation = annotation as! ShopPinAnnotation
            let imageURL = URL(string: pinAnnotation.shop_logo_image)
            let testview = UINib(nibName: "View", bundle: .main)
            let prview = testview.instantiate(withOwner: self).first as! CustomView
            prview.customView.sd_setImage(with: imageURL, placeholderImage: nil)
            
            let reuseId = "custom"
            
            pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as! MKPinAnnotationView
            pinView.canShowCallout = true
            pinView.detailCalloutAccessoryView = prview
            pinView.rightCalloutAccessoryView = UIButton(type: UIButton.ButtonType.detailDisclosure)
        }
        return pinView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        let shopAnno = view.annotation as! ShopPinAnnotation
        let shopData = viewModel.createDetailData(anno: shopAnno)
        viewModel.registerRealmData(shop_data: shopAnno)
        self.performSegue(withIdentifier: "toDetail", sender: shopData.shop_id)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetail" {
            let detailViewController = segue.destination as! DetailViewController
            detailViewController.shop_id = sender as! String
        }
    }
}
