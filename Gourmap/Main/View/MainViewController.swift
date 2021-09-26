import UIKit
import MapKit
import CoreLocation

//CLLocationManagerDelegateプロトコルを採用
class ViewController: UIViewController, CLLocationManagerDelegate, UIGestureRecognizerDelegate,MKMapViewDelegate  {
    

    @IBOutlet var mapView: MKMapView!
    @IBOutlet var trackingButton: UIButton!
    @IBOutlet var modeButton: UIButton!
    var detail: Hotpepper?
    //var shops: [shopPinAnnotation] = []
    let viewModel: ViewModel = ViewModelImpl()
    
    let goldenRatio = 1.618
    var locationManager: CLLocationManager!
    
    //nilとは違って初期化をしているので処理が可能
    var list: [Shop] = []
    let max: Int = 10
    
    //Image Setに登録した画像を紐づける変数
    let ImageHeadingUp :UIImage? = UIImage(named:"ImageHeadingUp")
    let ImageScrollMode :UIImage? = UIImage(named:"ImageScrollMode")
    let ImageNorthUp :UIImage? = UIImage(named:"ImageNorthUp")
    
    var latitudeNow: String? = ""
    var longitudeNow: String? = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        mapView.register(MKPinAnnotationView.self, forAnnotationViewWithReuseIdentifier: "custom")
        
//        viewModel.testFunk(para1: "String型") { //para2 in
//            switch $0 {     //switch para2 {　　　para2は省略可能
//            case .success(let shops):
//                self.mapView.addAnnotations(shops)
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//        }
        
        setupLocationManager()
    }
    
    func createShopData(store: Hotpepper){
        viewModel.createShopData(store: store)
        //配列をaddAnnotationする→処理がはやくなる
        self.mapView.addAnnotations(viewModel.shops)
    }
    
    //    func createPinData(annotaions: [CustomAnnotation]){
    //        var count: Int = annotaions.count - 1
    //        for k in 0...count {
    //            annotaions[k].title = annotaions[k].
    //        }
    //    }
    
    func setupLocationManager() {
        //
        locationManager = CLLocationManager()
        //locationManagerの値がnilの時はreturnする(locationManagerが初期化に成功している場合のみ）
        guard let locationManager = locationManager else { return }
        //アプリ使用中のみ位置情報を取得する許可を得るメソッド
        locationManager.requestWhenInUseAuthorization()
        
        //アプリが位置情報サービスの使用を許可されているかどうかを示す値。
        let status = CLLocationManager.authorizationStatus()
        //許可が得られた場合のみ以下の処理を実施
        //マネージャの設定
        if status == .authorizedWhenInUse {
            //locationManagerのデリゲート先がViewControllerになる
            locationManager.delegate = self
            //位置情報を更新するペース(単位はm）
            locationManager.distanceFilter = 10
            //位置情報の取得を開始するメソッド
            //myLock.lock()
            locationManager.startUpdatingLocation()
            //myLock.unlock()
        }
        
    }
    
    //addAnnotaionしたものが画面に入ってきたら動くデリゲート
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        //決まっている
        if annotation is MKUserLocation {
            return nil
        }
        
        
        //テスト用
        //        let anno = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "anno")
        //        anno.canShowCallout = true
        //        return anno
        let imageURL = URL(string: "https://i.gyazo.com/90f50b5c0d1aa8c0b3cd0170e72ec601.png")
        var testview = UINib(nibName: "View", bundle: .main)
        var prview = testview.instantiate(withOwner: self).first as! CustomView
        prview.customView.sd_setImage(with: imageURL, placeholderImage: nil)
        //view.addSubview(prview)
        
        let pinAnnotation = annotation as! shopPinAnnotation
        //        var pinImage: UIImageView = UIImageView()
        var pinImage = CustomView()
        //let semaphore  = DispatchSemaphore(value: 1)
