//
//  GameViewController.swift
//  Hangman
//
//  Created by Shawn D'Souza on 3/3/16.
//  Copyright © 2016 Shawn D'Souza. All rights reserved.
//

import UIKit

class HangmanViewController: UIViewController {

    //variables
    var count = 1
    var text = ""
    var letters = [String]()
    var guesses = [String]()
    var correct = [String]()
    var localPhrase = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "background"))
        let hangmanPhrases = HangmanPhrases()
        // Generate a random phrase for the user to guess
        let phrase: String = hangmanPhrases.getRandomPhrase()
        print(phrase)
        localPhrase = phrase
        for c in phrase.characters {
            let s = String(c)
            if s == " " {
                text += " "
            } else {
                if !letters.contains(s) {
                    letters.append(s)
                }
                text += "_ "
            }
        }
        Puzzle.text = text
        Image.image = #imageLiteral(resourceName: "hangman1")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet var Image: UIImageView!
    @IBOutlet var Puzzle: UILabel!
    @IBOutlet var Guessed: UILabel!
    @IBOutlet var Textbox: UITextField!
    @IBAction func Guess(_ sender: UIButton) {
        var input: String = Textbox.text!
        Textbox.text = ""
        if input.characters.count < 1 {
            let alertMoreLetters = UIAlertController(title: "Input Error", message: "Make sure you type a letter in the textbox before guessing!", preferredStyle: .alert)
            alertMoreLetters.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alertMoreLetters, animated: true, completion: nil)
        } else if input.characters.count > 1 {
            let alertLessLetters = UIAlertController(title: "Input Error", message: "Make sure you only type one letter at a time!", preferredStyle: .alert)
            alertLessLetters.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alertLessLetters, animated: true, completion: nil)
        } else {
            let alpha: NSString = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
            let lalpha: NSString = "abcdefghijklmnopqrstuvwxyz"
            if lalpha.contains(input) {
                input = input.uppercased()
            }
            if !alpha.contains(input) {
                let alertLetters = UIAlertController(title: "Input Error", message: "Make sure to only type in letters!", preferredStyle: .alert)
                alertLetters.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alertLetters, animated: true, completion: nil)
            } else {
                if guesses.contains(input) {
                    let alertRepeat = UIAlertController(title: "Input Error:", message: "You already guessed this letter!", preferredStyle: .alert)
                    alertRepeat.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alertRepeat, animated: true, completion: nil)
                } else {
                    guesses.append(input)
                    if letters.contains(input) {
                        let index = letters.index(of: input)
                        letters.remove(at: index!)
                        correct.append(input)
                        text = ""
                        for c in localPhrase.characters {
                            let s = String(c)
                            if s == " " {
                                text += " "
                            } else {
                                if correct.contains(s) {
                                    text += String(s + " ")
                                } else {
                                    text += "_ "
                                }
                            }
                        }
                        Puzzle.text = text
                        if letters.count == 0 {
                            let alertYW = UIAlertController(title: "You Won!", message: String("The phrase was:\n" + localPhrase), preferredStyle: .alert)
                            alertYW.addAction(UIAlertAction(title: "New Game", style: .default, handler: {(action:UIAlertAction) in self.newGame()}))
                            self.present(alertYW, animated: true, completion: nil)
                        }
                    } else {
                        count += 1
                        if count == 2 {
                            Guessed.text = String(Guessed.text! + " " + input)
                        } else {
                            Guessed.text = String(Guessed.text! + ", " + input)
                        }
                        updateImage()
                        if count == 7 {
                            let alertGO = UIAlertController(title: "Game Over", message: String("You Lost!\nThe phrase was:\n" + localPhrase), preferredStyle: .alert)
                            alertGO.addAction(UIAlertAction(title: "New Game", style: .default, handler: {(action:UIAlertAction) in self.newGame()}))
                            self.present(alertGO, animated: true, completion: nil)
                        }
                    }
                }
            }
        }
    }
    @IBAction func NewPhrase(_ sender: UIButton) {
        self.newGame()
    }

    func updateImage() {
        if count == 2 {
            Image.image = #imageLiteral(resourceName: "hangman2")
        } else if count == 3 {
            Image.image = #imageLiteral(resourceName: "hangman3")
        } else if count == 4 {
            Image.image = #imageLiteral(resourceName: "hangman4")
        } else if count == 5 {
            Image.image = #imageLiteral(resourceName: "hangman5")
        } else if count == 6 {
            Image.image = #imageLiteral(resourceName: "hangman6")
        } else if count == 7 {
            Image.image = #imageLiteral(resourceName: "hangman7")
        }
    }
    
    func newGame() {
        count = 1
        text = ""
        letters = [String]()
        guesses = [String]()
        correct = [String]()
        Guessed.text = "Guessed:"
        viewDidLoad()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
