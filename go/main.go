package main

import (
	"fmt"
	"github.com/julienschmidt/httprouter"
	"html/template"
	"log"
	"net/http"
)

var NAMES = []string{"yoavlt", "entotsu", "morishitter"}

func RenderHtml(w http.ResponseWriter, r *http.Request, _ httprouter.Params) {
	tmpl := template.Must(template.ParseFiles("views/index.html"))

	err := tmpl.ExecuteTemplate(w, "base", NAMES)
	if err != nil {
		log.Fatal("ListenAndServe: ", err)
	}
}

func RenderName(w http.ResponseWriter, r *http.Request, ps httprouter.Params) {
	fmt.Fprintf(w, "Hello, %s!", ps.ByName("name"))
}

func main() {
	router := httprouter.New()
	router.GET("/body/:name", RenderName)
	router.GET("/render/html", RenderHtml)

	err := http.ListenAndServe(":4001", router)
	if err != nil {
		log.Fatal("ListenAndServe: ", err)
	}
}
