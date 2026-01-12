// TODO: This is mostly done for you. See the "YOUR CODE HERE" spots below.
//***************************************************************


import com.sun.source.tree.Tree;
import edu.uci.ics.jung.graph.Forest;
//import edu.uci.ics.jung.graph.Tree;

import edu.uci.ics.jung.graph.util.EdgeType;

import java.awt.Color;
import java.awt.Frame;
import java.util.*;
import javax.swing.event.TreeExpansionEvent;
import javax.tools.ForwardingFileObject;

/**
 *  This algorithm performs the steps to create a Huffman encoding
 *  build from a set of characters.
 *  
 *  @author Katherine (Raven) Russell and YOUR_NAME_HERE
 */
class HuffmanAlg implements FourEightyThreeForestAlg<HuffmanTreeNode,TreeEdge> {
	//*********************************************************************
	//*******                                                       *******
	//*******   You should not need to edit anything in this part.  *******
	//*******   However, you may need to read everything here.      *******
	//*******                                                       *******
	//*********************************************************************
	
	/**
	 *  The forest of huffman trees.
	 */
	Forest<HuffmanTreeNode, TreeEdge> forest;
	
	/**
	 *  Whether or not the algorithm has been started.
	 */
	private boolean started = false;
	
	/**
	 *  The possible modes the algorithm can be in.
	 */
	private enum Mode { COUNTING, BUILDING, ENCODING, DONE };
	
	/**
	 *  The algorithm's current mode.
	 */
	private Mode mode = null;
	
	/**
	 *  Current character (if in counting mode);
	 */
	private Character currentChar;

	private HashMap<Character, HuffmanTreeNode> charCounts;
	
	/**
	 *  {@inheritDoc}
	 */
	public EdgeType TreeEdgeType() {return EdgeType.UNDIRECTED;}
	
	/**
	 *  Sets the current character being examined.
	 *  
	 *  @param currentChar the new character
	 */
	public void setCurrentChar(Character currentChar) {this.currentChar = currentChar;}
	
	/**
	 *  {@inheritDoc}
	 */
	public boolean isStarted() {return started;}
	
	/**
	 *  {@inheritDoc}
	 */
	public void start() {this.started = true;}
	
	/**
	 *  {@inheritDoc}
	 */
	public void finish() {/* Unused. Required by the interface.*/}
	
	/**
	 *  {@inheritDoc}
	 */
	public void cleanUpLastStep() {/*Unused. Required by the interface.*/}
	
	/**
	 *  {@inheritDoc}
	 */
	public boolean setupNextStep() {
		//we're counting, but out of characters
		if(this.mode == Mode.COUNTING && currentChar == null) {
			//start building
			this.mode = Mode.BUILDING;
		}
		
		//we're down to one tree, so stop building
		if(this.mode == Mode.BUILDING && this.forest.getTrees().size() <= 1) {
			//start encoding
			this.mode = Mode.ENCODING;
		}
		//you only get one step to do the encoding
		else if(this.mode == Mode.ENCODING) {
			//finished!
			this.mode = Mode.DONE;
		}
		
		return (this.mode != Mode.DONE);
	}
	
	//*********************************************************************
	//*******                                                       *******
	//*******    You have a number of things to do in this part.    *******
	//*******                                                       *******
	//*********************************************************************
	
	//YOUR CODE HERE
	//Any instance variables you'd find useful could go here!
	
	
	/**
	 *  {@inheritDoc}
	 */
	@SuppressWarnings("unchecked")
	public void reset(Forest<HuffmanTreeNode, TreeEdge> forest) {
		this.forest = forest;
		this.started = false;
		this.mode = Mode.COUNTING;
		this.currentChar = null;
		
		//YOUR CODE HERE
		this.charCounts = new HashMap<>();	// Init map for char counts
		
		//You may (or may not) want to (re)initialize some variables
		//before each run of the algorithm. You can do that here.
		//This is also called before the first run, so it can be
		//used in the same way as a constructor (to initialize).
	}
	
