package main

//Fiber is the web framework of choice
import (
  "database/sql"
  "fmt"
  "log"
  "os"
  _ "github.com/lib/pq"

  "github.com/gofiber/fiber/v2"
)


//creating a new "fiber" object with "fiber.New" and assigning it to the app variable, then assign port environment var to 3000

//App listen starts HTTP server that is listening on port 3000, we call "Fatalln()" to log output to the console if any error occur.
func main() {

  db, err :=c

  app := fiber.New()

  //Methods to handle CRUD operations

  app.Get("/", indexHandler)

  app.Post("/", postHandler)

  app.Put("/update", putHandler)
  
  app.Delete("/delete", deleteHandler)

  port := os.Getenv("PORT")
  if port == "" {
    port = "3000"
  }

  log.Fatalln(app.Listen(fmt.Sprintf(":%v", port)))
}

func indexHandler(c *fiber.Ctx) error {
  return c.SendString("prueba")
}

func postHandler(c *fiber.Ctx) error {
  return c.SendString("prueba")
}

func putHandler(c *fiber.Ctx) error {
  return c.SendString("prueba")
}

func deleteHandler(c *fiber.Ctx) error {
  return c.SendString("Hello")
}
