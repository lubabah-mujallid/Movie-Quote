//
//  Game.swift
//  Movie Quote
//
//  Created by administrator on 03/01/2022.
//

import Foundation

struct Movie: Codable {
    var title: String
    var image: String
    var description: String
    var isSelected: Bool = false
    
    private enum CodingKeys: String, CodingKey {
            case title, image, description
        }
}



class Game {
    var movies = [Movie]()
    //var currentRound = 0
    var currentScore = 0
    //var totalMovies = 0
    var currentMovie: Movie?
    
    func setMoviesAndShuffle (with moviesArray: [Movie]) {
        self.movies = moviesArray.shuffled()
        //totalMovies = moviesArray.count
    }
    
    func getMovie() -> Movie {
        currentMovie =  movies.popLast()!
        return currentMovie!
    }
    
    func getMovieTitles() -> [String] {
        var titles = [String]()
        for movie in movies {
            titles.append(movie.title)
        }
        return titles
    }
    
    func check(answer: String) -> Bool {
        return answer == currentMovie!.title
    }
    
}

//  Lubabah Mujallid
//  Created by admin on 07/12/2021.


//this is a basic and empty quiz class: it has all the variables and methods a quiz would need
class Quiz {
    var questions: QuestionsBank
    var currentScore = 0
    var currentQuestionNum = 0
    init(questions: QuestionsBank) {
        self.questions = questions
    }
    func getCurrentQuestion() -> Question {
        return questions.getQuestion(currentQuestionNum)
    }
    func setNextQuestion() {
        if currentQuestionNum < questions.numOfQuestions-1 {
            currentQuestionNum += 1
        }
        else {
            currentQuestionNum = 0 //this nneeds fixing
            // When I finish all the questions, stop the game
        }
    }
    func checkAnswer(answer: Int) -> Bool {
        return getCurrentQuestion().correctAnswer == answer
    }
}


//this question bank contains all animal quiz questions
struct QuestionsBank {
    private var questions: [Question]
    var numOfQuestions: Int
    init() {
        questions = [
        Question(question: "Which mammal is known to have the most powerful bite in the world", correctAnswer: 1, answer1: "Hippo", answer2: "Lion", answer3: "Tiger", answer4: "Elephant"),
        Question(question: "Why are flamingos pink?", correctAnswer: 2, answer1: "Because they are fabulous", answer2: "their diet, shrimp and algea", answer3: "they produce pink pigment from their skin", answer4: "blood circulation"),
        Question(question: "How do sea otters keep from drifting apart while they sleep?", correctAnswer: 1, answer1: "They hold hands", answer2: "they don't sleep", answer3: "one keeps watch, the others sleep", answer4: "they sleep on land"),
        Question(question: "What is the only mammals that can’t jump?", correctAnswer: 3, answer1: "Hippo", answer2: "koala", answer3: "elehpant", answer4: "bear"),
        Question(question: "Under their white fur, what color is a polar bear’s skin?", correctAnswer: 2, answer1: "white", answer2: "black", answer3: "pink", answer4: "grey"),
        Question(question: "What color is the tongue of a giraffe?", correctAnswer: 1, answer1: "purple", answer2: "pink", answer3: "red", answer4: "black"),
        Question(question: "A dog sweats through which part of its body?", correctAnswer: 3, answer1: "nose", answer2: "ears", answer3: "paws", answer4: "everywhere"),
    ]
        numOfQuestions = questions.count
    }
    func getQuestion(_ position: Int) -> Question {
        return questions[position]
    }
}

//basic quiz question structure: question, possible answers, and correct answer
struct Question {
    var question: String
    var correctAnswer: Int
    var answer1: String
    var answer2: String
    var answer3: String
    var answer4: String
}


