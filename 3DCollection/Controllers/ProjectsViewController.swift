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
    let projectsTableView = UITableView()
    
    var projects: [Project] = [
        Project(projectName: "Sun", projectDescription: "That's a very cool project found on NASA's website and used as a model for my Apps's ideia at the Apple Developer Academy.", projectImageName: "saturnImage", projectModelName: "Sun"),
        Project(projectName: "Mercury", projectDescription: "That's a very cool project found on NASA's website and used as a model for my Apps's ideia at the Apple Developer Academy.", projectImageName: "saturnImage", projectModelName: "Mercury"),
        Project(projectName: "Venus", projectDescription: "That's a very cool project found on NASA's website and used as a model for my Apps's ideia at the Apple Developer Academy.", projectImageName: "saturnImage", projectModelName: "Venus"),
        Project(projectName: "Earth", projectDescription: "That's a very cool project found on NASA's website and used as a model for my Apps's ideia at the Apple Developer Academy.", projectImageName: "saturnImage", projectModelName: "Earth"),
        Project(projectName: "Mars", projectDescription: "That's a very cool project found on NASA's website and used as a model for my Apps's ideia at the Apple Developer Academy.", projectImageName: "saturnImage", projectModelName: "Mars"),
        Project(projectName: "Jupiter", projectDescription: "That's a very cool project found on NASA's website and used as a model for my Apps's ideia at the Apple Developer Academy.", projectImageName: "saturnImage", projectModelName: "Jupiter"),
        Project(projectName: "Saturn", projectDescription: "That's a very cool project found on NASA's website and used as a model for my Apps's ideia at the Apple Developer Academy.", projectImageName: "saturnImage", projectModelName: "Saturn"),
        Project(projectName: "Uranus", projectDescription: "That's a very cool project found on NASA's website and used as a model for my Apps's ideia at the Apple Developer Academy.", projectImageName: "saturnImage", projectModelName: "Uranus"),
        Project(projectName: "Neptune", projectDescription: "That's a very cool project found on NASA's website and used as a model for my Apps's ideia at the Apple Developer Academy.", projectImageName: "saturnImage", projectModelName: "Neptune"),
        Project(projectName: "Pluto", projectDescription: "That's a very cool project found on NASA's website and used as a model for my Apps's ideia at the Apple Developer Academy.", projectImageName: "saturnImage", projectModelName: "Pluto"),
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(projectsTableView)
        
        projectsTableView.register(UITableViewCell.self, forCellReuseIdentifier: "projectCell")
        projectsTableView.delegate = self
        projectsTableView.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        projectsTableView.frame = view.bounds
    }
}

extension ProjectsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = projectsTableView.dequeueReusableCell(withIdentifier: "projectCell", for: indexPath)
        
        cell.textLabel?.text = projects[indexPath.row].projectName

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cellNumber = indexPath.row
        projectsTableView.deselectRow(at: indexPath, animated: true)
        
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let arViewController = storyBoard.instantiateViewController(withIdentifier: "ProjectView") as! ModelViewController
        arViewController.project = projects[cellNumber]
        
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = .push
        transition.subtype = .fromRight
        transition.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        self.view.window!.layer.add(transition, forKey: kCATransition)
        
        self.present(arViewController, animated: false)
    }
}
