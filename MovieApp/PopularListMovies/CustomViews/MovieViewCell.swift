//
//  MovieViewCell.swift
//  MovieApp
//
//  Created by Juan José Guevara Muñoz on 20/4/23.
//

import UIKit
import Kingfisher

class MovieViewCell: UITableViewCell {

    @IBOutlet weak var releaseDateLabel: UILabel!

    @IBOutlet weak var voteAverageLabel: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var synopsisLabel: UILabel!
    @IBOutlet weak var movieTitleLabel: UILabel!
    
    public func configureView(movie:MovieViewCellModel){
        self.movieTitleLabel.text = movie.title
        self.synopsisLabel.text = movie.synopsis
        let placeHolder = UIImage(named: "placeholder")
        self.posterImageView.kf.setImage(with:movie.imageURL, placeholder: placeHolder)
        self.voteAverageLabel.text = movie.votesAverage
        self.releaseDateLabel.text = movie.release
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
