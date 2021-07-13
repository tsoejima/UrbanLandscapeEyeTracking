//
//  ViewController.swift
//  UrbanLandscapeEyeTracking
//
//  Created by 副島拓哉 on 2021/07/13.
//

import UIKit
import SceneKit
import ARKit
import EyeTrackKit
import SwiftUI

class ViewController: EyeTrackViewController {

    var eyeTrackController: EyeTrackController!
    var eyePositionLabel: UILabel!
    var beforeCenterEyeLookAtPoint:CGPoint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        labelSetting()
        self.eyeTrackController = EyeTrackController(device: Device(type: .iPhone12Pro), smoothingRange: 10, blinkThreshold: .infinity, isHidden: true)
        self.eyeTrackController.onUpdate = { [self] info in
            var labelFlame = eyePositionLabel.frame
            guard let centerEyeLookAtPoint = info?.centerEyeLookAtPoint else { return }
            if beforeCenterEyeLookAtPoint == nil {
                beforeCenterEyeLookAtPoint = centerEyeLookAtPoint
            }
            print(beforeCenterEyeLookAtPoint)
            let lookAtPointX = centerEyeLookAtPoint.x - beforeCenterEyeLookAtPoint.x
            let lookAtPointY = centerEyeLookAtPoint.y - beforeCenterEyeLookAtPoint.y

            labelFlame.origin.x += lookAtPointX
            labelFlame.origin.y += lookAtPointY

            eyePositionLabel.frame = labelFlame
            beforeCenterEyeLookAtPoint = centerEyeLookAtPoint
            print(info?.centerEyeLookAtPoint.x as Any, info?.centerEyeLookAtPoint.y as Any)
        }
        self.initialize(eyeTrack: eyeTrackController.eyeTrack)
        self.show()
        self.view.addSubview(eyePositionLabel)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    func labelSetting() {
            eyePositionLabel = UILabel()
            eyePositionLabel.frame = CGRect(x: 0, y: 0, width: 100, height: 50)
            eyePositionLabel.center = self.view.center
            eyePositionLabel.textAlignment = .center
            eyePositionLabel.backgroundColor = .black
            eyePositionLabel.textColor = .white
            eyePositionLabel.text = "Look!"
            eyePositionLabel.isUserInteractionEnabled = true
    }

}

