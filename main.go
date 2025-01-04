// server test for jenkins

package main

import (
	"fmt"
	"runtime"
	"github.com/gin-gonic/gin"
)

func main () {

	fmt.Println("Tocal CPU", runtime.NumCPU())

	r := gin.Default()
	
	r.NoRoute(func(c *gin.Context) {
		c.JSON(404, gin.H{
			"message": "routes not found",
		})
	})

	r.GET("/ping", func(c *gin.Context) {
		c.JSON(200, gin.H{
			"message": "pong",
		})
	})

	r.Run()
}