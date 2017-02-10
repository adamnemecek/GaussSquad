import UIKit

class VLinearEquationsSolutionCellPolynomialDecimal:VLinearEquationsSolutionCell
{
    private weak var label:UILabel!
    private weak var imageView:UIImageView!
    private let kImageWidth:CGFloat = 30
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        
        let label:UILabel = UILabel()
        label.isUserInteractionEnabled = false
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor.clear
        label.textAlignment = NSTextAlignment.right
        label.textColor = UIColor.black
        self.label = label
        
        let imageView:UIImageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = UIViewContentMode.center
        imageView.isUserInteractionEnabled = false
        self.imageView = imageView
        
        addSubview(label)
        addSubview(imageView)
        
        NSLayoutConstraint.equalsVertical(
            view:imageView,
            toView:self)
        NSLayoutConstraint.leftToLeft(
            view:imageView,
            toView:self)
        NSLayoutConstraint.width(
            view:imageView,
            constant:kImageWidth)
        
        NSLayoutConstraint.equals(
            view:label,
            toView:self)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    override func config(
        model:MLinearEquationsSolutionEquationItem,
        index:IndexPath)
    {
        guard
        
            let model:MLinearEquationsSolutionEquationItemPolynomialDecimal = model as? MLinearEquationsSolutionEquationItemPolynomialDecimal
        
        else
        {
            return
        }
        
        label.attributedText = model.string
        
        if model.coefficientDividend >= 0
        {
            if index.item > 1
            {
                imageView.image = #imageLiteral(resourceName: "assetGenericColAddSmall")
            }
            else
            {
                imageView.image = nil
            }
        }
        else
        {
            imageView.image = #imageLiteral(resourceName: "assetGenericColSubstractSmall")
        }
    }
}
