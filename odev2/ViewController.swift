//
//  ViewController.swift
//  odev2
//
//  Created by Süleyman Ekici on 9.08.2018.
//  Copyright © 2018 Süleyman Ekici. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var TimeLabel: UILabel!
    @IBOutlet weak var ScoreLabel: UILabel!
    @IBOutlet weak var HighScoreLabel: UILabel!
    @IBOutlet weak var kenny1: UIImageView!
    @IBOutlet weak var kenny2: UIImageView!
    @IBOutlet weak var kenny3: UIImageView!
    @IBOutlet weak var kenny4: UIImageView!
    @IBOutlet weak var kenny5: UIImageView!
    @IBOutlet weak var kenny6: UIImageView!
    @IBOutlet weak var kenny7: UIImageView!
    @IBOutlet weak var kenny8: UIImageView!
    @IBOutlet weak var kenny9: UIImageView!

    
   var score = 0
   var timer = Timer()
   var counter = 0
   var kennyArray = [UIImageView]()
   var HideTimer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let highScore = UserDefaults.standard.object(forKey: "highscore")
        if highScore == nil {
            HighScoreLabel.text = "0"
        }
        if let newScore = highScore as? Int {
            HighScoreLabel.text =  String(newScore)
        }
        ScoreLabel.text = "Skor: \(score)"
        
        
        let Recognizer1 = UITapGestureRecognizer(target: self, action: #selector(ViewController.increaseScore))
        let Recognizer2 = UITapGestureRecognizer(target: self, action: #selector(ViewController.increaseScore))
        let Recognizer3 = UITapGestureRecognizer(target: self, action: #selector(ViewController.increaseScore))
        let Recognizer4 = UITapGestureRecognizer(target: self, action: #selector(ViewController.increaseScore))
        let Recognizer5 = UITapGestureRecognizer(target: self, action: #selector(ViewController.increaseScore))
        let Recognizer6 = UITapGestureRecognizer(target: self, action: #selector(ViewController.increaseScore))
        let Recognizer7 = UITapGestureRecognizer(target: self, action: #selector(ViewController.increaseScore))
        let Recognizer8 = UITapGestureRecognizer(target: self, action: #selector(ViewController.increaseScore))
        let Recognizer9 = UITapGestureRecognizer(target: self, action: #selector(ViewController.increaseScore))
     
        
        kenny1.isUserInteractionEnabled = true
        kenny2.isUserInteractionEnabled = true
        kenny3.isUserInteractionEnabled = true
        kenny4.isUserInteractionEnabled = true
        kenny5.isUserInteractionEnabled = true
        kenny6.isUserInteractionEnabled = true
        kenny7.isUserInteractionEnabled = true
        kenny8.isUserInteractionEnabled = true
        kenny9.isUserInteractionEnabled = true
      
        kenny1.addGestureRecognizer(Recognizer1)
        kenny2.addGestureRecognizer(Recognizer2)
        kenny3.addGestureRecognizer(Recognizer3)
        kenny4.addGestureRecognizer(Recognizer4)
        kenny5.addGestureRecognizer(Recognizer5)
        kenny6.addGestureRecognizer(Recognizer6)
        kenny7.addGestureRecognizer(Recognizer7)
        kenny8.addGestureRecognizer(Recognizer8)
        kenny9.addGestureRecognizer(Recognizer9)
        
        //Geri Sayım Sistemi
        counter = 30
        TimeLabel.text = "\(counter)"
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.CountDown), userInfo: nil, repeats: true)
        HideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(ViewController.hideKenny), userInfo: nil, repeats: true)
        
        
       
        
        //Resim Döngüsü
        kennyArray.append(kenny1)
        kennyArray.append(kenny2)
        kennyArray.append(kenny3)
        kennyArray.append(kenny4)
        kennyArray.append(kenny5)
        kennyArray.append(kenny6)
        kennyArray.append(kenny7)
        kennyArray.append(kenny8)
        kennyArray.append(kenny9)
        hideKenny()
    }
    
    @objc func hideKenny() {
        for kenny in kennyArray{
            kenny.isHidden = true
        }
        let random = Int(arc4random_uniform(UInt32(kennyArray.count - 1)))
        kennyArray[random].isHidden = false
    }

    @objc func CountDown(){
        counter = counter - 1
        TimeLabel.text = "\(counter)"
       
        if counter == 0 {
            timer.invalidate()
            HideTimer.invalidate()
            for kenny in kennyArray{
                kenny.isHidden = true
            }
            
            if self.score > Int(HighScoreLabel.text!)! {
                UserDefaults.standard.set(self.score, forKey: "highscore")
                HighScoreLabel.text = String(self.score)
            }
            
            let alert = UIAlertController(title: "Merhaba Oyuncu", message: "Süren doldu tekrar oynamak istermisin ?", preferredStyle: UIAlertControllerStyle.alert
            )
            let okButton = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
            let replayButton = UIAlertAction(title: "Tekrar Oyna", style: UIAlertActionStyle.default, handler: { (UIAlertAction)
                in
                self.score = 0
                self.ScoreLabel.text = "Skor: \(self.score)"
                self.counter = 30
                self.TimeLabel.text = "\(self.counter)"
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.CountDown), userInfo: nil, repeats: true)
                self.HideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(ViewController.hideKenny), userInfo: nil, repeats: true)
                
                
            })
            alert.addAction(okButton)
            alert.addAction(replayButton)
            self.present(alert, animated: true, completion: nil)
        }
    }
   
   
@objc func increaseScore() {
    score = score + 1
    ScoreLabel.text = "Skor: \(score)"
}
    
}

