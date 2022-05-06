const express = require('express')
const app = express()
const mysql = require('mysql')
const bodyParser = require('body-parser')

app.use(bodyParser.urlencoded({ extended: false }))
app.use(bodyParser.json())

app.use(express.static('public'))
app.set('view engine', 'ejs')
const con  = Connection(mysql)



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
        con.query('UPDATE users SET fname=?, lname=? WHERE userID=?', [fname, lname, parseInt(id)])
    }
    else {
        con.query('DELETE FROM users WHERE userID=?', [parseInt(id)])}
    res.redirect("/user")
})

app.post("/userCreate", (req, res) => {
    const fname = req.body.fname
    const lname = req.body.lname

    con.query('INSERT INTO users(fname, lname) VALUES(?, ?)', [fname, lname])

    res.redirect("/user")
})


// Tasks
app.get('/task', (req, res) => { 
    con.query("SELECT * FROM tasks", function(err, data){
        if(err) throw err
        res.render('tasks', {data: data})
    })
})

app.post("/taskDeleteOrUpdate", (req, res) => {
    const id = req.body.id
    const tName = req.body.tName
    const bTime = req.body.bTime
    const eTime = req.body.eTime
    const choice = req.body.choice

    if(choice == "Update"){
        console.log("nr1")
        if(Date.parse(bTime) < Date.parse(eTime)){
            con.query('UPDATE tasks SET taskName=?, beginTime=?, endTime=? WHERE taskID=?', [tName, bTime, eTime, parseInt(id)])}
    }
    else {
        con.query('DELETE FROM tasks WHERE taskID=?', [parseInt(id)])}
    res.redirect("/tasks")
})

app.post("/taskCreate", (req, res) => {
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


// Project
const query = "SELECT * FROM project INNER JOIN users ON users.userID = project.pUserID INNER JOIN tasks ON tasks.taskID = project.pTaskID WHERE project.pTaskID = ?"
app.get("/", function (req, res) {    
    con.query("SELECT * FROM tasks", function(err, data){
        if(err) throw err
        res.render('index', {data: data})
    })
})

app.post("/gantt", (req, res) => {
    const id = req.body.id
    GanttPath(con, id, res)
})

app.post("/ganttDelete", (req, res) => {
    const userID = req.body.userID
    const taskID = req.body.taskID

    con.query('DELETE FROM project WHERE pTaskID=? && pUserID=?', [parseInt(userID), parseInt(taskID)], function(err){
        if(err) throw err
        GanttPath(con, id, res)
    })
})

app.post("/ganttCreate", (req, res) => {
    const userID = req.body.userID
    const taskID = req.body.taskID

    con.query("SELECT * FROM project WHERE pUserID=? && pTaskID",[userID, taskID], function(err, data){
        if(err) throw err
        if(data.length != 1){
            con.query("INSERT INTO project(pUserID, pTaskID) VALUES(?, ?)", [userID, taskID], function(err){
                if(err) throw err
                GanttPath(con, taskID, res)
            })
        }
        GanttPath(con, taskID, res)
    })    
})


//print
app.post('/printTask', (req, res) => { 
    const id = req.body.id
    con.query("SELECT * FROM project INNER JOIN users ON users.userID = project.pUserID INNER JOIN tasks ON tasks.taskID = project.pTaskID WHERE project.pUserID = ?", [id], function(err, data){
        if(err) throw err
        if(data.length != 0){
            res.render('print', {data: data, choice: "user"})}
        else{
            res.redirect("/")}
    })
})


app.post('/printUser', (req, res) => { 
    const id = req.body.id
    con.query(query, [id], function(err, data){
        if(err) throw err
        if(data.length != 0){
            res.render('print', {data: data, choice: "task"})}
        else{
            res.redirect("/")}
    })
})

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

function GanttPath(con, taskID, res) {
    con.query(query, [taskID], function(err, data){
        if(err) throw err
        res.render('gantt', {data: data})
    })
}

app.listen(8080)