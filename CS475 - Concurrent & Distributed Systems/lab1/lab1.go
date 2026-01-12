package main

import (
	"bufio"
	"fmt"
	"math/rand"
	"os"
	"strconv"
	"sync"
	"time"
)

//Constants
const MAX_WEIGHT = 750	// Max bridge Weight
const MAX_VEHCHLES = 6	// Max num vehicles on bridge
const W_TRUCK = 200		// weight of a truck
const W_CAR = 100		// weight of a car
const CROSS_TIME = 2	// time to cross bridge (sec)

/**
	Stores information of a vehichle
*/
type v_info struct{
	id int
	isTruck bool
	isNorth bool
}


type qNode struct{
	v *v_info
	next *qNode
}
type Queue struct{
	queue [2]*qNode
	len int
	l sync.Mutex
	c sync.Cond
}
var Nqueue *Queue
var Squeue *Queue
func queue_add(vehicle *v_info){ 
	tempQ := get_queue(vehicle.isNorth)   //get correct queue

	if(tempQ.queue[0] == nil){ // if queue is empty
		tempQ.queue[0] = &qNode{v:vehicle, next: nil}
		tempQ.queue[1] = tempQ.queue[0]
	}else{ // if queue is not empty
		newNode := &qNode{v: vehicle, next: nil}
	tempQ.queue[1].next = newNode
	tempQ.queue[1] = newNode

	}
	tempQ.len++
}
func queue_rem(v *v_info) *v_info{
	tempQ := get_queue(v.isNorth)
	if(tempQ.queue[0] == nil){return nil}
	rv := tempQ.queue[0].v
	if(tempQ.queue[0].next == nil){
		tempQ.queue[0] = nil
		tempQ.queue[1] = nil
	}else{
		tempQ.queue[0] = tempQ.queue[0].next
		
	}
	
	tempQ.len--
	return rv
}
func queue_print(isNqueue bool){
	Q:= get_queue(isNqueue)
	head := Q.queue[0]
	fmt.Printf("[")														// Start List
	for range Q.len{
		if(head == nil){break}
		 fmt.Printf("#%d (Type: %s) ", head.v.id, get_type(*head.v))	// print vehicle item
		 head = head.next												// move to next
	}
	fmt.Printf("]\n")													// End List
}

type Bridge struct{
	bridge [MAX_VEHCHLES]*v_info	// Bridge representation
	weight int 						// total bridge weight
	crossers int					// number of vehicles on bridge
	isNorth bool					// current direction of bridge
	dirCount int					// number of cars passed in current dir
	l sync.Mutex					// lock for bridge
	c sync.Cond						// CV for bridge
}
var bridge *Bridge	// global bridge variable

/**
* get open index
*/
func bridge_getIndex()int{
		for i := range len(bridge.bridge) {if(bridge.bridge[i] == nil){return i;}}
		return -1
}
/**
	Add vehicle to bridge
*/
func bridge_add(v *v_info, index int) {
	if(index == -1) {panic("Error @ index Assignment")}
	bridge.weight += get_weight(*v) // update weight
	bridge.crossers++               // increment crossers
	bridge.dirCount++				// increment number of crossers
	bridge.bridge[index] = v        // add v to bridge
	
	
}
/**
	Remove from bridge
*/
func bridge_rem(index int, w int){
	bridge.weight -= w				// update weight
	bridge.crossers--				// deincrement crossers
	bridge.bridge[index] = nil		// remove v @ index from bridge
}
func bridge_changeDir(v v_info){
	get_queue(v.isNorth).c.Broadcast()
	get_queue(v.isNorth).c.L.Unlock()	// unlock queue

	bridge.dirCount = bridge.crossers	// set to current # crossers
	for !(bridge.crossers == 0 && (get_queue(!v.isNorth).len == 0 || bridge.isNorth == v.isNorth)){
		bridge.c.Wait()	// wake when broadcaser
	}
	if(bridge.isNorth != v.isNorth){bridge.isNorth = !bridge.isNorth} // for case: not updated in wait
	get_queue(v.isNorth).c.L.Lock()		// lock queue
	bridge.dirCount = 0		// otherwise cars waited will also count for other
	
	
}





