import UIKit
import MetalKit

class VLinearEquationsPlotMetal:MTKView
{
    private weak var controller:CLinearEquationsPlot!
    private let pipelineCompute:MTLComputePipelineState
    private let kernelFunction:MTLFunction
    private let commandQueue:MTLCommandQueue
    private let pipelineState:MTLRenderPipelineState
    private var threadgroupCounts:MTLSize
    private var threadgroups:MTLSize
    private let kThreadgroupWidth:Int = 8
    private let kThreadgroupHeight:Int = 8
    private let kThreadgroupDeep:Int = 1
    
    init?(controller:CLinearEquationsPlot)
    {
        guard
            
            let device:MTLDevice = MTLCreateSystemDefaultDevice(),
            let library:MTLLibrary = device.newDefaultLibrary(),
            let vertexFunction:MTLFunction = library.makeFunction(
                name:MetalConstants.kVertexFunction),
            let fragmentFunction:MTLFunction = library.makeFunction(
                name:MetalConstants.kFragmentFunction),
            let kernelFunction:MTLFunction = library.makeFunction(
                name:MetalConstants.kKernelFunction)
            
        else
        {
            return nil
        }
        
        do
        {
            try pipelineCompute = device.makeComputePipelineState(
                function:kernelFunction)
        }
        catch
        {
            return nil
        }
        
        self.kernelFunction = kernelFunction
        commandQueue = device.makeCommandQueue()
        
        let pipelineDescriptor:MTLRenderPipelineDescriptor = MTLRenderPipelineDescriptor()
        pipelineDescriptor.vertexFunction = vertexFunction
        pipelineDescriptor.fragmentFunction = fragmentFunction
        
        let colorAttachment:MTLRenderPipelineColorAttachmentDescriptor = pipelineDescriptor.colorAttachments[
            MetalConstants.kColorAttachmentIndex]
        colorAttachment.pixelFormat = MetalConstants.kPixelFormat
        colorAttachment.isBlendingEnabled = MetalConstants.kBlendingEnabled
        colorAttachment.rgbBlendOperation = MetalConstants.kRgbBlendOperation
        colorAttachment.alphaBlendOperation = MetalConstants.kAlphaBlendOperation
        colorAttachment.sourceRGBBlendFactor = MetalConstants.kSourceRgbBlendFactor
        colorAttachment.sourceAlphaBlendFactor = MetalConstants.kSourceAlphaBlendFactor
        colorAttachment.destinationRGBBlendFactor = MetalConstants.kDestinationRgbBlendFactor
        colorAttachment.destinationAlphaBlendFactor = MetalConstants.kDestinationAlphaBlendFactor
        
        do
        {
            try pipelineState = device.makeRenderPipelineState(descriptor:pipelineDescriptor)
        }
        catch
        {
            return nil
        }
        
        threadgroupCounts = MTLSizeMake(
            kThreadgroupWidth,
            kThreadgroupHeight,
            kThreadgroupDeep)
        threadgroups = MTLSizeMake(
            0,
            0,
            kThreadgroupDeep)
        
        super.init(frame:CGRect.zero, device:device)
        backgroundColor = UIColor.clear
        framebufferOnly = false
        clipsToBounds = true
        isUserInteractionEnabled = false
        translatesAutoresizingMaskIntoConstraints = false
        contentMode = UIViewContentMode.center
        autoResizeDrawable = true
        isPaused = false
        clearColor = MTLClearColor(red:1, green:1, blue:1, alpha:1)
        self.controller = controller
    }
    
    required init(coder:NSCoder)
    {
        fatalError()
    }
    
    override func layoutSubviews()
    {
        let width:Int = Int(bounds.maxX)
        let height:Int = Int(bounds.maxY)
        let threadgroupsHorizontal:Int = width / kThreadgroupWidth
        let threadgroupsVertical:Int = height / kThreadgroupHeight
        threadgroupCounts = MTLSizeMake(
            kThreadgroupWidth,
            kThreadgroupHeight,
            kThreadgroupDeep)
        threadgroups = MTLSizeMake(
            threadgroupsHorizontal,
            threadgroupsVertical,
            kThreadgroupDeep)
        
        super.layoutSubviews()
    }
    
    override func draw()
    {
        super.draw()
        
        guard
            
            let drawable:CAMetalDrawable = currentDrawable,
            let passDescriptor:MTLRenderPassDescriptor = currentRenderPassDescriptor
            
        else
        {
            return
        }

        let commandBuffer:MTLCommandBuffer = commandQueue.makeCommandBuffer()
        let renderEncoder:MTLRenderCommandEncoder = commandBuffer.makeRenderCommandEncoder(
            descriptor:passDescriptor)
        renderEncoder.setCullMode(MTLCullMode.none)
        renderEncoder.setRenderPipelineState(pipelineState)
        controller.model.modelRender?.render(
            renderEncoder:renderEncoder)

        renderEncoder.endEncoding()
        
        let commandEncoder:MTLComputeCommandEncoder = commandBuffer.makeComputeCommandEncoder()
        commandEncoder.setComputePipelineState(pipelineCompute)
        commandEncoder.setTexture(
            drawable.texture,
            at:MetalConstants.kTextureIndex)
        commandEncoder.dispatchThreadgroups(
            threadgroups,
            threadsPerThreadgroup:threadgroupCounts)
        commandEncoder.endEncoding()
        
        
        commandBuffer.present(drawable)
        commandBuffer.commit()
    }
}
