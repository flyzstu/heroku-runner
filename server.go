package main

import (
	"fmt"
	"log"
	"net/http"
	"os"
)

func sayHello(w http.ResponseWriter, r *http.Request) {
	_, _ = fmt.Fprintf(w, "Hello, World!") //  写入到w的是输出文本到客户端的内容
	fmt.Println("The page was visited.")
}

func main() {
	fmt.Println("func main() has been called.")
	var port = os.Getenv("PORT")
	port = ":" + port
	http.HandleFunc("/", sayHello) //设置访问的路由
	err := http.ListenAndServe(port, nil)
	if err != nil {
		log.Fatal("ListenAndServe:", err)
	}
}
