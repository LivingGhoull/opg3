const express = require('express')
const app = express()
const mysql = require('mysql')
const bodyParser = require('body-parser')

app.use(bodyParser.urlencoded({ extended: false }))
app.use(bodyParser.json())

app.use(express.static('public'))
app.set('view engine', 'ejs')
const con  = Connection(mysql)


// Project
app.get("/", function (req, res) {    
    con.query("SELECT * FROM project INNER JOIN tasks ON project.taskID = tasks.id", function(err, data){
        if(err) throw err
        res.render('index', {data: data})
    })
})

// Tasks
app.get('/tasks', (req, res) => { 
    con.query("SELECT * FROM tasks", function(err, data){
        if(err) throw err
        res.render('tasks', {data: data})
    })
})

app.post("/tasksDeleteOrUpdate", (req, res) => {
    const id = req.body.id
    const tName = req.body.tName
    const bTime = req.body.bTime
    const eTime = req.body.eTime
    const choice = req.body.choice
    if(choice == "Update"){
        if(Date.parse(bTime) < Date.parse(eTime)){
            con.query("SELECT * FROM tasks WHERE taskName=?", [tName], function(err, data){
                if(err) throw err
                if(data.length < 1){
                    con.query('UPDATE tasks SET taskName=?, beginTime=?, endTime=? WHERE id=?', [tName, bTime, eTime, parseInt(id)])}
            })
        }
    }
    else {
        con.query('DELETE FROM tasks WHERE id=?', [parseInt(id)])}

    res.redirect("/tasks")
})

app.post("/tasksCreate", (req, res) => {
    const tName = req.body.tName
    const bTime = req.body.bTime
    const eTime = req.body.eTime

    if(Date.parse(bTime) < Date.parse(eTime)){
        con.query("SELECT * FROM tasks WHERE taskName=?", [tName], function(err, data){
            if(err) throw err
            if(data.length < 1){
                con.query('INSERT INTO tasks(taskName, beginTime, endTime) VALUES(?, ?, ?)', [tName, bTime, eTime])
            }
        })
    }
    res.redirect("/tasks")
})

// User
app.get('/user', (req, res) => { 
    con.query("SELECT * FROM users", function(err, data){
        if(err) throw err
        res.render('user', {data: data})
    })
})

app.post("/userDeleteOrUpdate", (req, res) => {
    const id = req.body.id
    const fname = req.body.fname
    const lname = req.body.lname
    const choice = req.body.choice

    if (choice == "Update"){
        con.query('UPDATE users SET fname=?, lname=? WHERE id=?', [fname, lname, parseInt(id)])
    }
    else {
        con.query('DELETE FROM users WHERE id=?', [parseInt(id)])}
    res.redirect("/user")
})

app.post("/userCreate", (req, res) => {
    const fname = req.body.fname
    const lname = req.body.lname

    con.query('INSERT INTO users(fname, lname) VALUES(?, ?)', [fname, lname])

    res.redirect("/user")
})

app.listen(8080)

function Connection(mysql){
    const conn = mysql.createConnection({
        host: "localhost",
        user: "root",
        password: "",
        database: "opg3"
    })
    conn.connect(function(err){
        if(err) throw err
        console.log("connection!")
    })
    return conn
}