//
//  ViewController.swift
//  Movie Quote
//
//  Created by administrator on 03/01/2022.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var moviesCollecetionView: UICollectionView!
    
    
    var movies = [Movie]()
    let tag = "Main: "
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
        moviesCollecetionView.delegate = self
        moviesCollecetionView.dataSource = self
        moviesCollecetionView.allowsMultipleSelection = true
    }
    
    func fetchData() {
        let url = URL(string: "https://ghibliapi.herokuapp.com/films")
        let session = URLSession.shared
        let task = session.dataTask(with: url!, completionHandler: {
            data, response, error in
            print(self.tag + "api initialized")
            print(data ?? "no data")
            guard let myData = data else { return }
            do {
                let decoder = JSONDecoder()
                let jsonResult = try decoder.decode([Movie].self, from: myData)
                self.movies = jsonResult
                DispatchQueue.main.async {
                    self.moviesCollecetionView.reloadData()
                }
                
            }
            catch {
                print(error.localizedDescription)
            }
        })
        task.resume()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("prepare to go to Game")
        let gameVC = segue.destination as! GameViewController
        let selectedMovies = movies.filter {$0.isSelected}
        gameVC.movies = selectedMovies
    }
    
    @IBAction func playBtnPressed(_ sender: UIButton) {
        //do the segue only if there is something selected, if not do not
        if moviesCollecetionView.indexPathsForSelectedItems?.count ?? 0 > 0 {
            print(moviesCollecetionView.indexPathsForSelectedItems!)
            performSegue(withIdentifier: "gameSegue", sender: nil)
        }
    }
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = moviesCollecetionView.dequeueReusableCell(withReuseIdentifier: "movieCell", for: indexPath) as! MovieCollectionViewCell
        cell.setupCell(movie: movies[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width * 0.45, height: self.view.frame.height * 0.35)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        movies[indexPath.item].isSelected = true
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        movies[indexPath.item].isSelected = false
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    
}

extension UIImageView {
    func downloaded(from url: URL, contentMode mode: ContentMode = .scaleToFill) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: ContentMode = .scaleToFill) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}
