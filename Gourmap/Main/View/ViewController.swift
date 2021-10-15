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
    @IBOutlet var trackingButton: UIButton!
    @IBOutlet var modeButton: UIButton!
    //    @IBOutlet weak var searchPickerView: UIPickerView!
    
    
    let viewModel: ViewModel = ViewModelImpl()
    let hottpepperModel: HotpepperModel = HotpepperModelImpl()
    let scaleRatio = 1.5
    var locationManager: CLLocationManager!
    var list: [Shop] = []
    //    var pickerList = ["駅名で検索","住所で検索"]
    
    let ImageHeadingUp :UIImage? = UIImage(named:"ImageHeadingUp")
    let ImageScrollMode :UIImage? = UIImage(named:"ImageScrollMode")
    let ImageNorthUp :UIImage? = UIImage(named:"ImageNorthUp")
    
    var latitudeNow: String? = ""
    var longitudeNow: String? = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        searchPickerView.dataSource = self
        //        searchPickerView.delegate = self
        
        self.navigationItem.hidesBackButton = true
        mapView.register(MKPinAnnotationView.self, forAnnotationViewWithReuseIdentifier: "custom")
        setupLocationManager()
    }
    
    //検索窓関係
    //    func numberOfComponents(in pickerView: UIPickerView) -> Int {
    //        return 1
    //    }
    //
    //    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    //        return pickerList.count
    //    }
    //
    //    func pickerView(searchPickerview: UIPickerView, titleForRow row: Int, forComponent component: Int)-> String! {
    //        return pickerList[row]
    //    }
    
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
    
    //いらないかも
    @IBAction func trackingBtnThouchDown(_ sender: AnyObject) {
        switch mapView.userTrackingMode {
        case .follow:
            mapView.userTrackingMode = .followWithHeading
            trackingButton.setImage(ImageHeadingUp, for: .normal)
            break
        case .followWithHeading:
            mapView.userTrackingMode = .none
            trackingButton.setImage(ImageScrollMode, for: .normal)
            break
        default:
            mapView.userTrackingMode = .follow
            trackingButton.setImage(ImageNorthUp, for: .normal)
            break
        }
    }
    
    //いらないかも
    @IBAction func modeChange(_ sender: Any) {
        if mapView.mapType == MKMapType.standard {
            mapView.mapType = MKMapType.satellite
            modeButton.setTitle("航空", for: .normal)
        } else {
            mapView.mapType = MKMapType.standard
            modeButton.setTitle("標準", for: .normal)
        }
        
    }
    
    //シミュレータ用
    @IBAction func clickZoomIN(_ sender: Any) {
        DispatchQueue.main.async {
            if (0.005 < self.mapView.region.span.latitudeDelta / self.scaleRatio) {
                print("lat縮小前：" + self.mapView.region.span.latitudeDelta.description)
                var regionSpan:MKCoordinateSpan = MKCoordinateSpan()
                self.mapView.userTrackingMode = .none
                regionSpan.latitudeDelta = self.mapView.region.span.latitudeDelta / self.scaleRatio
                self.mapView.region.span = regionSpan
                self.trackingButton.setImage(self.ImageScrollMode, for: .normal)
                print("lat縮小後：" + self.mapView.region.span.latitudeDelta.description)
            }
        }
    }
    
    //シミュレータ用
    @IBAction func clickZoomOut(_ sender: Any) {
        DispatchQueue.main.async {
            if (self.mapView.region.span.latitudeDelta * self.scaleRatio < 150.0) {
                print("lat拡大前：" + self.mapView.region.span.latitudeDelta.description)
                var regionSpan:MKCoordinateSpan = MKCoordinateSpan()
                self.mapView.userTrackingMode = .none
                regionSpan.latitudeDelta = self.mapView.region.span.latitudeDelta * self.scaleRatio
                self.mapView.region.span = regionSpan
                self.trackingButton.setImage(self.ImageScrollMode, for: .normal)
                print("lat拡大後：" + self.mapView.region.span.latitudeDelta.description)
            }
        }
    }
    
    // 表示スタイルの設定
    func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        // .noneを設定することで、設定したサイズでポップアップされる
        return .none
    }
    
    //    @IBAction func unwindToMain(_ unwindSegue: UIStoryboardSegue) {
    //        _ = unwindSegue.source
    //        let detailViewController = unwindSegue.source as! DetailViewController
    //    }
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
        self.performSegue(withIdentifier: "toDetail", sender: shopData.object_id)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetail" {
            let detailViewController = segue.destination as! DetailViewController
            detailViewController.shop_id = sender as! String
        }
    }
}
