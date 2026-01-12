package mapreduce

import (
	"encoding/json"
	"fmt"
	"hash/fnv"
	"os"
)

// doMap does the job of a map worker: it reads one of the input files
// (inFile), calls the user-defined map function (mapF) for that file's
// contents, and partitions the output into nReduce intermediate files.
func doMap(
	jobName string, // the name of the MapReduce job
	mapTaskNumber int, // which map task this is
	input_argument string, //the input argument for the map function
	inFile string,    // name of the input file
	nReduce int, // the number of reduce tasks that will be run ("R" in the paper)
	mapF func(file string, arg string, contents string) []KeyValue,
) {
	// TODO:
	// You will need to write this function.
	// You can find the filename for this map task's input to reduce task number
	// r using reduceName(jobName, mapTaskNumber, r). The ihash function (given
	// below doMap) should be used to decide which file a given key belongs into.
	contents, err := os.ReadFile(inFile)
	checkError(err)

	KeyValues := mapF(inFile, input_argument, string(contents))

	// open nReduce intermediate files for writing
	files := make([]*os.File, nReduce)			// File pointers
	encoders := make([]*json.Encoder, nReduce)	// JSON encoders for each file
	// Make and open files and encoders
	for i := range nReduce {
		mapFileName := fmt.Sprintf("mrtmp.%s-%d-%d", jobName, mapTaskNumber, i)	// Make filename
		file, err := os.Create(mapFileName)									// Create file
		checkError(err)														// Handle errors
		encoders[i] = json.NewEncoder(file)									// Create JSON encoder for the file
		files[i] = file														// Store file pointer
	}


	// Partition KeyValues into nReduce files
	for _, kv := range KeyValues {
		reduceTaskNumber := int(ihash(kv.Key)) % nReduce			// Get reduce task number
		pair := map[string]string{ kv.Key: kv.Value }
		err := encoders[reduceTaskNumber].Encode(pair)				// Encode KeyValue to corresponding file
		checkError(err)												// Handle errors
	}
	
	// Close all files
	for i := range nReduce {
		err := files[i].Close()
		checkError(err)
	}
	// The intermediate output of  map task is stored in the file
	// system as multiple files whose name indicates which map task produced
	// them, as well as which reduce task they are for. Coming up with a
	// scheme for how to store the key/value pairs on disk can be tricky,
	// especially when taking into account that both keys and values could
	// contain newlines, quotes, and any other character you can think of.

	// Partition KeyValues into nReduce files
	
	


	// One format often used for serializing data to a byte stream that the
	// other end can correctly reconstruct is JSON. You are not required to
	// use JSON, but as the output of the reduce tasks *must* be JSON,
	// familiarizing yourself with it here may prove useful. You can write
	// out a data structure as a JSON string to a file using the commented
	// code below. The corresponding decoding functions can be found in
	// common_reduce.go.
	//
	//   enc := json.NewEncoder(file)
	//   for _, kv := ... {
	//     err := enc.Encode(&kv)
	//
	// Remember to close the file after you have written all the values!
	// Use checkError to handle errors.


}

func ihash(s string) uint32 {
	h := fnv.New32a()
	h.Write([]byte(s))
	return h.Sum32()
}
