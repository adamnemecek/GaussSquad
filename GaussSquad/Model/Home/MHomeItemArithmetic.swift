import Foundation

class MHomeItemArithmetic:MHomeItem
{
    init()
    {
        let symbol:String = NSLocalizedString("MHomeItemArithmetic_symbol", comment:"")
        let title:String = NSLocalizedString("MHomeItemArithmetic_title", comment:"")
        
        super.init(
            symbol:symbol,
            title:title,
            image:#imageLiteral(resourceName: "assetGenericLinearEquations"))
    }
}
