package main

import (
	"encoding/json"
	"fmt"
	"github.com/julienschmidt/httprouter"
	"html/template"
	"log"
	"net/http"
)

var NAMES = []string{"yoavlt", "entotsu", "morishitter"}

type Output struct {
	Data []string `json:"data"`
}

type Input struct {
	Hoge string `json:"hoge"`
}

func RenderHtml(w http.ResponseWriter, r *http.Request, _ httprouter.Params) {
	tmpl := template.Must(template.ParseFiles("views/index.html"))

	err := tmpl.ExecuteTemplate(w, "base", NAMES)
	if err != nil {
		log.Fatal("ListenAndServe: ", err)
	}
}

func RenderJson(w http.ResponseWriter, r *http.Request, _ httprouter.Params) {
	json, err := json.Marshal(Output{Data: NAMES})
	if err != nil {
		log.Fatal("ListenAndServe: ", err)
	}
	w.Header().Set("Content-Type", "application/json")
	fmt.Fprint(w, string(json))
}

func PostJson(w http.ResponseWriter, r *http.Request, _ httprouter.Params) {
	decoder := json.NewDecoder(r.Body)
	var input Input
	err := decoder.Decode(&input)
	if err != nil {
		log.Fatal("ListenAndServe: ", err)
	}

	json, err := json.Marshal(Output{Data: NAMES})
	if err != nil {
		log.Fatal("ListenAndServe: ", err)
	}
	w.Header().Set("Content-Type", "application/json")
	fmt.Fprint(w, string(json))
}

func RenderName(w http.ResponseWriter, r *http.Request, ps httprouter.Params) {
	fmt.Fprintf(w, "Hello, %s!", ps.ByName("name"))
}

func main() {
	router := httprouter.New()
	router.GET("/body/:name", RenderName)
	router.GET("/render/html", RenderHtml)
	router.GET("/render/json", RenderJson)
	router.POST("/post/json", RenderJson)

	err := http.ListenAndServe(":4001", router)
	if err != nil {
		log.Fatal("ListenAndServe: ", err)
	}
}
