//
//  ViewController.swift
//  Counter
//
//  Created by Charo Rino on 4/7/25.
//

import UIKit

class ViewController: UIViewController {

    var counter = 0 {
        didSet {
            counter = max(0, counter)
        }
    }
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .medium
        formatter.locale = Locale.current
        return formatter
    } ()
    var history: [String] = [] {
        didSet {
            historyTextView.text = history.joined(separator: "\n")
        }
    }
    
    
    @IBOutlet weak var minusButton: UIButton!
    @IBOutlet weak var refreshButton: UIButton!
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var counterLabel: UILabel!
    @IBOutlet weak var historyTextView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        historyTextView.scrollRangeToVisible(NSRange(location: 0, length: 0))
        
    }

    @IBAction func plusButtonTap(_ sender: Any) {
        counter += 1
        counterLabel.text = "Значение счетчика: \(counter)"
        historyTextView.text = historyTextView.text! + "\n \(dateFormatter.string(from: Date())): Значение изменено на +1 \n "
    }
    
    @IBAction func refreshButtonTap(_ sender: Any) {
        counter = 0
        counterLabel.text = "Значение счетчика: \(counter)"
        historyTextView.text = historyTextView.text! + "\n\(dateFormatter.string(from: Date())): Значение сброшено \n "
    }
    
    @IBAction func minusButtonTap(_ sender: Any) {
        if counter > 0 {
            counter -= 1
            historyTextView.text = historyTextView.text! + "\n \(dateFormatter.string(from: Date())):  Значение изменено на -1 \n "
        } else {
            let message = "\n \(dateFormatter.string(from: Date()))  Попытка уменьшить значение счетчика ниже 0! \n "
            historyTextView.text += message
        }
        counterLabel.text = "Значение счетчика: \(counter)"
    }
    private func addLogMessage(_ message: String) {
        let timestamp = dateFormatter.string (from: Date())
        let logEntry = "\(timestamp): \(message)\n"
        historyTextView.text.append(logEntry)
        let range = NSRange(location: historyTextView.text.count - 1, length: 1)
        historyTextView.scrollRangeToVisible(range)
        
    }
    
}

