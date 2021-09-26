//
//  MainButtonAction.swift
//  Gourmap
//
//  Created by hiro on 2021/07/05.
//

import Foundation
import UIKit
import MapKit

class Button: NSObject{
    func trachButton(){
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
}
