//
//  ProjectsViewController.swift
//  3DCollection
//
//  Created by João Pedro Picolo on 01/10/21.
//

import UIKit

struct Project {
    let projectName: String
    let projectDescription: String
    let projectImageName: String
    let projectModelName: String
}

class ProjectsViewController: UIViewController {
    let width = UIScreen.main.bounds.width
    let height = UIScreen.main.bounds.height
    
    var projectsTableView: UITableView!
    
    var projects: [Project] = [
        Project(projectName: "Sun", projectDescription: "The Sun is the star at the center of the Solar System. It is a nearly perfect sphere of hot plasma, heated to incandescence by nuclear fusion reactions in its core, radiating the energy mainly as visible light, ultraviolet light, and infrared radiation.", projectImageName: "saturnImage", projectModelName: "Sun"),
        Project(projectName: "Mercury", projectDescription: "Mercury has a very thin atmosphere of oxygen, sodium, hydrogen, helium and potassium and can't break-up incoming meteors, so its surface is pockmarked with craters, just like the moon.", projectImageName: "saturnImage", projectModelName: "Mercury"),
        Project(projectName: "Venus", projectDescription: "The second planet from the sun, Venus is Earth's twin in size. Radar images beneath its atmosphere reveal that its surface has various mountains and volcanoes. But beyond that, the two planets couldn't be more different. B", projectImageName: "saturnImage", projectModelName: "Venus"),
        Project(projectName: "Earth", projectDescription: "The third planet from the sun, Earth is a waterworld, with two-thirds of the planet covered by ocean. It's the only world known to harbor life. Earth's atmosphere is rich in nitrogen and oxygen.", projectImageName: "saturnImage", projectModelName: "Earth"),
        Project(projectName: "Mars", projectDescription: "The fourth planet from the sun is Mars, and it's a cold, desert-like place covered in dust. This dust is made of iron oxides, giving the planet its iconic red hue.", projectImageName: "saturnImage", projectModelName: "Mars"),
        Project(projectName: "Jupiter", projectDescription: "The fifth planet from the sun, Jupiter is a giant gas world that is the most massive planet in our solar system — more than twice as massive as all the other planets combined, according to NASA.", projectImageName: "saturnImage", projectModelName: "Jupiter"),
        Project(projectName: "Saturn", projectDescription: "The sixth planet from the sun, Saturn is known most for its rings. When polymath Galileo Galilei first studied Saturn in the early 1600s, he thought it was an object with three parts: a planet and two large moons on either side. ", projectImageName: "saturnImage", projectModelName: "Saturn"),
        Project(projectName: "Uranus", projectDescription: "The seventh planet from the sun, Uranus is an oddball. It has clouds made of hydrogen sulfide, the same chemical that makes rotten eggs smell so foul. It rotates from east to west like Venus.", projectImageName: "saturnImage", projectModelName: "Uranus"),
        Project(projectName: "Neptune", projectDescription: "The eighth planet from the sun, Neptune is about the size of Uranus and is known for supersonic strong winds. Neptune is far out and cold. The planet is more than 30 times as far from the sun as Earth.", projectImageName: "saturnImage", projectModelName: "Neptune"),
        Project(projectName: "Pluto", projectDescription: "From 1979 until early 1999, Pluto had actually been the eighth planet from the sun. Then, on Feb. 11, 1999, it crossed Neptune's path and once again became the solar system's most distant planet — until it was redefined as a dwarf planet.", projectImageName: "saturnImage", projectModelName: "Pluto"),
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTitle()
        setupProjectsTable()
    }
    
    private func setupTitle() {
        let titleView = UIView(frame: CGRect(x: 20, y: 80, width: width - 40, height: 40))
        let title = UILabel(frame: CGRect(x: 0, y: 0, width: titleView.frame.width, height: titleView.frame.height))
        title.text = "Projects"
        title.font = .systemFont(ofSize: 34, weight: .bold)
        
        titleView.addSubview(title)
        view.addSubview(titleView)
    }
    
    private func setupProjectsTable() {
        projectsTableView = UITableView(frame: CGRect(x: 10, y: 150, width: width - 40, height: height - 50))
        view.addSubview(projectsTableView)
        
        projectsTableView.register(UITableViewCell.self, forCellReuseIdentifier: "projectCell")
        projectsTableView.delegate = self
        projectsTableView.dataSource = self
    }
}

extension ProjectsViewController: UITableViewDelegate, UITableViewDataSource {
    private func setupCell(project: Project, cell: UITableViewCell) {
        cell.textLabel?.text = project.projectName
        cell.selectionStyle = .none
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return projects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = projectsTableView.dequeueReusableCell(withIdentifier: "projectCell", for: indexPath)
        setupCell(project: projects[indexPath.row], cell: cell)

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cellNumber = indexPath.row
        projectsTableView.deselectRow(at: indexPath, animated: true)
        
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let arViewController = storyBoard.instantiateViewController(withIdentifier: "ProjectView") as! ProjectViewController
        arViewController.project = projects[cellNumber]
        arViewController.modalPresentationStyle = .fullScreen
        
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = .push
        transition.subtype = .fromRight
        transition.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        self.view.window!.layer.add(transition, forKey: kCATransition)
        
        self.present(arViewController, animated: false)
    }
}
