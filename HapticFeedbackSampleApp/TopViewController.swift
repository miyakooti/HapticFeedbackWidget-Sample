//
//  ViewController.swift
//  HapticFeedbackSampleApp
//
//  Created by Arai, Kosuke | ECMPD on 2022/03/07.
//

import UIKit
import AudioToolbox

class TopViewController: UIViewController {
    
    var i = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(btn)
        
        btn.widthAnchor.constraint(equalToConstant: 128).isActive = true
        btn.heightAnchor.constraint(equalToConstant: 128).isActive = true
        btn.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        btn.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        btn.setTitle("Tap here!", for: .normal)
        btn.setTitleColor(UIColor.red, for: .normal)
        btn.addTarget(self, action: #selector(tapped), for: .touchUpInside)
    }
    
    @objc func tapped() {
        let remain = i % 6
        
        switch remain {
        case 0:
            feedbackAndPrint(num: 1011)
        case 1:
            feedbackAndPrint(num: 1102)//like
        case 2:
            feedbackAndPrint(num: 1519)//unlike
        case 3:
            feedbackAndPrint(num: 1520)
        case 4:
            feedbackAndPrint(num: 1521)
        case 5:
            feedbackAndPrint(num: Int(kSystemSoundID_Vibrate))
            
            UserDefaults(suiteName: "group.com.rakuten.HapticFeedbackSampleApp")?.set("kousuke", forKey: "name")
            
//            let user = User(name: "kousuke", age: 21)
//
//            do {
//                let userEncoded = try JSONEncoder().encode(user)
//                print(type(of: userEncoded))
//                UserDefaults.standard.set(userEncoded, forKey: "user")
//
//            } catch {
//                print(error.localizedDescription)
//            }
            
        default:
            return
        }
        i += 1

    }
    
    func feedbackAndPrint(num: Int) {
        AudioServicesPlaySystemSound(SystemSoundID(num))
        print(num)
    }
    
}
