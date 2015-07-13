//
//  ViewController.swift
//  GpsLocationSwift
//
//  Created by MAEDAHAJIME on 2015/07/13.
//  Copyright (c) 2015年 MAEDA HAJIME. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var labelLatitude: UILabel!
    
    @IBOutlet weak var labelLongitude: UILabel!
    
    @IBOutlet weak var labelTime: UILabel!
    
    var myLocationManager:CLLocationManager!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // 情報の更新を開始すれば、位置情報を取得
        if self.myLocationManager == nil {
            // 現在地の取得.
            self.myLocationManager = CLLocationManager()
        }
        
        self.myLocationManager.delegate = self
        
        // 承認されていない場合はここで認証ダイアログを表示します.
        // セキュリティ認証のステータスを取得.
        let status = CLLocationManager.authorizationStatus()
        if(status == CLAuthorizationStatus.NotDetermined) {
            
            println("didChangeAuthorizationStatus:\(status)");
            // NSLocationWhenInUseUsageDescriptionに設定したメッセージでユーザに確認
            self.myLocationManager.requestWhenInUseAuthorization()
            // NSLocationAlwaysUsageDescriptionに設定したメッセージでユーザに確認
            self.myLocationManager.requestAlwaysAuthorization()
        }
        
        self.myLocationManager.startUpdatingLocation()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // GPSで位置情報の更新(成功)があったときに呼ばれるデリゲート.
    func locationManager(manager: CLLocationManager!,didUpdateLocations locations: [AnyObject]!){
        
        var location = locations.last as! CLLocation    // Swift 1.2
        
        // 緯度 %+.6f
        var latitude:NSString = String(format: "%+.06f", location.coordinate.latitude)
        // 経度 %+.6f
        var longitude:NSString = String(format: "%+.06f", location.coordinate.longitude)
        
        labelLatitude.text = latitude as String
        labelLongitude.text = longitude as String
        
        // 日時時間
        var df:NSDateFormatter = NSDateFormatter()
        df.dateFormat = "yyyy/MM/dd HH:mm:ss"
        var timestamp:NSString = df.stringFromDate(location.timestamp)
        println("\(timestamp) \(latitude) \(longitude)")
        
        labelTime.text = timestamp as String
        
    }

    // 位置情報取得失敗時に呼ばれるデリゲート.
    func locationManager(manager: CLLocationManager!,didFailWithError error: NSError!){
        print("error")
    }

}

