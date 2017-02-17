import UIKit
import MetalKit

class MPlotRenderCartesian:MetalRenderableProtocol
{
    private let rotationBuffer:MTLBuffer
    private let axisX:MetalSpatialLine
    private let axisY:MetalSpatialLine
    private let positionBuffer:MTLBuffer
    private let kAxisWidth:Float = 10
    private let kBoundaries:Float = 3000
    
    init(device:MTLDevice)
    {
        let position:MetalPosition = MetalPosition.zero()
        let rotation:MetalRotation = MetalRotation.none()
        positionBuffer = device.generateBuffer(bufferable:position)
        rotationBuffer = device.generateBuffer(bufferable:rotation)
        
        axisX = MetalSpatialLine(
            device:device,
            aPointX:-kBoundaries,
            aPointY:0,
            bPointX:kBoundaries,
            bPointY:0,
            lineWidth:kAxisWidth)
        
        axisY = MetalSpatialLine(
            device:device,
            aPointX:0,
            aPointY:-kBoundaries,
            bPointX:0,
            bPointY:kBoundaries,
            lineWidth:kAxisWidth)
    }
    
    //MARK: renderable Protocol
    
    func render(renderEncoder:MTLRenderCommandEncoder)
    {
        renderEncoder.render(
            vertex:axisX.vertexBuffer,
            position:positionBuffer,
            rotation:rotationBuffer)
        
        renderEncoder.render(
            vertex:axisY.vertexBuffer,
            position:positionBuffer,
            rotation:rotationBuffer)
    }
}
