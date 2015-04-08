


import SceneKit

class SolarSystemScene: SCNScene {

	var contentNode:SCNNode //Top level node of the solar system scene

	var wireframeBoxNode:SCNNode
	var sunNode:SCNNode
	var earthNode:SCNNode
	var earthGroupNode:SCNNode

	override init () {

		// Content node
		contentNode = SCNNode()

		// A node that will help visualize the position of the stars
		wireframeBoxNode = SCNNode()
		wireframeBoxNode.rotation = SCNVector4Make(0, 1, 0, Float(M_PI_4))
		wireframeBoxNode.geometry = SCNBox(width: 1.0, height: 1.0, length: 1.0, chamferRadius: 0)
		wireframeBoxNode.geometry?.firstMaterial?.diffuse.contents = UIImage(named: "box_wireframe")
		wireframeBoxNode.geometry?.firstMaterial?.lightingModelName = SCNLightingModelConstant // no lighting 
		wireframeBoxNode.geometry?.firstMaterial?.doubleSided = true // the reciver is double sided

		// Sun
		sunNode = SCNNode()
		sunNode.position = SCNVector3Make(0, 0, 0)
		sunNode.addChildNode(wireframeBoxNode.copy() as SCNNode) // copy is cheap 


		//Earth-rotation (center of rotation of the Earth around the Sun)
		var earthRotationNode = SCNNode()
		sunNode.addChildNode(earthRotationNode)

		// Earth-group (will contain the Earth, and the Moon)
		earthGroupNode = SCNNode()
		earthGroupNode.position = SCNVector3Make(5, 0, 0)


		// Earth
		earthNode = wireframeBoxNode.copy() as SCNNode
		earthNode.position = SCNVector3Make(0, 0, 0)
		earthGroupNode.addChildNode(earthNode)

		//Rotate the Earth around the Sun
		let animation = CABasicAnimation(keyPath: "rotation")
		animation.duration = 10.0;
		animation.fromValue = NSValue(SCNVector4: SCNVector4Make(0, 0, 1, 0))
		animation.toValue = NSValue(SCNVector4: SCNVector4Make(0, 0, 1, Float(M_PI) * 2.0))
		animation.repeatCount = FLT_MAX
		earthRotationNode.addAnimation(animation, forKey: "earth rotation around the sun")



		// Rotate the Earth
		let animation2 = CABasicAnimation(keyPath: "rotation")
		animation2.duration = 1.0
		animation2.fromValue = NSValue(SCNVector4: SCNVector4Make(0, 1, 0, 0))
	   animation2.toValue = NSValue(SCNVector4: SCNVector4Make(0, 1, 0, Float(M_PI) * 2.0))
		animation2.repeatCount = FLT_MAX
		earthNode.addAnimation(animation2, forKey: "earth rotation")

		//It's impotant the ordein in which we add the nodes to the view so the animation works correctly

		contentNode.addChildNode(earthGroupNode)
		contentNode.addChildNode(sunNode)
		earthRotationNode.addChildNode(earthGroupNode)

		super.init()
		rootNode.addChildNode(contentNode)



	}

	required init(coder aDecoder: NSCoder) {
	    fatalError("init(coder:) has not been implemented")
	}
}
