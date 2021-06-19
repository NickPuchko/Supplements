//
//  QuestionsCollectionViewController.swift
//  Supplements
//
//  Created by Nikolai Puchko on 19.06.2021.
//

import UIKit

private let reuseIdentifier = "Question"

class QuestionsCollectionViewController: UICollectionViewController {
	var questions: [String: [String]] = [:]
	private var layout: UICollectionViewFlowLayout

	init(questions: [String: [String]]) {
		self.questions = questions
		layout = UICollectionViewFlowLayout()
		super.init(collectionViewLayout: layout)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

    override func viewDidLoad() {
        super.viewDidLoad()
		collectionView.backgroundColor = .clear
		layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int { 1 }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//		return questions.count
		10
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)

        let label = InsetLabel(inset: UIEdgeInsets(top: 10, left: 30, bottom: 10, right: 30))
		label.font = Fonts.SDGothicNeoLight
		label.layer.cornerRadius = 14
		label.clipsToBounds = true
		label.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.2)
		label.textColor = .white
		label.layer.borderWidth = 0.5
		label.layer.borderColor = UIColor.white.cgColor

		cell.contentView.addSubview(label)
		label.snp.makeConstraints { make in
			make.top.left.equalToSuperview()
			make.bottom.right.equalToSuperview()
//			make.edges.equalToSuperview().inset(UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
		}


		label.text = Int.random(in: 0...1) % 2 == 0 ? "Ухудшение сна" : "Анемия"
        return cell
    }

    // MARK: UICollectionViewDelegate

    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }



}
