//
//  VoiceViewController.swift
//  SwiftStudyFour
//
//  Created by wanggang on 2017/12/25.
//  Copyright © 2017年 wg. All rights reserved.
//

import UIKit
import Speech

class VoiceViewController: WGMainViewController {

    let textView = UITextView(frame: CGRect(x: 0, y: 64, width: WgWith, height: WgHeight-49-64))
    let voiceBtn = UIButton(frame: CGRect(x: 0, y: WgHeight-49, width: WgWith, height: 49))
    
    //语音识别器
    let speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "zh_Hans_CN"))
    //语音识别请求
    var speechRecognizedRequest:SFSpeechAudioBufferRecognitionRequest?
    //识别任务
    var recognizeTask: SFSpeechRecognitionTask?
    //音频
    let audioEngine = AVAudioEngine()
    var inputNode: AVAudioInputNode!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setBaseView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        speechRecognizer?.delegate = self
        SFSpeechRecognizer.requestAuthorization { (status) in
            OperationQueue.main.addOperation {
                switch status {
                case .authorized:
                    self.voiceBtn.isEnabled = true
                case .denied:
                    self.voiceBtn.setTitle("被拒绝", for: .disabled)
                case .restricted:
                    self.voiceBtn.setTitle("被限制", for: .disabled)
                case .notDetermined:
                    self.voiceBtn.setTitle("还没决定", for: .disabled)
                }
            }
        }
    }
    
    func startRecordVoice() throws {
        
        self.inputNode = audioEngine.inputNode
        //任务正在执行则先取消任务
        if recognizeTask != nil {
            recognizeTask?.cancel()
            recognizeTask = nil
        }
        //初始化音频回话
        let audioSession = AVAudioSession.sharedInstance()
        try audioSession.setCategory(AVAudioSessionCategoryRecord)//录音
        try audioSession.setMode(AVAudioSessionModeMeasurement)
        try audioSession.setActive(true, with: .notifyOthersOnDeactivation)
        
        speechRecognizedRequest = SFSpeechAudioBufferRecognitionRequest()
        
        guard speechRecognizedRequest != nil else {
            fatalError("创建请求失败")
        }
        
        //便解析边反馈
        speechRecognizedRequest?.shouldReportPartialResults = true
        
        recognizeTask = speechRecognizer?.recognitionTask(with: speechRecognizedRequest!, resultHandler: { (result, error) in
            var isFinished = false
            if let res = result {
                self.textView.text = res.bestTranscription.formattedString
                isFinished = res.isFinal
            }
            if error != nil || isFinished {
                self.audioEngine.stop()
                self.inputNode.removeTap(onBus: 0)
                
                self.speechRecognizedRequest = nil
                self.recognizeTask = nil
            }
        })
        
        let recordFormat = self.inputNode.outputFormat(forBus: 0)
        self.inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordFormat) { (buffer, time) in
            self.speechRecognizedRequest?.append(buffer)
        }
        
        audioEngine.prepare()
        try audioEngine.start()
        textView.text = "初始内容:"
    }
    
    func setBaseView() {
        view.backgroundColor = UIColor.white
        textView.backgroundColor = UIColor.yellow
        voiceBtn.backgroundColor = UIColor.lightGray
        voiceBtn.setTitle("开始", for: .normal)
        voiceBtn.setTitleColor(UIColor.orange.withAlphaComponent(0.5), for: .highlighted)
        voiceBtn.setTitleColor(.orange, for: .normal)
        voiceBtn.setTitleColor(.gray, for: .disabled)
        voiceBtn.addTarget(self, action: #selector(voiceBegin), for: .touchDown)
        voiceBtn.addTarget(self, action: #selector(voiceStop), for: .touchUpInside)
        view.addSubview(textView)
        view.addSubview(voiceBtn)
    }
    
    @objc func voiceBegin() {
        do {
            try startRecordVoice()
        } catch let err as NSError {
            print("解析错误:\(err)")
        }
    }
    
    @objc func voiceStop() {
//        audioEngine.stop()
//        self.speechRecognizedRequest?.endAudio()
        
//        OperationQueue.main.addOperation {
//            if(self.audioEngine.isRunning){
//                self.inputNode.removeTap(onBus: 0)
//                self.audioEngine.stop()
//                self.speechRecognizedRequest?.endAudio()
//                self.recognizeTask?.cancel()
//                self.recognizeTask = nil;
//                self.speechRecognizedRequest = nil;
//            }
//        }
        
        audioEngine.stop()
        if let _: AVAudioInputNode = audioEngine.inputNode {
            audioEngine.inputNode.removeTap(onBus: 0)
        }
        speechRecognizedRequest?.endAudio()
        recognizeTask?.cancel()
    }
}

extension VoiceViewController: SFSpeechRecognizerDelegate {
    func speechRecognizer(_ speechRecognizer: SFSpeechRecognizer, availabilityDidChange available: Bool) {
        if available {
            print("开始识别")
        }else {
            print("无法识别")
        }
    }
}














