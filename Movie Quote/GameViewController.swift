//
//  GameViewController.swift
//  Movie Quote
//
//  Created by administrator on 03/01/2022.
//

import SearchTextField
import UIKit

class GameViewController: UIViewController {
    
    @IBOutlet weak var textFieldMovieTitleGuess: SearchTextField!
    @IBOutlet weak var labelMovieDescription: UILabel!
    
    var movies = [Movie]()
    let game = Game()
    let tag = "Game VC: "
    
    override func viewDidLoad() {
        super.viewDidLoad()
        game.setMoviesAndShuffle(with: movies)
        print(tag)
        let titles = game.getMovieTitles()
        print(titles)
        textFieldMovieTitleGuess.filterStrings(titles)
        //textFieldMovieTitleGuess.inlineMode = true
        playRound()
    }
    
    @IBAction func guessBtnPressed(_ sender: UIButton) { //play a round or quit the game
        print("there are \(game.movies.count) rounds left")
        if let answer = textFieldMovieTitleGuess.text {
            if game.check(answer: answer) {
                game.currentScore += 1
            }
        }
        if !game.movies.isEmpty { //play a round
            playRound()
        }
        else { //quit game
            quitGame()
        }
    }
    
    func playRound () {
        let movie = game.getMovie()
        labelMovieDescription.text = movie.description
    }
    
    func quitGame() {
        print("quit game")
        print("Score is \(game.currentScore)")
        alert()
    }
    
    func alert() {
        let alert = UIAlertController(title: "Game Over", message: "your score is \(game.currentScore) ",preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "ok", style: .default) {UIAlertAction -> Void in
            self.performSegue(withIdentifier: "mainSegue", sender: nil)
        }
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }
}

