//
//  FactTableViewCell.swift
//  InfosysAssignment
//
//  Created by Jayachandra on 12/13/19.
//  Copyright © 2019 BlueRose Technologies Pvt Ltd. All rights reserved.
//

import UIKit
import SDWebImage

/// FactTableViewCell, class will be used to show the fact cell row in facts tableview
class FactTableViewCell: UITableViewCell {

    /// Fact title label
    var titleLabel: UILabel!

    /// Fact desction lable
    var descriptionLabel: UILabel!

    /// Fact Imageview object
    var factImageView: UIImageView!

    /// Table Row indexpath, will be use to perform any additional actions from the cell
    var indexPath: IndexPath!

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        // Create all UI element
        self.initializeUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        // Create all UI element
        self.initializeUI()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        descriptionLabel.text = nil
        factImageView.image = #imageLiteral(resourceName: "gallery-placeholder")
    }

    ///
    /// Call this function to set the fact row data
    ///
    /// - Parameter fact: `Fact` data model object to show the fact information in cell
    /// - Parameter indexPath: This is the current row indexpath
    ///
    func setData(fact: Fact, at indexPath: IndexPath) {
        self.indexPath = indexPath

        // Update the ui with data
        if let title = fact.title, !title.isEmpty {
            self.titleLabel.text = title
        } else {
            self.titleLabel.text = "No title available"
        }
        if let desc = fact.description, !desc.isEmpty {
            self.descriptionLabel.text = desc
        } else {
            self.descriptionLabel.text =  "No description available"
        }
        if let imageURLPath = fact.imageHref, let urlRef = URL(string: imageURLPath) {
            self.factImageView.sd_setImage(with: urlRef,
                                           placeholderImage: #imageLiteral(resourceName: "gallery-placeholder"),
                                           completed: nil)
        }
    }

    ///
    /// Allocates or creates all the UI elements required to show fact row
    ///
    func initializeUI() {
        self.accessoryType = .none

        if titleLabel == nil {
            titleLabel = UILabel()
            titleLabel.numberOfLines = 0
            titleLabel.font = UIFont.boldSystemFont(ofSize: 17)
            contentView.addSubview(titleLabel)
        }

        if descriptionLabel == nil {
            descriptionLabel = UILabel()
            descriptionLabel.font = UIFont.systemFont(ofSize: 15)
            descriptionLabel.numberOfLines = 0
            contentView.addSubview(descriptionLabel)
        }
        if factImageView == nil {
            factImageView = UIImageView()
            factImageView.contentMode = .scaleAspectFit
            contentView.addSubview(factImageView)
        }

        addConstraints()
    }

    ///
    /// Adds the necessory constraints to the all subview
    ///
    func addConstraints() {
        // Title lable constraints
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.titleLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor,
                                                 constant: 10).isActive = true
        self.titleLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor,
                                                  constant: -10).isActive = true
        self.titleLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor,
                                             constant: 10).isActive = true

        // Description lable constraints
        self.descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        self.descriptionLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor,
                                                       constant: 10).isActive = true
        self.descriptionLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor,
                                                        constant: -10).isActive = true
        self.descriptionLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor,
                                                   constant: 10).isActive = true

        // Fact Imageview constraints
        self.factImageView.translatesAutoresizingMaskIntoConstraints = false
        self.factImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor,
                                                    constant: 10).isActive = true
        self.factImageView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor,
                                                     constant: -10).isActive = true
        self.factImageView.topAnchor.constraint(equalTo: self.descriptionLabel.bottomAnchor,
                                                constant: 10).isActive = true
        self.factImageView.heightAnchor.constraint(equalToConstant: 250).isActive = true
        self.factImageView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor,
                                                   constant: -10).isActive = true
    }
}
