import UIKit
import Flutter
import AVFoundation
//import AudioKit
//import AudioKitEX
//import SoundpipeAudioKit

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
//    let engine = AVAudioEngine()
//    let speedControl = AVAudioUnitVarispeed()
//    let pitchControl = AVAudioUnitTimePitch()
//    let audioPlayer = AVAudioPlayerNode()
    
//         let engine = AudioEngine()
//        let player = AudioPlayer()
       
        // let buffer: AVAudioPCMBuffer
    
//        let engine = AudioEngine()
//        var player = AudioPlayer()

    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        let controller: FlutterViewController = window?.rootViewController as! FlutterViewController
        let channel = FlutterMethodChannel(name: "flutter-ios-audio-channel", binaryMessenger: controller.binaryMessenger)
        channel.setMethodCallHandler({
            [weak self] (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
            print("Received method call: \(call.method)")
            
            guard call.method == "changePitch" else {
                result(FlutterMethodNotImplemented)
                return
            }
            
            if let args = call.arguments as? [String: Any],
               let pitch = args["pitch"] as? Double {
                self?.changePitch(pitch: pitch)
                result(nil)
            } else {
                print("Invalid pitch argument")
                result(FlutterError(code: "INVALID_ARGUMENT", message: "Missing or invalid pitch argument", details: nil))
            }
        })

        GeneratedPluginRegistrant.register(with: self)
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    func changePitch(pitch: Double) {
        print("Received pitch value: \(pitch)")
            
//        let filter = NewPitch(player.engine?.outputNode)
//        filter.stop()
//        engine.output = filter
//        filter.pitch = Float(pitch)
//        filter.start()
//        filter.play()
//        dryWetMixer.balance = Float(pitch)
//        dryWetMixer.start()
        
        

//        if !engine.isRunning {
//            do {
//                // Attach audioPlayer and other controls
//                engine.attach(audioPlayer)
//                engine.attach(pitchControl)
//                engine.attach(speedControl)
//                
//                // Arrange the parts so that output from one is input to another
//                engine.connect(audioPlayer, to: speedControl, format: nil)
//                engine.connect(speedControl, to: pitchControl, format: nil)
//                engine.connect(pitchControl, to: engine.mainMixerNode, format: nil)
//                
//                // Start the engine
//                try engine.start()
//                
//                print("Engine started successfully.")
//            } catch {
//                // Handle any errors that occur during attachment or engine start
//                print("Error occurred: \(error)")
//                return
//            }
//        }
//
//        // Set the pitch
//        pitchControl.pitch = Float(pitch)
        
        
        
        print("Pitch Changed: \(pitch)")
    }


}
