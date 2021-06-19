//
//  QuestionsCollectionViewController.swift
//  Supplements
//
//  Created by Nikolai Puchko on 19.06.2021.
//

import UIKit
import Popover

private let reuseIdentifier = "Question"

class QuestionsCollectionViewController: UICollectionViewController {
	var questions: [String] = []
	var answers: [[String]] = []
	private var layout: UICollectionViewFlowLayout
	private var pickerDelegate = PopPickerDelegate(["Не указано", "0", "1", "2", "3", "4", "5"])


	init(questions: [String: [String]]) {
		self.questions = [String](questions.keys)
		answers = [[String]](questions.values)
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
        self.collectionView!.register(QuestionCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int { 1 }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return questions.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? QuestionCell else {
			return UICollectionViewCell()
		}
		cell.label.text = questions[indexPath.row]
        return cell
    }

    // MARK: UICollectionViewDelegate

    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }

	override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		guard let cell = collectionView.cellForItem(at: indexPath) as? QuestionCell else {
			return
		}
		pickerDelegate.answers = answers[indexPath.row]
		pickerDelegate.cell = cell
		let container = UIView(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
		let label = UILabel()
		label.textAlignment = .center
		label.numberOfLines = 2
		label.text = questions[indexPath.row]
		label.font = Fonts.HelveticaNeue
		let picker = UIPickerView()
		picker.delegate = pickerDelegate
		picker.dataSource = pickerDelegate

		container.addSubview(picker)
		container.addSubview(label)
		label.snp.makeConstraints { make in
			make.top.equalToSuperview().offset(20)
			make.left.equalToSuperview().offset(20)
			make.right.equalToSuperview().offset(-20)
		}
		picker.snp.makeConstraints { make in
			make.left.equalToSuperview().offset(10)
			make.right.equalToSuperview().offset(-10)
			make.bottom.equalToSuperview().offset(-20)
			make.top.equalTo(label.snp.bottom).offset(20)
		}

		let popover = Popover(options: [.cornerRadius(10), .overlayBlur(.systemUltraThinMaterial), .type(.down)])
		popover.show(container, fromView: cell)
	}



}

class PopPickerDelegate: NSObject, UIPickerViewDelegate, UIPickerViewDataSource {
	var answers: [String]
	weak var cell: QuestionCell!
	private lazy var model = (UIApplication.shared.delegate as! AppDelegate).symptomsModel

	init(_ answers: [String]) {
		self.answers = answers
	}

	func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
		answers.count
	}

	func numberOfComponents(in pickerView: UIPickerView) -> Int {
		1
	}

	func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
		return answers[row]
	}

	func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
		if row != 0 {
			cell.label.backgroundColor = Colors.lightGreen
			model?.rowData.questions[cell.label.text!] = answers[row]
		} else {
			cell.label.backgroundColor = Colors.lightGray
		}
	}
}
