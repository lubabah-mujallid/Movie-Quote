//
//  MovieCollectionViewCell.swift
//  Movie Quote
//
//  Created by administrator on 03/01/2022.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var contentViewMovieCell: UIView!
    
    @IBOutlet weak var imageViewMovieCell: UIImageView!
    
    @IBOutlet weak var labelMovieCell: UILabel!
    
    
    
    func setupCell(movie: Movie) {
        contentViewMovieCell.layer.cornerRadius = 5
        contentViewMovieCell.clipsToBounds = true
        imageViewMovieCell.layer.cornerRadius = 10
        imageViewMovieCell.clipsToBounds = true
        
        labelMovieCell.text = movie.title
        imageViewMovieCell.downloaded(from: movie.image)
    }
    
    override var isSelected: Bool {
        
            didSet {
                if self.isSelected {
                    contentViewMovieCell.backgroundColor = .systemGray4
                }
                else {
                    contentViewMovieCell.backgroundColor = .systemGray6
                }
            }
        }}
