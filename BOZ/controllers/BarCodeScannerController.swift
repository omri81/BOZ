
import UIKit
import AVFoundation

protocol ScannerDelegate{
    func addItemToArray(item: String)
}

class BarCodeScannerController: UIViewController {

    
    @IBOutlet var messageLabel: UILabel!
    @IBOutlet var topbar: UIView!
    var delegate: ScannerDelegate?
    
    var captureSession = AVCaptureSession()
    
    var videoPreviewLayer: AVCaptureVideoPreviewLayer?
    var qrCodeFrameView: UIView?
    var qrString: String!
    
    private let supportedCodeTypes = [AVMetadataObject.ObjectType.upce,
                                      AVMetadataObject.ObjectType.code39,
                                      AVMetadataObject.ObjectType.code39Mod43,
                                      AVMetadataObject.ObjectType.code93,
                                      AVMetadataObject.ObjectType.code128,
                                      AVMetadataObject.ObjectType.ean8,
                                      AVMetadataObject.ObjectType.ean13,
                                      AVMetadataObject.ObjectType.aztec,
                                      AVMetadataObject.ObjectType.pdf417,
                                      AVMetadataObject.ObjectType.itf14,
                                      AVMetadataObject.ObjectType.dataMatrix,
                                      AVMetadataObject.ObjectType.interleaved2of5,
                                      AVMetadataObject.ObjectType.qr]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Get the back-facing camera for capturing videos
        let deviceDiscoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera], mediaType: AVMediaType.video, position: .back)
        
        guard let captureDevice = deviceDiscoverySession.devices.first else {
            print("Failed to get the camera device")
            return
        }
        
        do {
            // Get an instance of the AVCaptureDeviceInput class using the previous device object.
            let input = try AVCaptureDeviceInput(device: captureDevice)
            
            // Set the input device on the capture session.
            captureSession.addInput(input)
            
            // Initialize a AVCaptureMetadataOutput object and set it as the output device to the capture session.
            let captureMetadataOutput = AVCaptureMetadataOutput()
            captureSession.addOutput(captureMetadataOutput)
            
            // Set delegate and use the default dispatch queue to execute the call back
            captureMetadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            captureMetadataOutput.metadataObjectTypes = supportedCodeTypes
            //            captureMetadataOutput.metadataObjectTypes = [AVMetadataObject.ObjectType.qr]
            
        } catch {
            // If any error occurs, simply print it out and don't continue any more.
            print(error)
            return
        }
        
        // Initialize the video preview layer and add it as a sublayer to the viewPreview view's layer.
        videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        videoPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
        videoPreviewLayer?.frame = view.layer.bounds
        view.layer.addSublayer(videoPreviewLayer!)
        
        // Start video capture.
        captureSession.startRunning()
        
        // Move the message label and top bar to the front
        
        view.bringSubview(toFront: topbar)
        
        // Initialize QR Code Frame to highlight the QR code
        qrCodeFrameView = UIView()
        
        if let qrCodeFrameView = qrCodeFrameView {
            qrCodeFrameView.layer.borderColor = UIColor.green.cgColor
            qrCodeFrameView.layer.borderWidth = 2
            view.addSubview(qrCodeFrameView)
            view.bringSubview(toFront: qrCodeFrameView)
        }
    }
   
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Helper methods
    
    func launchApp(decodedURL: String) {
        
        if presentedViewController != nil {
            return
        }
        
        
      
        
        print(decodedURL)
        qrString = decodedURL
        captureSession.stopRunning()
        
        
        
      

     
        
    
        

//        let alertPrompt = UIAlertController(title: "מספר שנסרק:", message:decodedURL, preferredStyle: .actionSheet)
//        alertPrompt.addAction(UIAlertAction(title: "מסכים", style: .destructive, handler: {(confirm) in
//
//            Data1.searchRequest(term: decodedURL) { json, error  in
//                if error == nil {
//                    let next = self.storyboard!.instantiateViewController(withIdentifier: "takeVC") as! TakeVC
//                    next.addItemToArray(item: (json?.description)!)
//                    self.show(next, sender: confirm)
//
//
//                }else if error != nil{
//                    print(error)
//
//                    print("מוצר זה אינו ")
//                }
//            }
//
//        }))
//
//        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil)
//
//
//        alertPrompt.addAction(cancelAction)
//
//        present(alertPrompt, animated: true, completion: nil)
    }
    
}

extension BarCodeScannerController: AVCaptureMetadataOutputObjectsDelegate {
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        // Check if the metadataObjects array is not nil and it contains at least one object.
        if metadataObjects.count == 0 {
            qrCodeFrameView?.frame = CGRect.zero
            messageLabel.text = "No QR code is detected"
            return
        }
        
        // Get the metadata object.
        let metadataObj = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
        
        if supportedCodeTypes.contains(metadataObj.type) {
            // If the found metadata is equal to the QR code metadata (or barcode) then update the status label's text and set the bounds
            let barCodeObject = videoPreviewLayer?.transformedMetadataObject(for: metadataObj)
            qrCodeFrameView?.frame = barCodeObject!.bounds
            
            if metadataObj.stringValue != nil {
                launchApp(decodedURL: metadataObj.stringValue!)
                messageLabel.text = metadataObj.stringValue
                if qrString != nil {
                    Data1.searchRequest(term: qrString) { json, error  in
                        print(json ?? "no json")
                        if json?.description == "מוצר זה אינו ברשימה"{
                            print(json ?? "no json")
                            self.messageLabel.text = "מוצר זה אינו ברשימה"
                            self.captureSession.startRunning()
                        }
                        else{
//                            let next = self.storyboard!.instantiateViewController(withIdentifier: "takeVC") as! TakeVC
//                            next.addItemToArray(item: (json?.description)!)
//                            self.show(next, sender: self)
                            self.delegate?.addItemToArray(item: (json?.description)!)
                            self.navigationController?.popViewController(animated: true)
                        }
                        
                        
                    }
                    
                }
                
            }
        }
    }



}
