package main

//Fiber is the web framework of choice
import (
  "database/sql"
  "fmt"
  "log"
  "os"
  _ "github.com/lib/pq"

  "github.com/gofiber/fiber/v2"
  "github.com/gofiber/template/html/v2"
)




//creating a new "fiber" object with "fiber.New" and assigning it to the app variable, then assign port environment var to 3000

//App listen starts HTTP server that is listening on port 3000, we call "Fatalln()" to log output to the console if any error occur.
func main() {
  connStr := "postgresql://jc:gopher@localhost/todos?sslmode=disable"

  db, err := sql.Open("postgres", connStr)
  if err != nil {
    log.Fatal(err)
  }
  
  engine := html.New("./views", ".html")
  app := fiber.New(fiber.Config{
    Views: engine,
  })

  //Methods to handle CRUD operations

  app.Get("/", func(c *fiber.Ctx) error {
    return indexHandler(c, db)
  }) 

  app.Post("/",  func(c *fiber.Ctx) error {
    return postHandler(c, db)
  })

  app.Put("/update", func(c *fiber.Ctx) error {
    return putHandler(c, db)
  })
  
  app.Delete("/delete", func(c *fiber.Ctx) error {
    return deleteHandler(c, db)
  })

  port := os.Getenv("PORT")
  if port == "" {
    port = "3000"
  }
  app.Static("/", "./public")
  log.Fatalln(app.Listen(fmt.Sprintf(":%v", port)))
}

func indexHandler(c *fiber.Ctx, db *sql.DB) error {
  var res string
  var todos []string
  
  //We use db object to execute an SQL query on databasewoth Query() func 

  //This returns all the rows that match the query (string passed to Query())

  rows, err := db.Query("SELECT * FROM todos")

  // defer always a good idea to prevent futher enum
  
  defer rows.Close()
  if err != nil {
    log.Fatalln(err)
    c.JSON("An error ocurred")
  }

  for rows.Next() {
    rows.Scan(&res)
    todos = append(todos, res)
  }
  return c.Render("index", fiber.Map{
    "Todos": todos,
  })
}

type todo struct {
  Item string
}

func postHandler(c *fiber.Ctx, db *sql.DB) error {
  new_todo := todo{}
  if err := c.BodyParser(&new_todo); err != nil {
    log.Printf("An error occured: %v", err)
    return c.SendString(err.Error())
  }

  fmt.Printf("%v", new_todo)
  if new_todo.Item != "" {
    _, err := db.Exec("INSERT into todos VALUES ($1)", new_todo.Item)
    if err != nil {
      log.Fatalf("An error occured while executing query: %v", err)
    }
  }

  return c.Redirect("/")
}

func putHandler(c *fiber.Ctx, db *sql.DB) error {
  old_item := c.Query("olditem")
  new_item := c.Query("newitem")
  db.Exec("UPDATE todos SET item=$1 WHERE item=$2", new_item, old_item)
  return c.Redirect("/")
}

func deleteHandler(c *fiber.Ctx, db *sql.DB) error {
  todo_to_delete := c.Query("item")
  db.Exec("DELETE from todos WHERE item=$1", todo_to_delete)
  return c.SendString("deleted")
}
