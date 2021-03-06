import UIKit

class CLinearEquations:CController
{
    var model:MLinearEquations?
    private weak var viewLinearEquations:VLinearEquations!
    
    override func viewDidAppear(_ animated:Bool)
    {
        super.viewDidAppear(animated)
        
        model = MLinearEquations(controller:self)
    }
    
    override func loadView()
    {
        let viewLinearEquations:VLinearEquations = VLinearEquations(controller:self)
        self.viewLinearEquations = viewLinearEquations
        view = viewLinearEquations
    }
    
    //MARK: private
    
    private func openProject(project:DProject?)
    {
        let controller:CLinearEquationsProject = CLinearEquationsProject(
            project:project)
        parentController.push(
            controller:controller,
            horizontal:CParent.TransitionHorizontal.fromRight)
    }
    
    //MARK: public
    
    func back()
    {
        parentController.pop(horizontal:CParent.TransitionHorizontal.fromRight)
    }
    
    func add()
    {
        openProject(project:nil)
    }
    
    func help()
    {
        let modelHelp:MHelpLinearEquationsLanding = MHelpLinearEquationsLanding()
        let controllerHelp:CHelp = CHelp(model:modelHelp)
        parentController.push(
            controller:controllerHelp,
            vertical:CParent.TransitionVertical.fromTop,
            background:false)
    }
    
    func modelLoaded()
    {
        viewLinearEquations.refresh()
    }
    
    func selectedProject(model:MLinearEquationsItem)
    {
        let project:DProject? = model.project
        openProject(project:project)
    }
}
