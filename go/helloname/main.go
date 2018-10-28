package main

import (
    "fmt"
    "io/ioutil"
    "log"
    "net/http"

    "gopkg.in/yaml.v2"
)

const CONFIG_FILE = "/etc/config/hello-name.yaml"

func handler(w http.ResponseWriter, r *http.Request) {
    fmt.Println("Loading config")
    conf := loadConfig(CONFIG_FILE)
    fmt.Fprintf(w, "Hello, %s", conf.Name)
}

func checkErr(err error) {
    if err != nil {
        log.Fatalf("error: %v", err)
    }
}

type Config struct {
    Name string `yaml:"name"`
}

func loadConfig(configFile string) *Config {
    conf := &Config{}
    configData, err := ioutil.ReadFile(configFile)
    checkErr(err)

    err = yaml.Unmarshal(configData, conf)
    checkErr(err)

    return conf
}

func main() {

    http.HandleFunc("/", handler)
    s := &http.Server{Addr: ":8080"}
    err := s.ListenAndServe()
    checkErr(err)
}