	/**
	 *  {@inheritDoc}
	 */
	public void doNextStep() {
		// Counting Mode:		
		if(this.mode == Mode.COUNTING){countChar();}

		// Building Mode:
		else if(this.mode == Mode.BUILDING){
			HuffmanTreeNode[] toMerge = getMinNodes();		// get 2 min count nodes
			if(toMerge[1] != null){ mergeNodes(toMerge);}	// merge min count nodes
		}

		// Encoding Mode:
		else if(this.mode == Mode.ENCODING){
			
			HuffmanTreeNode startNode = null;
			for(HuffmanTreeNode node : forest.getVertices()){
				if(forest.getParent(node) == null){
					startNode = node;			// Get Tree Root
					break;
				}
			}

			encodeTree("", startNode);	// Start Encoding
		}
		
	}
	
	/***
	 * Handles the current character during Counting Mode.
	 */
	private void countChar(){
		HuffmanTreeNode node;
		if(charCounts.containsKey(this.currentChar)){		// CASE: repeating character
			node = charCounts.get(this.currentChar);
			node.setCount(node.getCount()+1);
		}else{												// CASE: new character
			node = new HuffmanTreeNode(currentChar, 1);	// allocate new node
			charCounts.put(currentChar, node);					// add to charCounts map for duplicate lookup
			forest.addVertex(node);								// add node to forest
		}

	}


	/***
	 * @return returns 2 nodes with the lowest count
	 */
	private HuffmanTreeNode[] getMinNodes(){
		HuffmanTreeNode[] toMerge = new HuffmanTreeNode[2];		// ind:0 lowest, ind:1 2nd lowest
		toMerge[0] = null;										// set null
		toMerge[1] = null;										// set null

		for (HuffmanTreeNode node: forest.getVertices()){
			if(forest.getParent(node) != null){continue;} // filter out non parents

			// update 2nd min and abs min
			if(toMerge[0] == null || toMerge[0].count > node.count){
				toMerge[1] = toMerge[0];
				toMerge[0] = node;
			}
			// set 2nd min if node has dup val
			else if(toMerge[1] == null || toMerge[0].count == node.count){
					toMerge[1] = node;
				}
			else if(toMerge[1].count > node.count){toMerge[1] = node;} // 1st min set, but second min needs update
		}
		return toMerge;
	}

	/***
	 * Merges the two nodes in the array
	 * @param toMerge HuffmanTreeNode[] of size 2
	 */
	private void mergeNodes(HuffmanTreeNode[] toMerge){
		HuffmanTreeNode newParent = new HuffmanTreeNode(toMerge[0].count + toMerge[1].count); // create parent
		forest.addVertex(newParent);						// add new parent

		TreeEdge tempEdge = new TreeEdge();					// create new edge for "left"
		tempEdge.setTextLabel("0");					// Assign Edge Text
		forest.addEdge(tempEdge, newParent, toMerge[0]);	// add child 0

		tempEdge = new TreeEdge();							// create new edge for "right"
		tempEdge.setTextLabel("1");					// Assign Edge Text
		forest.addEdge(tempEdge, newParent, toMerge[1]);	// add child 1
	}

	/***
	 * Encodes a Huffman Tree
	 * @param encVal call with empty string
	 * @param curNode call with root
	 */
	private void encodeTree(String encVal, HuffmanTreeNode curNode){
		if(curNode == null){return;}	// reach end of tree 
		if(curNode.letter != null){		// reach a leaf node
			curNode.setEncoding(encVal);
			return;
		}
		HuffmanTreeNode zero = null, one = null;
		for(HuffmanTreeNode dest: forest.getSuccessors(curNode)){
			TreeEdge edge = forest.findEdge(curNode, dest);
			if(edge.text.equals("0")){zero = forest.getDest(edge);} // CASE: edge text = 0, set zero w/ dest val
			if(edge.text.equals("1")){one = forest.getDest(edge);} // CASE: edge text = 1, set one w/ dest val
		}
		encodeTree(encVal+"0", zero);
		encodeTree(encVal+"1", one);
	}
}