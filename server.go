package main

//Fiber is the web framework of choice
import (
  "fmt"
  "log"
  "os"

  "github.com/gofiber/fiber/v2"
)


func main() {
  app := fiber.New()
  port := os.Getenv("PORT")
  if port == "" {
    port = "3000"
  }

  log.Fataln(app.Listen(fmt.Sprintf(":%v", port)))
}
