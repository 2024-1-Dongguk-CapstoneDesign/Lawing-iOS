//
//  MainViewController.swift
//  Lawing-iOS
//
//  Created by 조혜린 on 5/29/24.
//

import UIKit
import AVFoundation
import CoreLocation
import CoreML
import Vision

import SnapKit

enum DetectHelmet: String {
    case helmet
    case nonHelmet
    case error
}

final class MainViewController: UIViewController {
    
    // MARK: - location Property
    
    let locationManager = CLLocationManager()
    
    // MARK: - camera Property

    // captureSession : 입력에서 출력 장치로의 데이터 흐름을 제어하는데 사용
    // captureDevice : capture하는 물리적인 device를 의미
    let captureSession = AVCaptureSession()
    var captureDevice : AVCaptureDevice? = nil
    
    // captureDevice를 통한 출력들
    // 추후에,
    // captureDevice를 통한 Input을 위에서 생성한 captureSession에 추가
    // captureDevice를 통한 Output을 위에서 생성한 captureSession에 추가
    let photoOutput = AVCapturePhotoOutput()
    let videoOutput = AVCaptureVideoDataOutput()
    
    // Input, Output이 추가된 captureSession의 객체를 받아 미리보기 화면을 구성하는 Layer
    // Layer이므로 UIView를 따로 만들어, 만든 UIView에 이 previewLayer를 부착해줘야 함
    var previewLayer : AVCaptureVideoPreviewLayer?
    
    // captureSession을 위한 백그라운드 큐 생성
    let sessionQueue = DispatchQueue(label: "session queue")
    
    private var drawings: [CAShapeLayer] = []
    private var labels: [UILabel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLocationManager()
        setupCaptureDevice()
        setupCaptureSession()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        getCameraFrames()
        startSession()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        stopSession()
    }
}

// MARK: - Connect Camera

private extension MainViewController {
    // 카메라를 통해 VideoOutput 세팅 후 Session에 연결
    // 이를 통해 실시간으로 Video Frame을 처리할 수 있는 환경 준비됨
    func getCameraFrames() {
        
        // 1. video frame의 픽셀 형식 지정 (각 픽셀이 32비트, BGRA순으로 저장)
        // 2. 처리 속도가 느려지면 늦게 도착한 video frame 폐기
        // 3. VideoOutput의 sampleBuffer 델리게이트 세팅
        //    여기서 프레임 처리를 위한 큐가 필요한데, 이 역시 지정해줌
        
        videoOutput.videoSettings = [(kCVPixelBufferPixelFormatTypeKey as NSString): NSNumber(value: kCVPixelFormatType_32BGRA)] as [String: Any]
        videoOutput.alwaysDiscardsLateVideoFrames = true
        videoOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "camera_frame_processing_queue"))
        
        // VideoOutput이 Session에 추가되어있지 않다면 추가
        if !captureSession.outputs.contains(videoOutput) {
            captureSession.addOutput(videoOutput)
        }
        
        // Video 방향을 세로로 설정하기 위함
        if let connection = videoOutput.connection(with: .video), connection.isVideoOrientationSupported {
            connection.videoOrientation = .portrait
        }
    }
    
    func startSession() {
        sessionQueue.async { [weak self] in
            self?.captureSession.startRunning()
        }
    }
    
    func stopSession() {
        captureSession.stopRunning()
    }
}

private extension MainViewController {
    func clearDrawings() {
        for drawing in drawings {
            drawing.removeFromSuperlayer()
        }
        
        for label in labels {
            label.removeFromSuperview()
        }
        drawings.removeAll()
        labels.removeAll()
    }
    
    private func detectFace(image: CVPixelBuffer) {
        let faceDetectionRequest = VNDetectFaceLandmarksRequest { [weak self] vnRequest, error in
            DispatchQueue.main.async { [weak self] in
                guard let self else { return }
                if let results = vnRequest.results as? [VNFaceObservation], results.count > 0 {
                    self.handleFaceDetectionResults(observedFaces: results, pixelBuffer: image)
                }
            }
        }
        
        let imageResultHandler = VNImageRequestHandler(cvPixelBuffer: image, orientation: .leftMirrored, options: [:])
        try? imageResultHandler.perform([faceDetectionRequest])
    }
    
