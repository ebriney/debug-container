package main

import (
	"fmt"
	"log"
	"os"
	"path/filepath"
	"strings"
)

func printFile(path string, info os.FileInfo, err error) error {
	if err != nil {
		//		log.Print(err)
		return nil
	}
	var containerRoot = "/fs-debug"
	if !strings.HasPrefix(path, containerRoot) {
		return nil
	}
	var excludePrefix = []string{"/sys", "/proc", "/dev", "/etc"}
	for _, s := range excludePrefix {
		if strings.HasPrefix(path, containerRoot+s) {
			return nil
		}
	}
	var excludeFile = []string{"/", "/.dockerenv"}
	for _, s := range excludeFile {
		if path == containerRoot+s {
			return nil
		}
	}
	fmt.Println(path)
	return nil
}

func main() {
	log.SetFlags(log.Lshortfile)
	dir := "/"
	err := filepath.Walk(dir, printFile)
	if err != nil {
		log.Fatal(err)
	}
}
