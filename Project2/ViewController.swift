//
//  ViewController.swift
//  Project2
//
//  Created by Luca Hummel on 24/06/21.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    @IBOutlet weak var progressView: UIProgressView!
    
    var countries = [String]()
    var score = 0
    var correctAnswer = 0
    var contador = 0
    var progress = Progress(totalUnitCount: 10)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
        
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1

        
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor

        progressView.transform = progressView.transform.scaledBy(x: 1, y: 4)
        
        askQuestion()
        // pode arrumar tambem com askQuestion(action: nil)
    }

    func askQuestion(action: UIAlertAction! = nil) {
        countries.shuffle() //embaralhar
        correctAnswer = Int.random(in: 0...2)
        
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        
        title = "score: \(score) || \(countries[correctAnswer].uppercased())"
    }
    
    func restart(action: UIAlertAction! = nil){
        contador = 0
        score = 0
        correctAnswer = 0
        progress.completedUnitCount = 0
        progressView.progress = 0
        askQuestion()
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        progress.completedUnitCount += 1
        let progressFloat = Float(self.progress.fractionCompleted)
        self.progressView.setProgress(progressFloat, animated: true)
        
        var title: String
        var message: String
        if sender.tag == correctAnswer {
            title = "Correct"
            score += 1
            message = "Your score is \(score)"
        } else {
            title = "Wrong"
            if score > 0{
                score -= 1
            }
            message = "Wrong! That’s the flag of \(countries[sender.tag].uppercased())"
        }
        
        if contador < 9 {
            let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
            
            ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
            
            present(ac, animated: true)
        } else {
            let ac = UIAlertController(title: "Game Over", message: "Your final score is \(score)", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Restart", style: .default, handler: restart))
            present(ac, animated: true)
        }
        
        
        contador += 1
    }
    
}

