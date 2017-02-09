import Foundation

class MLinearEquationsSolutionIndeterminatesItem
{
    let symbol:String
    private weak var indeterminate:DIndeterminate?
    private let kEmpty:String = ""
    
    init(indeterminate:DIndeterminate)
    {
        if let symbol:String = indeterminate.symbol
        {
            self.symbol = symbol
        }
        else
        {
            self.symbol = kEmpty
        }
    }
    
    //MARK: public
    
    func equalsIndeterminate(other:MLinearEquationsSolutionIndeterminatesItem) -> Bool
    {
        guard
            
            let indeterminate:DIndeterminate = self.indeterminate,
            let otherIndeterminated:DIndeterminate = other.indeterminate
            
        else
        {
            return false
        }
        
        let isEqual:Bool = indeterminate == otherIndeterminated
        
        return isEqual
    }
    
    func equalsRawIndeterminate(rawIndetermianted:DIndeterminate) -> Bool
    {
        guard
            
            let indeterminate:DIndeterminate = self.indeterminate
            
        else
        {
            return false
        }
        
        let isEqual:Bool = indeterminate == rawIndetermianted
        
        return isEqual
    }
}