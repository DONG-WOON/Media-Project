//
//  ProfileViewController.swift
//  Media Project
//
//  Created by 서동운 on 8/29/23.
//

import UIKit

final class ProfileViewController: UIViewController {
    
    var user: User? = User(name: "", nickname: "", profileURL: "", genderPronoun: "", introduction: "", gender: .man, link: "")
    
    let profileView = UITableView()
    lazy var cancelButton = UIBarButtonItem(title: "취소", style: .plain, target: self, action: #selector(cancel))
    lazy var doneButton = UIBarButtonItem(title: "확인", style: .plain, target: self, action: #selector(done))
    
    override func loadView() {
        view = profileView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        profileView.dataSource = self
        profileView.delegate = self
        profileView.estimatedRowHeight = UITableView.automaticDimension
        
        navigationItem.leftBarButtonItem = cancelButton
        navigationItem.rightBarButtonItem = doneButton
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateGender), name: .updateGender, object: nil)
    }
    
    @objc func cancel() {
        dismiss(animated: true)
    }
    
    @objc func done() {
        dismiss(animated: true)
    }
    
    @objc func updateGender(_ noti: NSNotification) {
        guard let genderPronoun = noti.userInfo?["genderPronoun"] as? String else { return }
        user?.genderPronoun = genderPronoun
        let row = ProfileSection.genderPronoun.rawValue
        profileView.reloadRows(at: [IndexPath(row: row, section: 1)], with: .automatic)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

// MARK: Delegate

protocol DataUpdateProtocol: AnyObject {
    func update(data: String)
}

extension ProfileViewController: DataUpdateProtocol {
    func update(data: String) {
        user?.name = data
        
        let row = ProfileSection.name.rawValue
        profileView.reloadRows(at: [IndexPath(row: row, section: 1)], with: .automatic)
    }
}

// MARK: UITableViewDataSource

extension ProfileViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section {
        case 0:
            return 1
        case 1:
            return ProfileSection.allCases.count
        case 2, 3:
            return 1
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            let profileImageCell = ProfileImageViewCell()
            profileImageCell.update(imageURL: user?.profileURL)
            profileImageCell.separatorInset = .zero
            profileImageCell.selectionStyle = .none
            return profileImageCell
        case 1:
            guard let profileSection = ProfileSection(rawValue: indexPath.row) else { return UITableViewCell() }
            let cell = ProfileTableViewCell(title: profileSection.title, placeholder: profileSection.title)
            cell.mainView.textField.isEnabled = false
            
            switch profileSection {
            case .name:
                cell.update(data: user?.name)
            case .nickname:
                cell.update(data: user?.nickname)
            case .genderPronoun:
                cell.update(data: user?.genderPronoun)
            case .introduction:
                cell.update(data: user?.introduction)
            case .link:
                cell.update(data: user?.link)
                cell.accessoryType = .disclosureIndicator
            case .gender:
                cell.update(data: user?.gender.rawValue)
                cell.accessoryType = .disclosureIndicator
            }
            
            if (0...4).contains(indexPath.row) {
                cell.separatorInset = UIEdgeInsets(top: 0, left: 120, bottom: 0, right: 0)
            } else {
                cell.separatorInset = .zero
            }
            
            return cell
            
        case 2:
            let cell = UITableViewCell()
            cell.textLabel?.text = "프로페셔널 계정 전환"
            cell.textLabel?.font = .systemFont(ofSize: 15)
            cell.textLabel?.textColor = .systemBlue
            cell.separatorInset = .zero
            return cell
        case 3:
            let cell = UITableViewCell()
            cell.textLabel?.text = "개인정보 설정"
            cell.textLabel?.font = .systemFont(ofSize: 15)
            cell.textLabel?.textColor = .systemBlue
            cell.separatorInset = .zero
            return cell
        default:
            return UITableViewCell()
        }
    }
}

extension ProfileViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard indexPath.section == 1 else { return }
        guard let profileSection = ProfileSection(rawValue: indexPath.row) else { return }
        if profileSection == .name {
            let vc = ProfileEditNameViewController(text: user?.name)
            vc.title = "이름"
            vc.delegate = self
            navigationController?.pushViewController(vc, animated: true)
        } else if profileSection == .nickname {
            let vc = ProfileEditNicknameViewController(text: user?.nickname)
            vc.title = "사용자 이름"
            vc.doneButtonAction = { [weak self] text in
                self?.user?.nickname = text
                tableView.reloadRows(at: [indexPath], with: .automatic)
            }
            navigationController?.pushViewController(vc, animated: true)
        } else if profileSection == .genderPronoun {
            let vc = ProfileEditGenderViewController(text: user?.genderPronoun)
            vc.title = "성별 대명사"
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}
