package mapreduce

import (
	"encoding/json"
	"fmt"
	"io"
	"os"
)



func Decode(decoder json.Decoder, pairs *map[string]interface{}){
	for{
		err := decoder.Decode(pairs)										// Decode File
		if err == io.EOF{return}
	}
	

}

// doReduce does the job of a reduce worker: it reads the intermediate
// key/value pairs (produced by the map phase) for this task, sorts the
// intermediate key/value pairs by key, calls the user-defined reduce function
// (reduceF) for each key, and writes the output to disk.
func doReduce(
	jobName string,       // the name of the whole MapReduce job
	reduceTaskNumber int, // which reduce task this is
	nMap int,             // the number of map tasks that were run ("M" in the paper)
	reduceF func(key string, values []string) string,
) {
	intFiles := make([]*os.File, nMap)							// References to files
	intDecoders := make([]*json.Decoder, nMap)					// JSON decoders for each file
	KvPairs := make([]map[string]interface{}, nMap)				// Holds all pairs divided by file
	file_names := make([]string, nMap)							// retains names of intFiles for removal
	combined := make(map[string][]string)						// holds combined keys & values from all files
	var err error

	// Open files, maps and decoders
	for i := range nMap {
		file_names[i] = reduceName(jobName, i, reduceTaskNumber)	// Get intermediate filename

		intFiles[i], err = os.Open(file_names[i])								// Open intermediate file
		KvPairs[i] = make(map[string]any)										// init file map
		checkError(err)															// Handle errors		
		intDecoders[i] = json.NewDecoder(intFiles[i])							// Open Decoder
		Decode(*intDecoders[i], &KvPairs[i])									// Decode File
		
		
		defer intFiles[i].Close()												// Close all file

	}

	for i := range KvPairs{														// all json files
		for key := range KvPairs[i]{											// all pairs in each json
			combined[key] = append(combined[key], fmt.Sprintf("%v",KvPairs[i][key]))
		}
	}


	outFname := mergeName(jobName, reduceTaskNumber)							// Create File Name
	output, err := os.Create(outFname)											// Create File
	checkError(err)																// Handle Errors
	enc := json.NewEncoder(output)												// Create Encoder

	for k, v := range combined{													// Reduce & Encode Output
		value := reduceF(k, v)
		//pair := map[string]string{ k: value}
		pair := KeyValue{Key: k, Value: value}
		enc.Encode(pair)

	}

	
	
	

	
	// You should write the reduced output in as JSON encoded KeyValue
	// objects to a file named mergeName(jobName, reduceTaskNumber). We require
	// you to use JSON here because that is what the merger than combines the
	// output from all the reduce tasks expects. There is nothing "special" about
	// JSON -- it is just the marshalling format we chose to use. It will look
	// something like this:
	//
	// enc := json.NewEncoder(mergeFile)
	// for key in ... {
	// 	enc.Encode(KeyValue{key, reduceF(...)})
	// }
	// file.Close()
	//
	// Use checkError to handle errors.


}
