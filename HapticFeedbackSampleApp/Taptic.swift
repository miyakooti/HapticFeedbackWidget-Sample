//
//  Taptic.swift
//  HapticFeedbackSampleApp
//
//  Created by Arai, Kosuke | ECMPD on 2022/03/16.
//

//
//  Taptic.swift
//  ROOM
//
//  Created by Fukuyama, Shingo on 2018/02/19.
//

import UIKit
import AudioToolbox

final class Taptic: NSObject {
    
    static private var modelName: String = {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        return identifier
    }()
    
    // iPhone6s or iPhone6s Plus. Devices: https://www.theiphonewiki.com/wiki/Models
    static private var isOldHapticDevice: Bool {
        let name = Taptic.modelName
        return (name == "iPhone8,1" || name == "iPhone8,2")
    }
    
    private override init() {}
    
    static func likeOrUnlikeHapticFeedback(isLiked: Bool) {
        print(Taptic.modelName)
        print(isOldHapticDevice)
        if isOldHapticDevice {
            isLiked ? AudioServicesPlaySystemSound(1519) : AudioServicesPlaySystemSound(1521)
        } else {
            isLiked ? Taptic.notificationSuccess() : Taptic.impactLight()
        }
    }

    static private func notification(with style: UINotificationFeedbackGenerator.FeedbackType) {
        let taptic = UINotificationFeedbackGenerator()
        taptic.prepare()
        taptic.notificationOccurred(style)
    }

    static func notificationError() {
        Taptic.notification(with: .error)
    }

    static func notificationWarning() {
        Taptic.notification(with: .warning)
    }

    static func notificationSuccess() {

        Taptic.notification(with: .success)
    }

    static private func impact(with style: UIImpactFeedbackGenerator.FeedbackStyle) {
        let taptic = UIImpactFeedbackGenerator(style: style)
        taptic.prepare()
        taptic.impactOccurred()
    }

    static func impactLight() {
        print("あああ")
        Taptic.impact(with: .light)
    }

    static func impactMedium() {
        Taptic.impact(with: .medium)
    }

    static func impactHeavy() {
        Taptic.impact(with: .heavy)
    }

    static func selection() {
        let taptic = UISelectionFeedbackGenerator()
        taptic.prepare()
        taptic.selectionChanged()
    }

}