//        defer {
//            pinImage =  UINib(nibName: "CustomView", bundle: Bundle.main).instantiate(withOwner: self, options: nil).first as! CustomView
//            semaphore.signal()
//        }
        //事前に登録しているカスタマイズを再利用
        let reuseId = "custom"
        var pinView: MKPinAnnotationView = MKPinAnnotationView()
        pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as! MKPinAnnotationView
        
        //            return pinView
        //        }else{
        //            let pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
        pinView.canShowCallout = true
        //semaphore.wait()
        pinView.detailCalloutAccessoryView = prview
        pinView.rightCalloutAccessoryView = UIButton(type: UIButton.ButtonType.detailDisclosure)
        
        return pinView
        
        //        }
    }
    
    //現在位置が変更されると、地図の中心位置を更新
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.first
        latitudeNow = location?.coordinate.latitude.description
        longitudeNow = location?.coordinate.longitude.description
    }
    
    //タッチダウン(ボタンを押した瞬間)した時にcallする関数
    //タッチダウンでトラッキングモードを切り替える
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
    
    @IBAction func modeChange(_ sender: Any) {
        if mapView.mapType == MKMapType.standard {
            mapView.mapType = MKMapType.satellite
            modeButton.setTitle("航空", for: .normal)
        } else {
            mapView.mapType = MKMapType.standard
            modeButton.setTitle("標準", for: .normal)
        }
        
    }
    
    @IBAction func clickZoomIN(_ sender: Any) {
        DispatchQueue.main.async {
            if (0.005 < self.mapView.region.span.latitudeDelta / self.goldenRatio) {
                print("[DBG]latitudeDelta-1 : " + self.mapView.region.span.latitudeDelta.description)
                var regionSpan:MKCoordinateSpan = MKCoordinateSpan()
                regionSpan.latitudeDelta = self.mapView.region.span.latitudeDelta / self.goldenRatio
                print(self.mapView.region.span.latitudeDelta)
                self.mapView.region.span = regionSpan
                print("[DBG]latitudeDelta-2 : " + self.mapView.region.span.latitudeDelta.description)
            }
        }
    }
    
    @IBAction func clickZoomOut(_ sender: Any) {
        DispatchQueue.main.async {
            if (self.mapView.region.span.latitudeDelta * self.goldenRatio < 150.0) {
                print("[DBG]latitudeDelta-1 : " + self.mapView.region.span.latitudeDelta.description)
                var regionSpan:MKCoordinateSpan = MKCoordinateSpan()
                regionSpan.latitudeDelta = self.mapView.region.span.latitudeDelta * self.goldenRatio
                self.mapView.region.span = regionSpan
                print("[DBG]latitudeDelta-2 : " + self.mapView.region.span.latitudeDelta.description)
            }
        }
    }
    
    //検索ボタンを押したら周辺のお店を検索する
    @IBAction func startSearchShop(_ sender: Any) {
        
        //shops = viewModel.searchShop
        //①現在地の値がnilの場合に、動作を正常終了させる
        guard let lat = latitudeNow,let lng = longitudeNow else {
            return
        }
        
        var start :Int = 1
        var flag :Bool = false
        let semaphore  = DispatchSemaphore(value: 0)
        for i in 1...3 {
            if flag == true{
                break
            }
            let url = URL(string: "https://webservice.recruit.co.jp/hotpepper/gourmet/v1/?key=0d99f5ede1c5eb2c&lat=\(lat)&lng=\(lng)&range=1&order=4&format=json&start=\(start)&count=\(max)")!  //URLを生成
            print(url)
            let request = URLRequest(url: url)               //Requestを生成
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in  //非同期で通信を行う
                guard let data = data else { return }
                do {
                    let store = try JSONDecoder().decode(Hotpepper.self, from: data)
                    let object = try JSONSerialization.jsonObject(with: data, options: [])
                    self.detail = store
                    // DataをJsonに変換
                    print(store)
                    //                    self.createShopData(store: store)
                    self.viewModel.createShopData(store: store)
                    
                    //                    var annotations: [CustomAnnotation] = (self.viewModel.shops as? [CustomAnnotation])!
                    //
                    //                    //配列をaddAnnotationする→処理がはやくなる
                    //                    self.mapView.addAnnotations(annotations)
                    self.mapView.addAnnotations(self.viewModel.shops)
                    
                    self.list = self.list + store.results.shop
                    if store.results.shop.count < self.max {
                        flag = true
                    }
                    start = store.results.shop.count * i + 1
                } catch let error {
                    print(error)
                    flag = true
                }
                semaphore.signal()
            }
            task.resume()
            semaphore.wait()
        }
        
    }
}


class shopPinAnnotation: NSObject,MKAnnotation{
    
    init(latitude: CLLocationDegrees = 0.0,longitude: CLLocationDegrees = 0.0,shopName:String = "") {
        self.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    var coordinate: CLLocationCoordinate2D
    
    var api_version: String = ""
    var results_available: Int = 0
    var results_returned: String = ""
    var results_start: Int = 0
    var shop_address: String = ""
    var shop_genre: String = ""
    var shop_lat: Double = 0
    var shop_lng: Double = 0
    var shop_logo_image: String = ""
    var shop_name: String = ""
    
    var title: String? = ""
    var subtitle: String? = ""
}

//class CustomAnnotation: MKPointAnnotation,shopPinAnnotation {
//    var string: String!
//}

import SDWebImage

extension UIImageView {
    
    func setImage(with url: URL) {
        
        self.sd_setImage(with: url) { [weak self] image, error, _, _ in
            // Success
            if error == nil, let image = image {
                self?.image = image
                
                // Failure
            } else {
                // error handling
                
            }
        }
        
    }
}
