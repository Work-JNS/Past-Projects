package q1

import (
	"fmt"
	"io/ioutil"
	"log"
	"regexp"
	"sort"
	"strings"
)

// Find the top K most common words in a text document.
// 	path: location of the document
//	numWords: number of words to return (i.e. k)
//	charThreshold: character threshold for whether a token qualifies as a word,
//		e.g. charThreshold = 5 means "apple" is a word but "pear" is not.
// Matching is case insensitive, e.g. "Orange" and "orange" is considered the same word.
// A word comprises alphanumeric characters only. All punctuation and other characters
// are removed, e.g. "don't" becomes "dont".
// You should use `checkError` to handle potential errors.
func TopWords(path string, numWords int, charThreshold int) []WordCount {
	// TODO: implement me
	// HINT: You may find the `strings.Fields` and `strings.ToLower` functions helpful
	// HINT: To keep only alphanumeric characters, use the regex "[^0-9a-zA-Z]+"
	if numWords < 1 {
		log.Print("Invalid numWords: must be above 0")
		return nil}

	//compile regex
	re := regexp.MustCompile("[^0-9a-zA-Z]+")

	// open file
	file, err := ioutil.ReadFile(path)
	if err != nil {checkError(err)}

	
	// send file data to string
	f_as_string := string(file)
	// send to lower case
	// convert string to string[] by whitespace
	words := strings.Fields(strings.ToLower(f_as_string))
	

	
	

	
	// create wcounter slice
	var wcounter []WordCount
	// loop through each word
	for i := 0; i<len(words); i++{
		// remove punctuation
		words[i] = re.ReplaceAllString(words[i], "")
		// if lcount is below charThreshold -> skip
		if len(words[i]) < charThreshold {continue}
		
		var existingEntry bool = false 
		for j := range wcounter{
			if strings.Compare(words[i], wcounter[j].Word) == 0 {
				wcounter[j].Count++
				existingEntry = true
				break
			}
		}
		// add to wcounter
		if(!existingEntry){wcounter = append(wcounter, WordCount{Word:words[i], Count:1,})}
		
	}
	

	// sort wcounter slice
	sortWordCounts(wcounter)

	if numWords > len(wcounter) {return wcounter}
	return wcounter[:numWords]
	

}

// A struct that represents how many times a word is observed in a document
type WordCount struct {
	Word  string
	Count int
}

func (wc WordCount) String() string {
	return fmt.Sprintf("%v: %v", wc.Word, wc.Count)
}

// Helper function to sort a list of word counts in place.
// This sorts by the count in decreasing order, breaking ties using the word.
// DO NOT MODIFY THIS FUNCTION!
func sortWordCounts(wordCounts []WordCount) {
	sort.Slice(wordCounts, func(i, j int) bool {
		wc1 := wordCounts[i]
		wc2 := wordCounts[j]
		if wc1.Count == wc2.Count {
			return wc1.Word < wc2.Word
		}
		return wc1.Count > wc2.Count
	})
}