    func handleFaceDetectionResults(observedFaces: [VNFaceObservation], pixelBuffer: CVPixelBuffer) {
        
        clearDrawings()
        
        guard let previewLayer = previewLayer else {
            return
        }
        for faceObservation in observedFaces {
            
            let faceBoundingBoxOnScreen = previewLayer.layerRectConverted(fromMetadataOutputRect: faceObservation.boundingBox)
            let faceBoundingBoxPath = CGPath(rect: faceBoundingBoxOnScreen, transform: nil)
            let faceBoundingBoxShape = CAShapeLayer()
            
            faceBoundingBoxShape.strokeColor = UIColor.green.cgColor
            faceBoundingBoxShape.path = faceBoundingBoxPath
            faceBoundingBoxShape.fillColor = UIColor.clear.cgColor
            view.layer.addSublayer(faceBoundingBoxShape)
            drawings.append(faceBoundingBoxShape)
            
            // 얼굴 인식된 부분을 CIImage로 추출
            let ciImage = CIImage(cvPixelBuffer: pixelBuffer)
            let width = CGFloat(CVPixelBufferGetWidth(pixelBuffer))
            let height = CGFloat(CVPixelBufferGetHeight(pixelBuffer))
            
            // faceObservation.boundingBox는 정규화된 좌표 (0.0 - 1.0)를 사용하므로 실제 크기로 변환
            var faceRect = CGRect(
                x: faceObservation.boundingBox.origin.x * width,
                y: (1 - faceObservation.boundingBox.origin.y - faceObservation.boundingBox.height) * height,
                width: faceObservation.boundingBox.width * width,
                height: faceObservation.boundingBox.height * height
            )
            
            // faceRect 중심점 계산
            let centerX = faceRect.midX
            let centerY = faceRect.midY
            
            // 새로운 크기 계산 (1.5배)
            let newWidth = faceRect.width * 1.5
            let newHeight = faceRect.height * 1.5
            
            // 새로운 faceRect 생성
            faceRect = CGRect(
                x: centerX - newWidth / 2,
                y: centerY - newHeight / 2,
                width: newWidth,
                height: newHeight
            )
            
            
            // 얼굴 부분만 자른 CIImage 생성
            let croppedImage = ciImage.cropped(to: faceRect)
            
            // 자른 얼굴 부분으로 helmet detect
            detectHelmet(image: croppedImage) { [weak self] result in
                let label = UILabel()
                
                switch result {
                case .helmet:
                    label.textColor = .black
                    label.backgroundColor = UIColor.green
                default:
                    label.textColor = .white
                    label.backgroundColor = UIColor.systemRed
                }
                label.text = "\(result.rawValue)"
                label.sizeToFit()
                
                // UILabel 위치 설정
                let labelX = faceBoundingBoxOnScreen.origin.x
                let labelY = faceBoundingBoxOnScreen.origin.y - label.frame.height
                label.frame.origin = CGPoint(x: labelX, y: labelY)
                
                // UILabel을 view에 추가
                self?.view.addSubview(label)
                self?.labels.append(label)
            }
        }
    }
    
    private func detectHelmet(image: CIImage, completion: @escaping (DetectHelmet) -> Void) {
        // coreML 생성
        guard let coreMLModel = try? lawingHelmet3(configuration: MLModelConfiguration()),
              let visionModel = try? VNCoreMLModel(for: coreMLModel.model) else {
            fatalError("Loading CoreML Model Failed")
        }
        
        // request 생성
        let request = VNCoreMLRequest(model: visionModel) { [weak self] request, error in
            guard error == nil else {
                fatalError("Failed Request")
            }
            
            // 식별자의 이름을 확인하기 위해 VNClassificationObservation로 변환
            guard let classification = request.results as? [VNClassificationObservation] else {
                fatalError("Faild convert VNClassificationObservation")
            }
            
            // 머신러닝을 통한 결과값 프린트
            //                        print("🔥\(classification)")
            if let fitstItem = classification.first {
                if fitstItem.identifier.capitalized.lowercased() == "helmet" {
                    //                    self?.isDetectHelmet = true
                    completion(.helmet)
                } else if fitstItem.identifier.capitalized.lowercased() == "nonhelmet" {
                    //                    self?.isDetectHelmet = false
                    completion(.nonHelmet)
                } else {
                    print("감지 실패")
                    completion(.error)
                }
            }
        }
        
        // 이미지를 받아와서 perform을 요청하여 분석한다. (Vision 프레임워크)
        let handler = VNImageRequestHandler(ciImage: image)
        do {
            try handler.perform([request])
        } catch {
            print(error)
            completion(.error)
        }
    }
}

private extension MainViewController {
    func setupLocationManager() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
    }
    
    // MARK: - captureDevice Setting
    
    func setupCaptureDevice() {
        // 우선적으로 전면의 dualCamera로 CaptureDevice 세팅,
        // 없다면 wideAngleCamera로 CaptureDevice 세팅
        if let device = AVCaptureDevice.default(.builtInDualCamera,
                                                for: .video,
                                                position: .front) {
            captureDevice = device
        } else if let device = AVCaptureDevice.default(.builtInWideAngleCamera,
                                                       for: .video,
                                                       position: .front) {
            captureDevice = device
        } else {
            fatalError("Missing expected back camera device.")
        }
    }
    
    // MARK: - captureSession Setting
    
    func setupCaptureSession() {
        guard let captureDevice else { return }
        
        // captureSession의 preset을 photo로 세팅
        captureSession.sessionPreset = AVCaptureSession.Preset.photo
        do {
            // captureDevice의 Input 세팅
            try captureSession.addInput(AVCaptureDeviceInput(device: captureDevice))
            
            // captureDevice의 Output 세팅
            if captureSession.canAddOutput(photoOutput) {
                captureSession.addOutput(photoOutput)
            }
            
        }
        catch {
            print("error: \(error.localizedDescription)")
        }
        
        // 위에서 세팅한 CaptureSession을 PreviewLayer에 넣어줌
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        guard let previewLayer else { return }
        previewLayer.frame = UIScreen.main.bounds
        previewLayer.videoGravity = .resizeAspectFill
        view.layer.addSublayer(previewLayer)
//        setupLayout()
        
        // captureSession의 변경사항을 적용(커밋)하는 코드
        captureSession.commitConfiguration()
    }
}

extension MainViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let currentLocation = locations.last else { return }
        let currentSpeed = currentLocation.speed
        
        print("Current Speed: \(currentSpeed) m/s")
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location update failed: \(error.localizedDescription)")
    }
}

// MARK: - AVCaptureVideoDataOutputSampleBufferDelegate

extension MainViewController: AVCaptureVideoDataOutputSampleBufferDelegate {
    // 실시간으로 video frame을 받아올 때마다 실행됨
    func captureOutput(_ output: AVCaptureOutput,
                       didOutput sampleBuffer: CMSampleBuffer,
                       from connection: AVCaptureConnection) {
        guard let frame = CMSampleBufferGetImageBuffer(sampleBuffer) else {
            return
        }
        detectFace(image: frame)
    }
}
