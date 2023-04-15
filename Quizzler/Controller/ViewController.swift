//
//  ViewController.swift
//  Quizzler
//
//  Created by Andrey on 10.04.2023.
//

import UIKit

class ViewController: UIViewController {

    //MARK: - Outlets
    @IBOutlet weak var choose1Button: UIButton!
    @IBOutlet weak var choose2Button: UIButton!
    @IBOutlet weak var choose3Button: UIButton!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    var quizBrain = QuizBrain()
    
    //MARK: - LifeCycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUI()
    }
    
    //MARK: - Actions
    @IBAction func answerButtonPressed(_ sender: UIButton) {
        
        if let userAnswer = sender.currentTitle {
            let userGotItRight = quizBrain.checkAnswer(for: userAnswer)
            
            if userGotItRight {
                sender.backgroundColor = UIColor.green
            } else {
                sender.backgroundColor = UIColor.red
            }
        }
        
        
        
        if !quizBrain.isLastQuestion() {
            Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(updateUI), userInfo: nil, repeats: false)
        } else {
            showResult()
        }
        
        quizBrain.nextQuestion()
    }
    
    @objc func updateUI() {
        questionLabel.text = quizBrain.getQuestionText()
        progressBar.progress = quizBrain.getProgress()
        scoreLabel.text = "Score: \(quizBrain.getScore())"
        
        choose1Button.backgroundColor = UIColor.clear
        choose2Button.backgroundColor = UIColor.clear
        choose3Button.backgroundColor = UIColor.clear
        
        choose1Button.setTitle(quizBrain.getAnswers()[0], for: .normal)
        choose2Button.setTitle(quizBrain.getAnswers()[1], for: .normal)
        choose3Button.setTitle(quizBrain.getAnswers()[2], for: .normal)
    }
    
    func showResult() {
        
        let score = quizBrain.getScore()
        
        let alertWindow = UIAlertController(title: "Result", message: "Your score: \(score)", preferredStyle: .alert)
        let action = UIAlertAction(title: "Start new round", style: .default) { (action) in
            self.updateUI()
        }
        
        alertWindow.addAction(action)
        
        present(alertWindow, animated: true)
    }
}

