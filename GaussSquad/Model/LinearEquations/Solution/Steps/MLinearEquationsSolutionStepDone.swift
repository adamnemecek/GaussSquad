import UIKit

class MLinearEquationsSolutionStepDone:MLinearEquationsSolutionStep
{
    private let kHeaderHeight:CGFloat = 150
    
    init(equations:[MLinearEquationsSolutionEquation])
    {
        let reusableIdentifier:String = VLinearEquationsSolutionHeaderDone.reusableIdentifier
        
        super.init(
            equations:equations,
            reusableIdentifier:reusableIdentifier,
            headerHeight:kHeaderHeight)
    }
}