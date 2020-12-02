//
//  BottomSheetViewController.swift
//  MakeItGreat
//


import UIKit


class BottomSheetViewController: UIViewController {
    let lists = ["Next", "Inbox", "Waiting", "Projects", "Maybe"]
    let homeModel = HomeViewModel()
    var task: Task?
    var delegate: ModalHandler?
    var contentView: UIView = UIView() // trocar pela view especifica depois
    var viewModel: BottomSheetViewModel?
    var taskNameTextField: UITextField?
    var tagTextField: UITextField?
    var priority: Int?
    var greenButton: UIButton?
    var yellowButton: UIButton?
    var redButton: UIButton?
    
    //    let homeController = HomeViewController(viewModel: HomeViewModel())
    //    weak var homeCoordinator: HomeCoordinator?
    
    
    //    init(viewModel: BottomSheetViewModel, homeCoordinator: HomeCoordinator, view: BottomSheetView) {
    //        self.viewModel = viewModel
    //        self.homeCoordinator = homeCoordinator
    //        super.init(nibName: nil, bundle: nil)
    //        self.view = view
    //    }
    //
    //    required init?(coder: NSCoder) {
    //        super.init(coder: coder)
    //    }
    
    override func loadView() {
        let bottomView = BottomSheetView()
        bottomView.viewController = BottomSheetViewController()
        bottomView.saveButton.addTarget(self, action: #selector(saveButton(_:)), for: .touchUpInside)
        bottomView.cancelButton.addTarget(self, action: #selector(cancelButton(_:)), for: .touchUpInside)
        taskNameTextField = bottomView.textFieldTaskTitle
        taskNameTextField?.text = task?.name
        tagTextField = bottomView.textFieldTag
        tagTextField?.text = task?.tags
        greenButton = bottomView.greenButton
        redButton = bottomView.redButton
        yellowButton = bottomView.yellowButton
        greenButton?.addTarget(self, action: #selector(checkPriorityButton(_:)), for: .touchUpInside)
        yellowButton?.addTarget(self, action: #selector(checkPriorityButton(_:)), for: .touchUpInside)
        redButton?.addTarget(self, action: #selector(checkPriorityButton(_:)), for: .touchUpInside)
        
        if task?.priority == 1 {
            greenButton?.isSelected = true
        } else if task?.priority == 2 {
            yellowButton?.isSelected = true
        } else if task?.priority == 3 {
            redButton?.isSelected = true
        }
        
        //        bottomView.listPicker.dataSource = self
        //        bottomView.listPicker.delegate = self
        self.view = bottomView
        
    }
    
    @objc func saveButton(_ sender: UIButton) {
        
        guard let task = task else {return}
        
        // if user doesn't write anything we attribute task info for it, so it doesn't save an empty string
        if taskNameTextField?.text == "" {
            taskNameTextField?.text = task.name
        }

        if tagTextField?.text == "" {
            tagTextField?.text = task.tags
        }

        // updating the task
        self.homeModel.updateTask(task: task, name: taskNameTextField?.text ?? "", finishedAt: Date(), lastMovedAt: task.lastMovedAt ?? Date(), priority: Int64(priority ?? 0), status: task.status, tags: tagTextField?.text ?? "")
      
        dismiss(animated: true) {
            self.delegate?.modalDismissed()
        }
    }
    
    @objc func cancelButton(_ sender: UIButton) {
        dismiss(animated: true) {
            self.delegate?.modalDismissed()
        }
    }
    
    func checkIsSelected(button: UIButton) -> Bool {
        if button.isSelected {
            button.isSelected = false
            
        } else {
            button.isSelected = true
        }
        return button.isSelected
    }
    
    @objc func checkPriorityButton(_ sender: UIButton) {
        
        if sender == greenButton {
            if checkIsSelected(button: greenButton ?? UIButton()) {
                redButton?.isSelected = false
                yellowButton?.isSelected = false
                priority = 1
            }
            
        } else if sender == redButton {
            if checkIsSelected(button: redButton ?? UIButton()) {
                greenButton?.isSelected = false
                yellowButton?.isSelected = false
                priority = 3
            }
            
        } else {
            if checkIsSelected(button: yellowButton ?? UIButton()) {
                greenButton?.isSelected = false
                redButton?.isSelected = false
                priority = 2
            }
            
        }
    }
    
    override func viewDidLoad() {
        //        NotificationCenter.default.addObserver(self, selector: #selector(keyboardAppeared(notification:)), name: .expandModal, object: nil)
    }
    //    @objc func keyboardAppeared(notification: NSNotification){
    //        // expand view
    //    }
}

extension BottomSheetViewController: UIPickerViewDataSource,UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        lists.count
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10.0)
        label.textColor = UIColor.purple
        label.text =  lists[row]
        label.textAlignment = .left
        return NSAttributedString(string: label.text ?? "a")
    }
    
}

extension Notification.Name {
    static let expandModal = Notification.Name("expandModal")
    
}