/**
	Generates Rand bool of prob
	true: prob
	false: 1-prob
*/
func rand_bool(prob float32) bool{return rand.Float32() < prob}



/**
	Returns String of vehicle Type
*/
func get_type(vehicle v_info) string {
    if vehicle.id == -1 {return "N/A"}
	if vehicle.isTruck {return "Truck"}
	return "Car"
}
/**
	Returns String of vehicle Direction
*/
func get_direction(vehicle v_info) string {
    if vehicle.id == -1 {return "N/A"}
	if vehicle.isNorth {return "Northbound"}
	return "Southbound"
}
/**
	Returns Numerical Weight of vehicle
*/
func get_weight(vehicle v_info) int {
    if vehicle.id == -1 {return 0}
	if vehicle.isTruck {return W_TRUCK}
	return W_CAR
}
/**
	Return correct queue based off direction
*/
func get_queue(isNorth bool)*Queue{
	if isNorth {return  Nqueue}
	return  Squeue
}

/**
	Prints arrival msg
*/
func arrive_print(v v_info){
	fmt.Printf("\n\nvehicle #%d (%s, Type: %s) arrived\n", v.id, get_direction(v), get_type(v))
}
/**
	Prints crossing msg
*/
func cross_print(v v_info){
	// vehicle entering
	fmt.Printf("\n\nvehicle #%d is crossing the bridge...\n", v.id)
	// Bridge State
	fmt.Printf("Bridge State:\n")
	for i := 0; i < len(bridge.bridge); i++ {
		if bridge.bridge[i] != nil && bridge.bridge[i].id >= 0{
			fmt.Printf("|#%d, (%s, %s)|",bridge.bridge[i].id, get_direction(*bridge.bridge[i]), get_type(*bridge.bridge[i]))
		}
	}
	
	fmt.Printf("\nTotal Weight: %d/%d", bridge.weight, MAX_WEIGHT )
	// Waiters
	fmt.Printf("\nNorthbound Waiters: ")
	queue_print(true)
	fmt.Printf("Southbound Waiters:")
	queue_print(false)
}
/**
	Prints departing msh
*/
func depart_print(v v_info){
	fmt.Printf("\n\nvehicle #%d has exited the bridge. Total Weight: %d\n", v.id, bridge.weight)
}



/**
Defines Behavior of a vehicle goroutine
*/
func vehicle(v v_info, wg *sync.WaitGroup){
	defer wg.Done()		// tell to signal wait
	arrive(v)			// call arrive
	index := cross(v)	// cross bridge & save index in bridge
	depart(v, index)	// exit bridge using saved index
}

/**
* Handles the arrival of vehicles
*/
func arrive(v v_info){
	
	get_queue(v.isNorth).c.L.Lock()		// lock queue
	queue_add(&v)						// add v to queue	
	arrive_print(v)						// print arrival
	get_queue(v.isNorth).c.Broadcast()	// broadcast
	get_queue(v.isNorth).c.L.Unlock()	// unlock queue
	
}
/**
	Defines behavior to cross the bridge
*/
func cross(v v_info) int{
	
	q := get_queue(v.isNorth)				// get correct queue
	q.c.L.Lock()							// use cond wait
	for v.id != q.queue[0].v.id{q.c.Wait()}	// wait until head

	bridge.c.L.Lock()
	if bridge.isNorth != v.isNorth {
		bridge_changeDir(v)	// change dir if needed
		
	}else{
		if(bridge.dirCount >= 6 && get_queue(!v.isNorth).len > 0){
			bridge.isNorth = !bridge.isNorth
			// release all locks
			q.c.Broadcast()
			q.c.L.Unlock()
			bridge.c.Broadcast()
			bridge.l.Unlock()
			return cross(v)	//recurse -> forces change_dir
			
		}
	}


	for bridge.crossers >= MAX_VEHCHLES || bridge.weight + get_weight(v) > MAX_WEIGHT{
		bridge.c.Wait()			// wait: space on bridge & can support weight
	}

	index := bridge_getIndex()	// get bridge index
	bridge_add(&v, index)		// enter bridge @ index
	queue_rem(&v)				// exit waiting q
	cross_print(v)				// print cross msg

	q.c.Broadcast()				// inform waiters queue
	q.c.L.Unlock()				// release q lock
	bridge.c.Broadcast()		// inform waiters bridge
	bridge.c.L.Unlock()			// release bridge lock

	

	// finish up
	time.Sleep(CROSS_TIME * time.Second)
	return index
}

