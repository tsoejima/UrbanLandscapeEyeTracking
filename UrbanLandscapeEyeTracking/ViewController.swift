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
    var eyePoint:CGPoint!
    
    @IBOutlet weak var nowPositionButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        labelSetting()
        self.eyeTrackController = EyeTrackController(device: Device(type: .iPhone12Pro), smoothingRange: 10, blinkThreshold: .infinity, isHidden: true)
        self.eyeTrackController.onUpdate = { [self] info in
            var labelFlame = eyePositionLabel.frame
            guard let centerEyeLookAtPoint = info?.centerEyeLookAtPoint else { return }
            eyePoint = centerEyeLookAtPoint
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
        self.view.addSubview(nowPositionButton)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    var positionIndex = 0
    @IBAction func nowPositionButton(_ sender: Any) {
        positionIndex += 1
        print("ButonPosition",positionIndex,eyePoint!,beforeCenterEyeLookAtPoint)
        var checkEyePositionLabel: UILabel!
        checkEyePositionLabel = UILabel()
        checkEyePositionLabel.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        var eyeFrame = checkEyePositionLabel.frame
        checkEyePositionLabel.center = self.view.center
        checkEyePositionLabel.textAlignment = .center
        checkEyePositionLabel.backgroundColor = .black
        checkEyePositionLabel.textColor = .white
        checkEyePositionLabel.text = "Look!"
        eyeFrame.origin.x = eyePoint.x
        eyeFrame.origin.y = eyePoint.y
        checkEyePositionLabel.frame = eyeFrame
        
        checkEyePositionLabel.isUserInteractionEnabled = true
        
        self.view.addSubview(checkEyePositionLabel)
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

