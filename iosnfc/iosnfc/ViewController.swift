//
//  ViewController.swift
//  iosnfc
//
//  Created by Thales Andrade on 18/11/23.
//

import UIKit
import CoreNFC

class ViewController: UIViewController {
   
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
    }

}

extension ViewController: NFCNDEFReaderSessionDelegate {
    
    func readerSession(_ session: NFCNDEFReaderSession, didInvalidateWithError error: Error) {
        
    }
    
    func readerSession(_ session: NFCNDEFReaderSession, didDetectNDEFs messages: [NFCNDEFMessage]) {
        
    }
}