/**
	defines behavior upon exiting the bridge
*/
func depart(v v_info, index int){
	bridge.c.L.Lock()
	bridge_rem(index,  get_weight(v))
	depart_print(v)
	
	bridge.c.Broadcast()
	bridge.c.L.Unlock()
	
}

func input(msg string) string{
	fmt.Print(msg+": ")
	var line string = ""
	scanner := bufio.NewScanner(os.Stdin)
    for scanner.Scan() {
        line = scanner.Text()
		if line != ""{break}

    }
    if err := scanner.Err(); err != nil {
    	fmt.Fprintln(os.Stderr, "reading standard input:", err)
		panic("? @ input")
    }
	return line
}

func main(){
	// setup bridge
	bridge = &Bridge{}
	for i := range len(bridge.bridge) {bridge.bridge[i] = nil}
	bridge.crossers = 0
	bridge.weight = 0
	bridge.isNorth = false
	bridge.c = *sync.NewCond(&bridge.l)

	// setup Waiting queues
	Nqueue = &Queue{}
	Squeue = &Queue{}
	Nqueue.c = *sync.NewCond(&Nqueue.l)
	Squeue.c = *sync.NewCond(&Squeue.l)
	
	// setup waitgroup
	var wg sync.WaitGroup
	/*	PERSONAL TESTS
	for i:=range(30){
		wg.Add(1)
		go vehicle(v_info{id: i, isTruck: rand_bool(float32(0.5)),isNorth: rand_bool(0.5) }, &wg)
	}*/
	// get inputs
	buffer := input("Enter the number of delays")	// number of delays
	num_delay, err := strconv.Atoi(buffer)
	if(err != nil){panic(err)}
	var delays = make([]int,num_delay)
	for i := range(num_delay){						// loop & size of delays
		buffer = input("Enter the duration(sec) of delay #"+strconv.Itoa(i+1))
		temp, err := strconv.Atoi(buffer)
		delays[i] = temp
		if(err != nil){panic(err)}
	}

	
	temp_v_ct := 0
	v_group_cts := make([]int, num_delay+1)			// based on delay size make n groups
	for i:= range(v_group_cts){						// for each group add # of cars
		buffer = input("Enter the amount of vehicles in group #"+strconv.Itoa(i+1)+"(all groups must add up to 30)")
		temp, err := strconv.Atoi(buffer)
		v_group_cts[i] = temp
		temp_v_ct += temp
		if(err != nil){panic(err)}
	}
	if(temp_v_ct != 30){panic("invalid number of vehicles")}	// if cars > 30 crash
	buffer = input("enter the probability of a vehicle being a car (0.2 for 0.2 chance of being car & 0.8 for truck)")
	prob, err := strconv.ParseFloat(buffer, 32)
	prob = 1-prob
	if err != nil {panic("Invalid entry should be type float")}



	// delay loop
	ids := 0
	for i := range(len(delays)){
		for range(v_group_cts[i]){
			wg.Add(1)	// 
			go vehicle(v_info{id: ids, isTruck: rand_bool(float32(prob)),isNorth: rand_bool(.5) }, &wg)
			ids++
		}
		time.Sleep(time.Duration(delays[i]*time.Now().Second()))
	}

	// get last group
	for range(v_group_cts[len(v_group_cts)-1]){
		wg.Add(1)	// 
		go vehicle(v_info{id: ids, isTruck: rand_bool(float32(prob)),isNorth: rand_bool(.5) }, &wg)	
		ids++
	}
	wg.Wait()
	
}