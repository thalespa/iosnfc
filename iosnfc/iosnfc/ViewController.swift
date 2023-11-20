//
//  ViewController.swift
//  iosnfc
//
//  Created by Thales Andrade on 18/11/23.
//

import UIKit
import CoreNFC

class ViewController: UIViewController {
    
    private var session: NFCNDEFReaderSession?
    
    private lazy var buttonItem: UIButton = {
        let button = UIButton();
        button.setTitle("Tests", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .blue
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return button;
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
      
        buildView()
        setAutoLayout()
    }
    
    private func buildView() {
        self.view.backgroundColor = .white
        self.view.addSubview(buttonItem)
        
    }
    
    private func setAutoLayout() {
        NSLayoutConstraint.activate([
            buttonItem.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            buttonItem.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            buttonItem.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -32),
            buttonItem.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc private func buttonTapped() {
           // Handle the button tap event here
        print("Button tapped!")
        guard NFCNDEFReaderSession.readingAvailable else {
            
            let alertController = UIAlertController(
                  title: "Scanning Not Supported",
                  message: "This device doesn't support tag scanning.",
                  preferredStyle: .alert
            )
        
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alertController, animated: true, completion: nil)
            return
            
        }
        session = NFCNDEFReaderSession(delegate: self, queue: nil, invalidateAfterFirstRead: false)
        session?.alertMessage = "Hold your iPhone near the item to learn more about it."
        session?.begin()
    }

}

extension ViewController: NFCNDEFReaderSessionDelegate {
    
    func readerSession(_ session: NFCNDEFReaderSession, didInvalidateWithError error: Error) {
        if let readerError = error as? NFCReaderError {
            if (readerError.code != .readerSessionInvalidationErrorFirstNDEFTagRead)
                && (readerError.code != .readerSessionInvalidationErrorUserCanceled) {
                let alertController = UIAlertController(
                       title: "Session Invalidated",
                       message: error.localizedDescription,
                       preferredStyle: .alert
                )
                alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                DispatchQueue.main.async {
                    self.present(alertController, animated: true, completion: nil)
                    
                }
            }
        }
        // To read new tags, a new session instance is required.
    }
    
    func readerSession(_ session: NFCNDEFReaderSession, didDetectNDEFs messages: [NFCNDEFMessage]) {
        DispatchQueue.main.async {
            print(messages)
        }
    }
}

